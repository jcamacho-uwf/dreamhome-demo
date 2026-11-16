#!/usr/bin/env bash
# 03_requests.sh
# The API requests for Parts 3 and 4.
#
# Usage:
#   ./03_requests.sh 1   all listings            (Part 3b)
#   ./03_requests.sh 2   filtered listings       (Part 3c)
#   ./03_requests.sh 3   the client table        (Part 4)
#
# First time only:  chmod +x 03_requests.sh

# ---- Fill these in before class (Project Settings -> Data API / API Keys) ----
SUPABASE_URL="https://qzubtozzhoyjfbzbkvxe.supabase.co"
PUBLISHABLE_KEY="sb_publishable_BJ3dtjCwY5DnLClmA0T0jQ_QjIJpV7e"
# ------------------------------------------------------------------------------

# -s hides the progress meter; -w prints the HTTP status code after the body,
# so the class can see "HTTP 200" even when the result is a leak or empty.
STATUS='\n\nHTTP %{http_code}\n'

case "$1" in
  1)
    echo "GET all properties (SELECT * FROM property_for_rent)"
    echo
    curl -s -w "$STATUS" \
      "$SUPABASE_URL/rest/v1/property_for_rent?select=*" \
      -H "apikey: $PUBLISHABLE_KEY"
    ;;
  2)
    echo "GET Glasgow properties under 400, cheapest first"
    echo
    curl -s -w "$STATUS" \
      "$SUPABASE_URL/rest/v1/property_for_rent?select=street,rent&city=eq.Glasgow&rent=lt.400&order=rent.asc" \
      -H "apikey: $PUBLISHABLE_KEY"
    ;;
  3)
    echo "GET the client table (SELECT * FROM client)"
    echo
    curl -s -w "$STATUS" \
      "$SUPABASE_URL/rest/v1/client?select=*" \
      -H "apikey: $PUBLISHABLE_KEY"
    ;;
  *)
    echo "Usage: ./03_requests.sh 1 | 2 | 3"
    exit 1
    ;;
esac
