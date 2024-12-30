mod models;
mod handlers;

use actix_web::{web, App, HttpServer, middleware};
use handlers::campaign::get_campaigns;
use handlers::campaign::get_campaign_by_id;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        App::new()
            .wrap(middleware::Logger::default())
            .service(
                web::scope("/api")
                    .service(get_campaigns)
                    .service(get_campaign_by_id)
            )
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}
