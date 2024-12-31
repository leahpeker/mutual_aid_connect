use rust_decimal::Decimal;
use serde::{Deserialize, Serialize};
use time::OffsetDateTime;
use uuid::Uuid;

#[derive(Debug, Serialize, Deserialize)]
pub struct Campaign {
    pub id: Uuid,
    pub title: String,
    pub description: String,
    pub creator_id: Uuid,
    pub target_amount: Decimal,
    pub current_amount: Decimal,
    pub location_lat: f64,
    pub location_lng: f64,
    pub created_at: OffsetDateTime,
    pub ends_at: OffsetDateTime,
}

#[derive(Debug, Serialize)]
pub struct CampaignMetadata {
    pub id: Uuid,
    pub title: String,
    pub description: String,
    pub target_amount: Decimal,
    pub current_amount: Decimal,
    pub location_lat: f64,
    pub location_lng: f64,
    pub ends_at: OffsetDateTime,
}
