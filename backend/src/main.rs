mod db;
mod handlers;
mod models;

use actix_web::{middleware, web, App, HttpServer};
use db::establish_connection;
use dotenv::dotenv;
use handlers::campaign::*;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenv().ok();

    let pool = establish_connection().await;

    HttpServer::new(move || {
        App::new()
            .app_data(web::Data::new(pool.clone()))
            .wrap(middleware::Logger::default())
            .service(
                web::scope("/api")
                    .service(get_campaigns)
                    .service(get_campaign_by_id)
                    .service(create_campaign)
                    .service(update_campaign)
                    .service(delete_campaign),
            )
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}
