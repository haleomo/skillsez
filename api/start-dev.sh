#!/bin/bash

# Load environment variables from .env file and start dart_frog dev
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
    echo "Environment variables loaded from .env"
else
    echo "Warning: .env file not found"
fi

# Start dart_frog dev server
dart_frog dev
