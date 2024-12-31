use crate::services::campaign::CampaignService;
use actix_web::{delete, get, post, put, web, HttpResponse, Result};
use rust_decimal::Decimal;
use serde::Deserialize;
use time::OffsetDateTime;
use uuid::Uuid;
use sea_orm::DbErr;

// Request structs for creating and updating campaigns
#[derive(Deserialize)]
pub struct CreateCampaignRequest {
    pub title: String,
    pub description: String,
    pub target_amount: Decimal,
    pub location_lat: f64,
    pub location_lng: f64,
    pub ends_at: OffsetDateTime,
}

#[derive(Deserialize)]
pub struct UpdateCampaignRequest {
    pub title: Option<String>,
    pub description: Option<String>,
    pub target_amount: Option<Decimal>,
    pub location_lat: Option<f64>,
    pub location_lng: Option<f64>,
    pub ends_at: Option<OffsetDateTime>,
}

#[get("")]
async fn get_campaigns(service: web::Data<CampaignService>) -> Result<HttpResponse> {
    let campaigns = service
        .get_campaigns()
        .await
        .map_err(|e| actix_web::error::ErrorInternalServerError(e))?;

    Ok(HttpResponse::Ok().json(campaigns))
}

#[get("/{id}")]
async fn get_campaign_by_id(
    path: web::Path<Uuid>,
    service: web::Data<CampaignService>
) -> Result<HttpResponse> {
    let campaign_id = path.into_inner();
    
    match service.get_campaign_by_id(campaign_id).await {
        Ok(Some(campaign)) => Ok(HttpResponse::Ok().json(campaign)),
        Ok(None) => Ok(HttpResponse::NotFound().finish()),
        Err(e) => Err(actix_web::error::ErrorInternalServerError(e)),
    }
}

#[post("")]
async fn create_campaign(
    campaign: web::Json<CreateCampaignRequest>,
    service: web::Data<CampaignService>
) -> Result<HttpResponse> {
    match service.create_campaign(campaign.0).await {
        Ok(campaign) => Ok(HttpResponse::Created().json(campaign)),
        Err(e) => Err(actix_web::error::ErrorInternalServerError(e)),
    }
}

#[put("/{id}")]
async fn update_campaign(
    path: web::Path<Uuid>,
    campaign: web::Json<UpdateCampaignRequest>,
    service: web::Data<CampaignService>,
) -> Result<HttpResponse> {
    let campaign_id = path.into_inner();
    match service.update_campaign(campaign_id, campaign.0).await {
        Ok(campaign) => Ok(HttpResponse::Ok().json(campaign)),
        Err(e) => match e {
            DbErr::Custom(msg) if msg == "Campaign not found" => Ok(HttpResponse::NotFound().finish()),
            _ => Err(actix_web::error::ErrorInternalServerError(e)),
        },
    }
}

#[delete("/{id}")]
async fn delete_campaign(
    path: web::Path<Uuid>,
    service: web::Data<CampaignService>,
) -> Result<HttpResponse> {
    let campaign_id = path.into_inner();
    match service.delete_campaign(campaign_id).await {
        Ok(_) => Ok(HttpResponse::NoContent().finish()),
        Err(e) => match e {
            DbErr::Custom(msg) if msg == "Campaign not found" => Ok(HttpResponse::NotFound().finish()),
            _ => Err(actix_web::error::ErrorInternalServerError(e)),
        },
    }
}
