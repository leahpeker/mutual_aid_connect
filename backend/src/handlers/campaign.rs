use crate::services::campaign::CampaignService;
use actix_web::{delete, get, post, put, web, HttpResponse, Result};
use rust_decimal::Decimal;
use sea_orm::DbErr;
use serde::{Deserialize, Serialize};
use time::OffsetDateTime;
use uuid::Uuid;

// Request structs for creating and updating campaigns
#[derive(Deserialize, Serialize)]
pub struct CreateCampaignRequest {
    pub title: String,
    pub description: String,
    pub target_amount: Decimal,
    pub location_lat: f64,
    pub location_lng: f64,
    #[serde(deserialize_with = "deserialize_datetime")]
    pub ends_at: OffsetDateTime,
    pub image: String,
}

// Custom deserialization function for OffsetDateTime using the `time` crate
fn deserialize_datetime<'de, D>(deserializer: D) -> Result<OffsetDateTime, D::Error>
where
    D: serde::Deserializer<'de>,
{
    let s: String = Deserialize::deserialize(deserializer)?;
    OffsetDateTime::parse(&s, &time::format_description::well_known::Rfc3339)
        .map_err(serde::de::Error::custom)
}

#[derive(Deserialize)]
pub struct UpdateCampaignRequest {
    pub title: Option<String>,
    pub description: Option<String>,
    pub target_amount: Option<Decimal>,
    pub location_lat: Option<f64>,
    pub location_lng: Option<f64>,
    pub ends_at: Option<OffsetDateTime>,
    pub image: Option<String>,
}

#[get("")]
async fn get_campaigns(service: web::Data<CampaignService>) -> Result<HttpResponse> {
    println!("Received GET request for campaigns");
    let campaigns = service
        .get_campaigns()
        .await
        .map_err(|e| actix_web::error::ErrorInternalServerError(e))?;

    Ok(HttpResponse::Ok().json(campaigns))
}

#[get("/{id}")]
async fn get_campaign_by_id(
    path: web::Path<Uuid>,
    service: web::Data<CampaignService>,
) -> Result<HttpResponse> {
    println!("Received GET request for campaign by id");
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
    service: web::Data<CampaignService>,
) -> Result<HttpResponse> {
    println!("Received POST request for create campaign");
    let user_id = Uuid::parse_str("8cb8aa68-a02b-4497-8f70-b595540ecd70").unwrap();
    match service.create_campaign(campaign.0, user_id).await {
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
    println!("Received PUT request for update campaign");
    match service.update_campaign(campaign_id, campaign.0).await {
        Ok(campaign) => Ok(HttpResponse::Ok().json(campaign)),
        Err(e) => match e {
            DbErr::Custom(msg) if msg == "Campaign not found" => {
                Ok(HttpResponse::NotFound().finish())
            }
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
    println!("Received DELETE request for delete campaign");
    match service.delete_campaign(campaign_id).await {
        Ok(_) => Ok(HttpResponse::NoContent().finish()),
        Err(e) => match e {
            DbErr::Custom(msg) if msg == "Campaign not found" => {
                Ok(HttpResponse::NotFound().finish())
            }
            _ => Err(actix_web::error::ErrorInternalServerError(e)),
        },
    }
}
