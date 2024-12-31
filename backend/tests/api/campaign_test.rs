use backend::entities::campaign::Model as CampaignModel;
use backend::services::campaign::CampaignService;
use rust_decimal_macros::dec;
use sea_orm::{DatabaseBackend, DbErr, MockDatabase};
use time::OffsetDateTime;
use uuid::Uuid;
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
