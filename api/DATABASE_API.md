# Database API Routes Documentation

This document describes all the API routes for managing users, query profiles, and query results.

## User Endpoints

### POST `/user`
Creates a new user in the database.

**Request Body:**
```json
{
  "email": "user@example.com",
  "lastName": "Smith"
}
```

**Response (201):**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "email": "user@example.com",
    "lastName": "Smith"
  }
}
```

**Error Responses:**
- `400`: Missing or invalid `email` or `lastName`
- `400`: Invalid JSON format
- `500`: Internal server error

---

### GET `/user/[id]`
Retrieves a user by ID.

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "email": "user@example.com",
    "lastName": "Smith",
    "createdAt": "2024-01-15T10:30:00.000Z"
  }
}
```

**Error Responses:**
- `404`: User not found
- `400`: Invalid user ID format
- `500`: Internal server error

---

## Query Profile Endpoints

### POST `/query-profile`
Creates a new query profile in the database.

**Request Body:**
```json
{
  "userId": 1,
  "queryText": "Learning plan for Flutter",
  "sourceDiscipline": "Software Engineering",
  "subjectEducationLevel": "Bachelor's Degree",
  "subjectDiscipline": "Computer Science",
  "topic": "Flutter Mobile Development",
  "goal": "career advancement",
  "role": "mobile developer"
}
```

**Response (201):**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "userId": 1,
    "topic": "Flutter Mobile Development"
  }
}
```

**Error Responses:**
- `400`: Missing required fields (`userId`, `topic`)
- `400`: Invalid JSON format
- `500`: Internal server error

---

### GET `/query-profile/[id]`
Retrieves a query profile by ID.

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "userId": 1,
    "queryDate": "2024-01-15T10:30:00.000Z",
    "queryText": "Learning plan for Flutter",
    "sourceDiscipline": "Software Engineering",
    "subjectEducationLevel": "Bachelor's Degree",
    "subjectDiscipline": "Computer Science",
    "topic": "Flutter Mobile Development",
    "goal": "career advancement",
    "role": "mobile developer"
  }
}
```

**Error Responses:**
- `404`: Query profile not found
- `400`: Invalid query profile ID format
- `500`: Internal server error

---

### GET `/query-profile/user/[userId]`
Retrieves all query profiles for a specific user.

**Response (200):**
```json
{
  "success": true,
  "data": {
    "count": 2,
    "queryProfiles": [
      {
        "id": 2,
        "userId": 1,
        "queryDate": "2024-01-15T12:00:00.000Z",
        "queryText": "Latest query",
        "sourceDiscipline": "Software Engineering",
        "subjectEducationLevel": "Bachelor's Degree",
        "subjectDiscipline": "Computer Science",
        "topic": "Dart Backend Development",
        "goal": "skill development",
        "role": "backend developer"
      },
      {
        "id": 1,
        "userId": 1,
        "queryDate": "2024-01-15T10:30:00.000Z",
        "queryText": "Learning plan for Flutter",
        "sourceDiscipline": "Software Engineering",
        "subjectEducationLevel": "Bachelor's Degree",
        "subjectDiscipline": "Computer Science",
        "topic": "Flutter Mobile Development",
        "goal": "career advancement",
        "role": "mobile developer"
      }
    ]
  }
}
```

**Error Responses:**
- `400`: Invalid user ID format
- `500`: Internal server error

---

## Query Result Endpoints

### POST `/query-result`
Creates a new query result (learning plan) in the database.

**Request Body:**
```json
{
  "queryId": 1,
  "queryResultNickname": "Flutter Learning Path",
  "resultText": "# Comprehensive Flutter Learning Plan\n\n## Phase 1: Fundamentals..."
}
```

**Response (201):**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "queryId": 1,
    "nickname": "Flutter Learning Path"
  }
}
```

**Error Responses:**
- `400`: Missing required fields (`queryId`, `queryResultNickname`, `resultText`)
- `400`: Invalid JSON format
- `500`: Internal server error

---

### GET `/query-result/[id]`
Retrieves a query result by ID.

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "queryResultNickname": "Flutter Learning Path",
    "queryId": 1,
    "resultText": "# Comprehensive Flutter Learning Plan\n\n## Phase 1: Fundamentals...",
    "resultDate": "2024-01-15T10:35:00.000Z"
  }
}
```

**Error Responses:**
- `404`: Query result not found
- `400`: Invalid query result ID format
- `500`: Internal server error

---

## View Endpoints

### GET `/views/user-query`
Retrieves all user-query records from the `user_query_view`, combining user and query profile data.

**Response (200):**
```json
{
  "success": true,
  "data": {
    "count": 2,
    "userQueries": [
      {
        "userId": 1,
        "email": "user@example.com",
        "lastName": "Smith",
        "createdAt": "2024-01-15T10:00:00.000Z",
        "queryId": 2,
        "queryDate": "2024-01-15T12:00:00.000Z",
        "queryText": "Latest query",
        "sourceDiscipline": "Software Engineering",
        "subjectEducationLevel": "Bachelor's Degree",
        "subjectDiscipline": "Computer Science",
        "topic": "Dart Backend Development",
        "goal": "skill development",
        "role": "backend developer"
      },
      {
        "userId": 1,
        "email": "user@example.com",
        "lastName": "Smith",
        "createdAt": "2024-01-15T10:00:00.000Z",
        "queryId": 1,
        "queryDate": "2024-01-15T10:30:00.000Z",
        "queryText": "Learning plan for Flutter",
        "sourceDiscipline": "Software Engineering",
        "subjectEducationLevel": "Bachelor's Degree",
        "subjectDiscipline": "Computer Science",
        "topic": "Flutter Mobile Development",
        "goal": "career advancement",
        "role": "mobile developer"
      }
    ]
  }
}
```

**Error Responses:**
- `500`: Internal server error

---

### GET `/views/user-query-result`
Retrieves all user-query-result records from the `user_query_result_view`, combining user, query, and result data.

**Response (200):**
```json
{
  "success": true,
  "data": {
    "count": 2,
    "userQueryResults": [
      {
        "email": "user@example.com",
        "lastName": "Smith",
        "queryResultNickname": "Latest Learning Plan",
        "resultText": "# Advanced Dart Patterns...",
        "resultDate": "2024-01-15T12:05:00.000Z"
      },
      {
        "email": "user@example.com",
        "lastName": "Smith",
        "queryResultNickname": "Flutter Learning Path",
        "resultText": "# Comprehensive Flutter Learning Plan...",
        "resultDate": "2024-01-15T10:35:00.000Z"
      }
    ]
  }
}
```

**Error Responses:**
- `500`: Internal server error

---

## Environment Setup

Create a `.env` file in the `api` directory with the following variables:

```env
# Gemini AI Configuration
GEMINI_API_KEY=your_gemini_api_key_here

# Database Configuration
DB_HOST=localhost
DB_PORT=3306
DB_USER=skills-ez
DB_PASSWORD=your_mysql_password_here
DB_NAME=skills_ez
```

## Starting the Server

```bash
# Development with hot reload
dart_frog dev

# Production build
dart_frog build
```

The API will be available at `http://localhost:8080`.

## Database Schema

The following tables are used:

- **skillsez_user**: Stores user information (id, email, last_name, created_at)
- **query_profile**: Stores query profiles linked to users
- **query_result**: Stores query results (learning plans) linked to query profiles
- **user_query_view**: View combining skillsez_user and query_profile data
- **user_query_result_view**: View combining skillsez_user, query_profile, and query_result data

Refer to `sql/create-tables.sql` for the complete schema definition.
