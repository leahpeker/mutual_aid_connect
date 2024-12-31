use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use uuid::Uuid;

#[derive(Debug, Serialize, Deserialize)]
pub struct Campaign {
    pub id: Uuid,
    pub title: String,
    pub description: String,
    pub creator_id: Uuid,
    pub target_amount: f64,
    pub current_amount: f64,
    pub location_lat: f64,
    pub location_lng: f64,
    pub created_at: DateTime<Utc>,
    pub ends_at: DateTime<Utc>,
}

#[derive(Debug, Serialize)]
pub struct CampaignMetadata {
    pub id: Uuid,
    pub title: String,
    pub description: String,
    pub target_amount: f64,
    pub current_amount: f64,
    pub location_lat: f64,
    pub location_lng: f64,
    pub ends_at: DateTime<Utc>,
}
