use sea_orm_migration::prelude::*;

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        // Create users table
        manager
            .create_table(
                Table::create()
                    .table(User::Table)
                    .if_not_exists()
                    .col(ColumnDef::new(User::Id).uuid().not_null().primary_key())
                    .col(ColumnDef::new(User::Username).string().not_null().unique_key())
                    .col(ColumnDef::new(User::Email).string().not_null().unique_key())
                    .col(ColumnDef::new(User::PasswordHash).string().not_null())
                    .col(ColumnDef::new(User::CreatedAt).timestamp_with_time_zone().not_null())
                    .to_owned(),
            )
            .await?;

        // Create campaigns table
        manager
            .create_table(
                Table::create()
                    .table(Campaign::Table)
                    .if_not_exists()
                    .col(ColumnDef::new(Campaign::Id).uuid().not_null().primary_key())
                    .col(ColumnDef::new(Campaign::Title).string().not_null())
                    .col(ColumnDef::new(Campaign::Description).text().not_null())
                    .col(ColumnDef::new(Campaign::CreatorId).uuid().not_null())
                    .col(ColumnDef::new(Campaign::TargetAmount).decimal().not_null())
                    .col(ColumnDef::new(Campaign::CurrentAmount).decimal().not_null())
                    .col(ColumnDef::new(Campaign::LocationLat).double().not_null())
                    .col(ColumnDef::new(Campaign::LocationLng).double().not_null())
                    .col(ColumnDef::new(Campaign::CreatedAt).timestamp_with_time_zone().not_null())
                    .col(ColumnDef::new(Campaign::EndsAt).timestamp_with_time_zone().not_null())
                    .foreign_key(
                        ForeignKey::create()
                            .name("fk_campaign_creator")
                            .from(Campaign::Table, Campaign::CreatorId)
                            .to(User::Table, User::Id)
                    )
                    .to_owned(),
            )
            .await?;

        // Insert seed data
        manager
            .exec_stmt(
                Query::insert()
                    .into_table(User::Table)
                    .columns([User::Id, User::Username, User::Email, User::PasswordHash, User::CreatedAt])
                    .values_panic([
                        "a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11".into(),
                        "john_doe".into(),
                        "john@example.com".into(),
                        "dummy_hash_1".into(),
                        "NOW()".into(),
                    ])
                    .values_panic([
                        "b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12".into(),
                        "jane_smith".into(),
                        "jane@example.com".into(),
                        "dummy_hash_2".into(),
                        "NOW()".into(),
                    ])
                    .values_panic([
                        "c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13".into(),
                        "bob_wilson".into(),
                        "bob@example.com".into(),
                        "dummy_hash_3".into(),
                        "NOW()".into(),
                    ])
                    .values_panic([
                        "d0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14".into(),
                        "alice_brown".into(),
                        "alice@example.com".into(),
                        "dummy_hash_4".into(),
                        "NOW()".into(),
                    ])
                    .values_panic([
                        "e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15".into(),
                        "charlie_davis".into(),
                        "charlie@example.com".into(),
                        "dummy_hash_5".into(),
                        "NOW()".into(),
                    ])
                    .to_owned()
            )
            .await?;

        manager
            .exec_stmt(
                Query::insert()
                    .into_table(Campaign::Table)
                    .columns([
                        Campaign::Id, Campaign::Title, Campaign::Description, 
                        Campaign::CreatorId, Campaign::TargetAmount, Campaign::CurrentAmount,
                        Campaign::LocationLat, Campaign::LocationLng, 
                        Campaign::CreatedAt, Campaign::EndsAt
                    ])
                    .values_panic([
                        "f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16".into(),
                        "Community Garden Project".into(),
                        "Help us build a community garden in downtown Atlanta".into(),
                        "a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11".into(),
                        "5000.00".into(),
                        "2500.00".into(),
                        "33.7490".into(),
                        "-84.3880".into(),
                        "NOW()".into(),
                        "(NOW() + INTERVAL '30 days')".into(),
                    ])
                    .values_panic([
                        "g0eebc99-9c0b-4ef8-bb6d-6bb9bd380a17".into(),
                        "Food Bank Drive".into(),
                        "Supporting local families in need with essential groceries".into(),
                        "b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12".into(),
                        "3000.00".into(),
                        "1200.00".into(),
                        "33.7590".into(),
                        "-84.3920".into(),
                        "NOW()".into(),
                        "(NOW() + INTERVAL '45 days')".into(),
                    ])
                    .values_panic([
                        "h0eebc99-9c0b-4ef8-bb6d-6bb9bd380a18".into(),
                        "Emergency Relief Fund".into(),
                        "Providing immediate assistance to those affected by recent storms".into(),
                        "c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13".into(),
                        "10000.00".into(),
                        "7500.00".into(),
                        "33.7690".into(),
                        "-84.4000".into(),
                        "NOW()".into(),
                        "(NOW() + INTERVAL '60 days')".into(),
                    ])
                    .values_panic([
                        "i0eebc99-9c0b-4ef8-bb6d-6bb9bd380a19".into(),
                        "Youth Education Program".into(),
                        "Supporting after-school programs for underprivileged youth".into(),
                        "d0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14".into(),
                        "7500.00".into(),
                        "3200.00".into(),
                        "33.7790".into(),
                        "-84.3860".into(),
                        "NOW()".into(),
                        "(NOW() + INTERVAL '90 days')".into(),
                    ])
                    .values_panic([
                        "j0eebc99-9c0b-4ef8-bb6d-6bb9bd380a20".into(),
                        "Senior Support Initiative".into(),
                        "Helping elderly neighbors with essential services and companionship".into(),
                        "e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15".into(),
                        "4000.00".into(),
                        "1800.00".into(),
                        "33.7890".into(),
                        "-84.3750".into(),
                        "NOW()".into(),
                        "(NOW() + INTERVAL '75 days')".into(),
                    ])
                    .to_owned()
            )
            .await?;

        Ok(())
    }

    async fn down(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .drop_table(Table::drop().table(Campaign::Table).to_owned())
            .await?;
        manager
            .drop_table(Table::drop().table(User::Table).to_owned())
            .await?;
        Ok(())
    }
}

#[derive(DeriveIden)]
enum User {
    Table,
    Id,
    Username,
    Email,
    PasswordHash,
    CreatedAt,
}

#[derive(DeriveIden)]
enum Campaign {
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
}