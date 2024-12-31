use rust_decimal::Decimal;
use sea_orm::entity::prelude::*;
use serde::Serialize;
use time::OffsetDateTime;

#[derive(Clone, Debug, PartialEq, DeriveEntityModel, Serialize)]
#[sea_orm(table_name = "campaigns")]
pub struct Model {
    #[sea_orm(primary_key, auto_increment = false)]
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

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {}

impl ActiveModelBehavior for ActiveModel {}
