use backend::entities::campaign::Model as CampaignModel;
use backend::services::campaign::CampaignService;
use rust_decimal_macros::dec;
use sea_orm::{DatabaseBackend, DbErr, MockDatabase};
use time::OffsetDateTime;
use uuid::Uuid;

#[actix_web::test]
async fn test_get_campaigns() -> Result<(), DbErr> {
    let test_campaign = CampaignModel {
        id: Uuid::new_v4(),
        title: "Test Campaign".to_string(),
        description: "Test Description".to_string(),
        creator_id: Uuid::new_v4(),
        target_amount: dec!(1000.0),
        current_amount: dec!(500.0),
        location_lat: 33.7490,
        location_lng: -84.3880,
        created_at: OffsetDateTime::now_utc(),
        ends_at: OffsetDateTime::now_utc() + time::Duration::days(30),
    };

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
