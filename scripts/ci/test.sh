#!/usr/bin/env bash
# Run unit or integration tests.
# Usage: ./test.sh unit | ./test.sh integration
set -euo pipefail

MODE="${1:-unit}"

case "$MODE" in
  unit)
    echo "--- Running Go unit tests ---"
    go test ./src/checkout/money/...

    echo "--- Running C# unit tests ---"
    dotnet test src/cart/
    ;;
  integration)
    echo "--- Building images ---"
    make build

    echo "--- Running trace-based tests ---"
    make run-tracetesting
    ;;
  *)
    echo "Usage: $0 unit|integration" >&2
    exit 1
    ;;
esac
