#!/usr/bin/env bash
# Outputs a newline-separated list of service tag_suffixes whose Dockerfile
# directory changed between BASE_SHA and HEAD_SHA.
# Usage: BASE_SHA=<sha> HEAD_SHA=<sha> ./changed-packages.sh
set -euo pipefail

BASE_SHA="${BASE_SHA:-}"
HEAD_SHA="${HEAD_SHA:-HEAD}"

# Map of tag_suffix → Dockerfile directory (relative to repo root)
declare -A SERVICE_DIRS=(
  [accounting]=src/accounting
  [ad]=src/ad
  [cart]=src/cart/src
  [checkout]=src/checkout
  [currency]=src/currency
  [email]=src/email
  [flagd-ui]=src/flagd-ui
  [fraud-detection]=src/fraud-detection
  [frontend]=src/frontend
  [frontend-proxy]=src/frontend-proxy
  [frontend-tests]=src/frontend
  [image-provider]=src/image-provider
  [kafka]=src/kafka
  [llm]=src/llm
  [load-generator]=src/load-generator
  [opensearch]=src/opensearch
  [payment]=src/payment
  [product-catalog]=src/product-catalog
  [product-reviews]=src/product-reviews
  [quote]=src/quote
  [recommendation]=src/recommendation
  [shipping]=src/shipping
  [telemetry-docs]=src/telemetry-docs
  [traceBasedTests]=test/tracetesting
)

for service in "${!SERVICE_DIRS[@]}"; do
  dir="${SERVICE_DIRS[$service]}"
  if [ -z "$BASE_SHA" ]; then
    echo "$service"
    continue
  fi
  if git diff --name-only "$BASE_SHA" "$HEAD_SHA" -- "$dir" | grep -q .; then
    echo "$service"
  fi
done
