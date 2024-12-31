mod config;
mod db;
mod entities;
mod handlers;
mod routes;
mod services;

use actix_web::{middleware, web, App, HttpServer};
use config::Config;
use db::establish_connection;
use routes::campaign::campaign_routes;
use services::campaign::CampaignService;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenv::dotenv().ok();

    let config = Config::from_env();
    let db = establish_connection().await;
    let campaign_service = web::Data::new(CampaignService::new(db));

    HttpServer::new(move || {
        App::new()
            .app_data(campaign_service.clone())
            .wrap(middleware::Logger::default())
            .service(web::scope("/api").configure(campaign_routes))
    })
    .bind((config.server_host, config.server_port))?
    .run()
    .await
}
