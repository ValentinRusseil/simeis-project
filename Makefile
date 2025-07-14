# variables
RUSTFLAGS = -C code-model=kernel -C codegen-units=1 -C strip=symbols

setup-install:
	cargo build
	cargo install typst-cli
	cargo install cargo-tarpaulin

build : Cargo.toml
	cargo build

run : build
	cargo run

test : build
	cargo test --features heavy-testing

release:
	RUSTFLAGS="$(RUSTFLAGS)" cargo build --release

build-manual :
	typst compile ./doc/manual.typ ./doc/manual.pdf

check-code : 
	cargo check --workspace --all-targets --all-features

quality-check :
	cargo check --workspace --all-targets --all-features
	cargo fmt --all --check
	cargo clippy

code-coverage:
	cargo tarpaulin --fail-under 50

functional-test: build-heavy
	bash tests/functional.sh

audit:
	cargo audit

clean :
	cargo clean
