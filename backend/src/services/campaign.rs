use crate::entities::campaign;
use crate::handlers::campaign::{CreateCampaignRequest, UpdateCampaignRequest};
use rust_decimal::Decimal;
use sea_orm::*;
use time::OffsetDateTime;
use uuid::Uuid;
use sea_orm::ActiveValue::Set;

pub struct CampaignService {
    db: DatabaseConnection,
}

impl CampaignService {
    pub fn new(db: DatabaseConnection) -> Self {
        Self { db }
    }

    pub async fn get_campaigns(&self) -> Result<Vec<campaign::Model>, DbErr> {
        campaign::Entity::find()
            .order_by_asc(campaign::Column::CreatedAt)
            .all(&self.db)
            .await
    }

    pub async fn get_campaign_by_id(&self, id: Uuid) -> Result<Option<campaign::Model>, DbErr> {
        campaign::Entity::find_by_id(id)
            .one(&self.db)
            .await
    }

    pub async fn create_campaign(&self, req: CreateCampaignRequest) -> Result<campaign::Model, DbErr> {
        let campaign = campaign::ActiveModel {
            id: Set(Uuid::new_v4()),
            title: Set(req.title),
            description: Set(req.description),
            creator_id: Set(Uuid::new_v4()), // TODO: Get from auth context
            target_amount: Set(req.target_amount),
            current_amount: Set(Decimal::ZERO),
            location_lat: Set(req.location_lat),
            location_lng: Set(req.location_lng),
            created_at: Set(OffsetDateTime::now_utc()),
            ends_at: Set(req.ends_at),
        };

        campaign.insert(&self.db).await
    }

    pub async fn update_campaign(&self, id: Uuid, req: UpdateCampaignRequest) -> Result<campaign::Model, DbErr> {
        let campaign = campaign::Entity::find_by_id(id)
            .one(&self.db)
            .await?
            .ok_or(DbErr::Custom("Campaign not found".to_string()))?;

        let mut campaign: campaign::ActiveModel = campaign.into();

        if let Some(title) = req.title {
            campaign.title = Set(title);
        }
        if let Some(description) = req.description {
            campaign.description = Set(description);
        }
        if let Some(target_amount) = req.target_amount {
            campaign.target_amount = Set(target_amount);
        }
        if let Some(location_lat) = req.location_lat {
            campaign.location_lat = Set(location_lat);
        }
        if let Some(location_lng) = req.location_lng {
            campaign.location_lng = Set(location_lng);
        }
        if let Some(ends_at) = req.ends_at {
            campaign.ends_at = Set(ends_at);
        }

        campaign.update(&self.db).await
    }

    pub async fn delete_campaign(&self, id: Uuid) -> Result<(), DbErr> {
        let result = campaign::Entity::delete_by_id(id)
            .exec(&self.db)
            .await?;

        if result.rows_affected == 0 {
            return Err(DbErr::Custom("Campaign not found".to_string()));
        }

        Ok(())
    }
}
