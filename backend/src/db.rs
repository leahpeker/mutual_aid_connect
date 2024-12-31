use sqlx::postgres::PgPool;
use std::env;

pub async fn establish_connection() -> PgPool {
    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set");

    PgPool::connect(&database_url)
        .await
        .expect("Failed to create pool")
}
