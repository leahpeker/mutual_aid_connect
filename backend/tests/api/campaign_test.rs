use backend::services::campaign::CampaignService;
use rust_decimal_macros::dec;
use sea_orm::{DatabaseBackend, DbErr, MockDatabase, MockExecResult};
use backend::handlers::campaign::{CreateCampaignRequest, UpdateCampaignRequest};
use crate::common::fixtures::test_campaign;

#[actix_web::test]
async fn test_get_campaigns() -> Result<(), DbErr> {
    let test_campaign = test_campaign();

    // Create a mock CampaignService
    let db = MockDatabase::new(DatabaseBackend::Postgres)
        .append_query_results(vec![vec![test_campaign.clone()]])
        .into_connection();

    // Mock the get_campaigns function to return a predefined result
    assert_eq!(
        CampaignService::new(db).get_campaigns().await,
        Ok(vec![test_campaign.clone()])
    );

    Ok(())
}

#[actix_web::test]
async fn test_get_campaign_by_id() -> Result<(), DbErr> {
    let test_campaign = test_campaign();

    let db = MockDatabase::new(DatabaseBackend::Postgres)
        .append_query_results(vec![
            vec![test_campaign.clone()],
        ])
        .into_connection();

    assert_eq!(
        CampaignService::new(db).get_campaign_by_id(test_campaign.id).await,
        Ok(Some(test_campaign.clone()))
    );

    Ok(())
}

#[actix_web::test]
async fn test_create_campaign() -> Result<(), DbErr> {
    let mut test_campaign = test_campaign();
    test_campaign.current_amount = dec!(0.0);
    
    let db = MockDatabase::new(DatabaseBackend::Postgres)
        .append_query_results(vec![
            vec![test_campaign.clone()],
        ])
        .into_connection();

    let create_request = CreateCampaignRequest {
        title: test_campaign.title.clone(),
        description: test_campaign.description.clone(),
        target_amount: test_campaign.target_amount,
        location_lat: test_campaign.location_lat,
        location_lng: test_campaign.location_lng,
        ends_at: test_campaign.ends_at,
    };

    let result = CampaignService::new(db)
        .create_campaign(create_request)
        .await?;

    assert_eq!(result.title, test_campaign.title);
    assert_eq!(result.description, test_campaign.description);
    assert_eq!(result.target_amount, test_campaign.target_amount);
    assert_eq!(result.location_lat, test_campaign.location_lat);
    assert_eq!(result.location_lng, test_campaign.location_lng);
    assert_eq!(result.current_amount, dec!(0.0));

    Ok(())
}

#[actix_web::test]
async fn test_update_campaign() -> Result<(), DbErr> {
    let mut test_campaign = test_campaign();
    let updated_campaign = {
        let mut c = test_campaign.clone();
        c.title = "Updated Title".to_string();
        c
    };
    
    let db = MockDatabase::new(DatabaseBackend::Postgres)
        .append_query_results(vec![
            vec![test_campaign.clone()], // For find_by_id
            vec![updated_campaign.clone()], // For update result
        ])
        .into_connection();

    let update_request = UpdateCampaignRequest {
        title: Some("Updated Title".to_string()),
        description: None,
        target_amount: None,
        location_lat: None,
        location_lng: None,
        ends_at: None,
    };

    let result = CampaignService::new(db)
        .update_campaign(test_campaign.id, update_request)
        .await?;

    assert_eq!(result.title, "Updated Title");
    assert_eq!(result.description, test_campaign.description);

    Ok(())
}

#[actix_web::test]
async fn test_delete_campaign() -> Result<(), DbErr> {
    let test_campaign = test_campaign();
    
    let db = MockDatabase::new(DatabaseBackend::Postgres)
        .append_exec_results(vec![
            MockExecResult {
                last_insert_id: 0,
                rows_affected: 1,
            },
        ])
        .into_connection();

    let result = CampaignService::new(db)
        .delete_campaign(test_campaign.id)
        .await;

    assert!(result.is_ok());

    Ok(())
}
