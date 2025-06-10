use tracing::info;

fn main() {
    // Set up simple logging to stdout
    tracing_subscriber::fmt()
        .with_target(false)
        .with_timer(tracing_subscriber::fmt::time::uptime()) // Time since start
        .init();

    info!("Hello, world!");
}
