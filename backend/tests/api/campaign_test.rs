use actix_web::{test, web, App};
use backend::routes; // Note: your crate name might be different

#[actix_web::test]
async fn test_get_campaigns() {
    println!("Running get campaigns test!"); // Debug print

    // Setup
    let app = test::init_service(
        App::new().service(web::scope("/api").configure(routes::campaign::campaign_routes)),
    )
    .await;

    // Act
    let req = test::TestRequest::get().uri("/api/campaigns").to_request();
    let resp = test::call_service(&app, req).await;

    // Assert
    assert!(resp.status().is_success());
}
