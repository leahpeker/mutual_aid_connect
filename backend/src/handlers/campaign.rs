use crate::models::campaign::Campaign;
use crate::services::campaign::CampaignService;
use actix_web::{delete, get, post, put, web, HttpResponse, Result};
use chrono::DateTime;
use chrono::Utc;
use serde::Deserialize;
use uuid::Uuid;

// Request structs for creating and updating campaigns
#[derive(Deserialize)]
pub struct CreateCampaignRequest {
    pub title: String,
    pub description: String,
    pub target_amount: f64,
    pub location_lat: f64,
    pub location_lng: f64,
    pub ends_at: DateTime<Utc>,
}

#[derive(Deserialize)]
pub struct UpdateCampaignRequest {
    pub title: Option<String>,
    pub description: Option<String>,
    pub target_amount: Option<f64>,
    pub location_lat: Option<f64>,
    pub location_lng: Option<f64>,
    pub ends_at: Option<DateTime<Utc>>,
}

#[get("/campaigns")]
async fn get_campaigns(service: web::Data<CampaignService>) -> Result<HttpResponse> {
    let campaigns = service
        .get_campaigns()
        .await
        .map_err(|e| actix_web::error::ErrorInternalServerError(e))?;

    Ok(HttpResponse::Ok().json(campaigns))
}

#[get("/campaigns/{id}")]
async fn get_campaign_by_id(path: web::Path<Uuid>) -> Result<HttpResponse> {
    let campaign_id = path.into_inner();
    // TODO: Replace with DB query
    let campaign = Campaign {
        id: campaign_id,
        title: "Test Campaign".to_string(),
        description: "Test Description".to_string(),
        creator_id: Uuid::new_v4(),
        target_amount: 1000.0,
        current_amount: 500.0,
        location_lat: 33.7490,
        location_lng: -84.3880,
        created_at: Utc::now(),
        ends_at: Utc::now() + chrono::Duration::days(30),
    };

    Ok(HttpResponse::Ok().json(campaign))
}

#[post("/campaigns")]
async fn create_campaign(campaign: web::Json<CreateCampaignRequest>) -> Result<HttpResponse> {
    // TODO: Replace with DB insert
    let new_campaign = Campaign {
        id: Uuid::new_v4(),
        title: campaign.title.clone(),
        description: campaign.description.clone(),
        creator_id: Uuid::new_v4(), // TODO: Get from auth context
        target_amount: campaign.target_amount,
        current_amount: 0.0,
        location_lat: campaign.location_lat,
        location_lng: campaign.location_lng,
        created_at: Utc::now(),
        ends_at: campaign.ends_at,
    };

    Ok(HttpResponse::Created().json(new_campaign))
}

#[put("/campaigns/{id}")]
async fn update_campaign(
    path: web::Path<Uuid>,
    campaign: web::Json<UpdateCampaignRequest>,
) -> Result<HttpResponse> {
    let campaign_id = path.into_inner();
    // TODO: Replace with DB update

    Ok(HttpResponse::Ok().json(format!("Campaign {} updated", campaign_id)))
}

#[delete("/campaigns/{id}")]
async fn delete_campaign(path: web::Path<Uuid>) -> Result<HttpResponse> {
    let campaign_id = path.into_inner();
    // TODO: Replace with DB delete

    Ok(HttpResponse::NoContent().finish())
}
