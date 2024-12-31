use backend::entities::campaign::Model as CampaignModel;
use rust_decimal_macros::dec;
use time::OffsetDateTime;
use uuid::Uuid;

pub fn test_campaign() -> CampaignModel {
    CampaignModel {
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
    }
}
