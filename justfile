_default:
    @just --list

binary_name := "env-verify"

format:
    @cargo fmt

lint: format
    @cargo clippy --all-targets --all-features -- -D warnings -D clippy::pedantic

test: lint
    @cargo test

run:
    @cargo run

generate-module-graph:
    @mkdir -p media
    @cargo modules dependencies --no-externs --no-fns --no-sysroot --no-traits --no-types --no-uses -p {{binary_name}} | dot -Tsvg > media/{{binary_name}}-modules.svg
    @cargo modules dependencies --no-sysroot --no-traits --no-types --no-uses -p {{binary_name}} | dot -Tsvg > media/{{binary_name}}-externs.svg

#
# Build targets
#

build: lint
    @cargo build

build-arm: lint
    @cargo build --target=aarch64-unknown-linux-gnu

build-release: lint
    @cargo build --release

build-arm-release: lint
    @cargo build --target=aarch64-unknown-linux-gnu --release
