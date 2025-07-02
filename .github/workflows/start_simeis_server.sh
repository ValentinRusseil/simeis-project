#!/bin/sh

echo "Starting Simeis server..."
if cargo run --release; then
    echo "Simeis server started successfully."
else
    echo "Failed to start Simeis server."