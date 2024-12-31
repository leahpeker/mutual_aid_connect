use crate::entities::campaign;
use sea_orm::*;
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
}
