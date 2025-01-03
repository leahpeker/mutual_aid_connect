use sea_orm_migration::prelude::*;
use sea_orm::Value;
use uuid::Uuid;

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .create_table(
                Table::create()
                    .table(Users::Table)
                    .if_not_exists()
                    .col(ColumnDef::new(Users::Id).uuid().not_null().primary_key())
                    .col(ColumnDef::new(Users::Username).string().not_null().unique_key())
                    .col(ColumnDef::new(Users::Email).string().not_null().unique_key())
                    .col(ColumnDef::new(Users::PasswordHash).string().not_null())
                    .col(ColumnDef::new(Users::CreatedAt).timestamp_with_time_zone().not_null())
                    .to_owned(),
            )
            .await?;
    
        manager
            .create_table(
                Table::create()
                    .table(Campaigns::Table)
                    .if_not_exists()
                    .col(ColumnDef::new(Campaigns::Id).uuid().not_null().primary_key())
                    .col(ColumnDef::new(Campaigns::Title).string().not_null())
                    .col(ColumnDef::new(Campaigns::Description).text().not_null())
                    .col(ColumnDef::new(Campaigns::CreatorId).uuid().not_null())
                    .col(ColumnDef::new(Campaigns::TargetAmount).decimal().not_null())
                    .col(ColumnDef::new(Campaigns::CurrentAmount).decimal().not_null())
                    .col(ColumnDef::new(Campaigns::LocationLat).double().not_null())
                    .col(ColumnDef::new(Campaigns::LocationLng).double().not_null())
                    .col(ColumnDef::new(Campaigns::CreatedAt).timestamp_with_time_zone().not_null())
                    .col(ColumnDef::new(Campaigns::EndsAt).timestamp_with_time_zone().not_null())
                    .col(ColumnDef::new(Campaigns::Image).string().not_null()) // New column
                    .foreign_key(
                        ForeignKey::create()
                            .name("fk_campaign_creator")
                            .from(Campaigns::Table, Campaigns::CreatorId)
                            .to(Users::Table, Users::Id),
                    )
                    .to_owned(),
            )
            .await?;
    
        Ok(())
    }
    

    async fn down(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .drop_table(Table::drop().table(Campaigns::Table).to_owned())
            .await?;
        manager
            .drop_table(Table::drop().table(Users::Table).to_owned())
            .await?;
        Ok(())
    }
}

#[derive(DeriveIden)]
enum Users {
    Table,
    Id,
    Username,
    Email,
    PasswordHash,
    CreatedAt,
}

#[derive(DeriveIden)]
enum Campaigns {
    Table,
    Id,
    Title,
    Description,
    CreatorId,
    TargetAmount,
    CurrentAmount,
    LocationLat,
    LocationLng,
    CreatedAt,
    EndsAt,
    Image,
}