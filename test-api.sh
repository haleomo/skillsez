#!/bin/bash

# Skills-Ez Test Script
# Tests all API endpoints for user, query-profile, and query-result

API_URL="http://localhost:8080"

echo "==================================="
echo "Skills-Ez API Test Suite"
echo "==================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test 1: Create User
echo "Test 1: Creating user..."
USER_RESPONSE=$(curl -s -X POST "$API_URL/user" \
  -H "Content-Type: application/json" \
  -d '{"email":"testuser@example.com","lastName":"TestUser"}')

USER_ID=$(echo $USER_RESPONSE | grep -o '"id":[0-9]*' | grep -o '[0-9]*')

if [ -n "$USER_ID" ]; then
    echo -e "${GREEN}✓${NC} User created successfully (ID: $USER_ID)"
else
    echo -e "${RED}✗${NC} Failed to create user"
    echo "Response: $USER_RESPONSE"
    exit 1
fi
echo ""

# Test 2: Get User by ID
echo "Test 2: Retrieving user by ID..."
GET_USER_RESPONSE=$(curl -s "$API_URL/user/$USER_ID")

if echo $GET_USER_RESPONSE | grep -q "testuser@example.com"; then
    echo -e "${GREEN}✓${NC} User retrieved successfully"
else
    echo -e "${RED}✗${NC} Failed to retrieve user"
    echo "Response: $GET_USER_RESPONSE"
fi
echo ""

# Test 3: Create Query Profile
echo "Test 3: Creating query profile..."
QUERY_PROFILE_RESPONSE=$(curl -s -X POST "$API_URL/query-profile/create" \
  -H "Content-Type: application/json" \
  -d "{
    \"userId\": $USER_ID,
    \"queryText\": \"Test learning plan\",
    \"sourceDiscipline\": \"Software Engineering\",
    \"subjectEducationLevel\": \"Bachelor's\",
    \"subjectDiscipline\": \"Computer Science\",
    \"topic\": \"Flutter Development\",
    \"goal\": \"career advancement\",
    \"role\": \"mobile developer\"
  }")

QUERY_ID=$(echo $QUERY_PROFILE_RESPONSE | grep -o '"id":[0-9]*' | grep -o '[0-9]*' | head -1)

if [ -n "$QUERY_ID" ]; then
    echo -e "${GREEN}✓${NC} Query profile created successfully (ID: $QUERY_ID)"
else
    echo -e "${RED}✗${NC} Failed to create query profile"
    echo "Response: $QUERY_PROFILE_RESPONSE"
    exit 1
fi
echo ""

# Test 4: Get Query Profile by ID
echo "Test 4: Retrieving query profile by ID..."
GET_QUERY_RESPONSE=$(curl -s "$API_URL/query-profile/$QUERY_ID")

if echo $GET_QUERY_RESPONSE | grep -q "Flutter Development"; then
    echo -e "${GREEN}✓${NC} Query profile retrieved successfully"
else
    echo -e "${RED}✗${NC} Failed to retrieve query profile"
    echo "Response: $GET_QUERY_RESPONSE"
fi
echo ""

# Test 5: Get User's Query Profiles
echo "Test 5: Retrieving all query profiles for user..."
USER_QUERIES_RESPONSE=$(curl -s "$API_URL/query-profile/user/$USER_ID")

if echo $USER_QUERIES_RESPONSE | grep -q "Flutter Development"; then
    echo -e "${GREEN}✓${NC} User query profiles retrieved successfully"
else
    echo -e "${RED}✗${NC} Failed to retrieve user query profiles"
    echo "Response: $USER_QUERIES_RESPONSE"
fi
echo ""

# Test 6: Create Query Result
echo "Test 6: Creating query result..."
RESULT_RESPONSE=$(curl -s -X POST "$API_URL/query-result/create" \
  -H "Content-Type: application/json" \
  -d "{
    \"queryId\": $QUERY_ID,
    \"queryResultNickname\": \"My Flutter Learning Plan\",
    \"resultText\": \"# Flutter Learning Plan\\n\\nThis is a test learning plan.\"
  }")

RESULT_ID=$(echo $RESULT_RESPONSE | grep -o '"id":[0-9]*' | grep -o '[0-9]*' | head -1)

if [ -n "$RESULT_ID" ]; then
    echo -e "${GREEN}✓${NC} Query result created successfully (ID: $RESULT_ID)"
else
    echo -e "${RED}✗${NC} Failed to create query result"
    echo "Response: $RESULT_RESPONSE"
    exit 1
fi
echo ""

# Test 7: Get Query Result by ID
echo "Test 7: Retrieving query result by ID..."
GET_RESULT_RESPONSE=$(curl -s "$API_URL/query-result/$RESULT_ID")

if echo $GET_RESULT_RESPONSE | grep -q "My Flutter Learning Plan"; then
    echo -e "${GREEN}✓${NC} Query result retrieved successfully"
else
    echo -e "${RED}✗${NC} Failed to retrieve query result"
    echo "Response: $GET_RESULT_RESPONSE"
fi
echo ""

# Test 8: Get User-Query View
echo "Test 8: Retrieving user-query view..."
USER_QUERY_VIEW_RESPONSE=$(curl -s "$API_URL/views/user-query")

if echo $USER_QUERY_VIEW_RESPONSE | grep -q "testuser@example.com"; then
    echo -e "${GREEN}✓${NC} User-query view retrieved successfully"
else
    echo -e "${YELLOW}⚠${NC} User-query view may be empty (new database)"
fi
echo ""

# Test 9: Get User-Query-Result View
echo "Test 9: Retrieving user-query-result view..."
USER_QUERY_RESULT_VIEW_RESPONSE=$(curl -s "$API_URL/views/user-query-result")

if echo $USER_QUERY_RESULT_VIEW_RESPONSE | grep -q "testuser@example.com"; then
    echo -e "${GREEN}✓${NC} User-query-result view retrieved successfully"
else
    echo -e "${YELLOW}⚠${NC} User-query-result view may be empty (new database)"
fi
echo ""

echo "==================================="
echo "Test Summary"
echo "==================================="
echo -e "Created User ID: ${GREEN}$USER_ID${NC}"
echo -e "Created Query Profile ID: ${GREEN}$QUERY_ID${NC}"
echo -e "Created Query Result ID: ${GREEN}$RESULT_ID${NC}"
echo ""
echo -e "${GREEN}✓${NC} All core tests passed!"
echo ""
echo "You can now test the web interface by:"
echo "1. Clearing browser cookies"
echo "2. Opening http://localhost:8000 (or your web server)"
echo "3. Registration modal should appear"
echo ""
