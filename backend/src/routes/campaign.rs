use crate::handlers::campaign::*;
use actix_web::web;

pub fn campaign_routes(cfg: &mut web::ServiceConfig) {
    cfg.service(
        web::scope("/campaigns")
            .service(get_campaigns)
            .service(get_campaign_by_id)
            .service(create_campaign)
            .service(update_campaign)
            .service(delete_campaign),
    );
}
