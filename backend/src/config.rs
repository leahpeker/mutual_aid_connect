use serde::Deserialize;

#[derive(Debug, Deserialize)]
pub struct Config {
    pub database_url: String,
    pub server_port: u16,
    pub server_host: String,
}

impl Config {
    pub fn from_env() -> Self {
        Config {
            database_url: std::env::var("DATABASE_URL").expect("DATABASE_URL must be set"),
            server_port: std::env::var("SERVER_PORT")
                .unwrap_or_else(|_| "8080".to_string())
                .parse()
                .expect("SERVER_PORT must be a valid number"),
            server_host: std::env::var("SERVER_HOST").unwrap_or_else(|_| "127.0.0.1".to_string()),
        }
    }
}
