use actix_web::{test, web, App};
use backend::{routes, services::campaign::CampaignService};
use sea_orm::{Database, DatabaseConnection};

#[actix_web::test]
async fn test_get_campaigns() {
    // Setup test database
    let db: DatabaseConnection =
        Database::connect("postgres://leahpeker@localhost:5432/mutual_aid_connect_test")
            .await
            .unwrap();
    let campaign_service = web::Data::new(CampaignService::new(db));

    // Setup app
    let app = test::init_service(
        App::new()
            .app_data(campaign_service)
            .service(web::scope("/api").configure(routes::campaign::campaign_routes)),
    )
    .await;

    // Act
    let req = test::TestRequest::get().uri("/api/campaigns").to_request();
    let resp = test::call_service(&app, req).await;

    // Assert
    assert!(resp.status().is_success());
}
