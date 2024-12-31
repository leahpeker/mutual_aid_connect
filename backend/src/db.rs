use sea_orm::*;

pub async fn establish_connection() -> DatabaseConnection {
    Database::connect(std::env::var("DATABASE_URL").expect("DATABASE_URL must be set"))
        .await
        .expect("Failed to connect to database")
}
