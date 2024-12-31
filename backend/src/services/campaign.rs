use crate::entities::campaign;
use crate::handlers::campaign::CreateCampaignRequest;
use rust_decimal::Decimal;
use sea_orm::*;
use time::OffsetDateTime;
use uuid::Uuid;
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
        campaign::Entity::find_by_id(id).one(&self.db).await
    }

    pub async fn create_campaign(
        &self,
        campaign: CreateCampaignRequest,
    ) -> Result<campaign::Model, DbErr> {
        let campaign = campaign::ActiveModel {
            id: Set(Uuid::new_v4()),
            title: Set(campaign.title),
            description: Set(campaign.description),
            target_amount: Set(campaign.target_amount),
            current_amount: Set(Decimal::ZERO),
            location_lat: Set(campaign.location_lat),
            location_lng: Set(campaign.location_lng),
            created_at: Set(OffsetDateTime::now_utc()),
            ends_at: Set(campaign.ends_at),
            ..Default::default()
        };

        campaign.insert(&self.db).await
    }
}
