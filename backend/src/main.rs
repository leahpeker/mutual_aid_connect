mod models;

use actix_web::{web, App, HttpServer, middleware};

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        App::new()
            .wrap(middleware::Logger::default())
            .service(
                web::scope("/api")
                    // Routes will be added here
            )
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}
