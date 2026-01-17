# Skills-Ez API Routes Summary

## Quick Reference

### User Management
- **POST** `/user` - Create new user
- **GET** `/user/[id]` - Get user by ID

### Query Profile Management
- **POST** `/query-profile` - Create query profile
- **GET** `/query-profile/[id]` - Get query profile by ID
- **GET** `/query-profile/user/[userId]` - Get all query profiles for a user

### Query Result Management
- **POST** `/query-result` - Save learning plan result
- **GET** `/query-result/[id]` - Get query result by ID

### View Endpoints (Combined Data)
- **GET** `/views/user-query` - Get all user-query combinations
- **GET** `/views/user-query-result` - Get all user-query-result combinations

### Learning Plan Generation
- **POST** `/learning-plan/generate` - Generate AI learning plan (existing)

## Setup Requirements

### Environment Variables (`.env` file)
```env
GEMINI_API_KEY=your_gemini_api_key
DB_HOST=localhost
DB_PORT=3306
DB_USER=skills-ez
DB_PASSWORD=your_password
DB_NAME=skills_ez
```

### Database Setup
1. Create MySQL database: `skills_ez`
2. Run SQL script: `sql/create-tables.sql`
3. Tables created: `skillsez_user`, `query_profile`, `query_result`
4. Views created: `user_query_view`, `user_query_result_view`

### Install Dependencies
```bash
cd api
dart pub get
```

### Start Server
```bash
dart_frog dev
```

Server runs on: `http://localhost:8080`

## Example Usage Flow

1. **User Registration** (via web popup or API)
   ```bash
   POST /user
   {"email": "user@example.com", "lastName": "Smith"}
   # Returns: {"success": true, "data": {"id": 1, ...}}
   ```

2. **Generate Learning Plan** (existing endpoint)
   ```bash
   POST /learning-plan/generate
   {QueryProfile data}
   # Returns AI-generated plan
   ```

3. **Save Query Profile**
   ```bash
   POST /query-profile/create
   {userId: 1, topic: "Flutter", ...}
   # Returns: {"success": true, "data": {"id": 1, ...}}
   ```

4. **Save Learning Plan Result**
   ```bash
   POST /query-result/create
   {queryId: 1, queryResultNickname: "My Plan", resultText: "..."}
   # Returns: {"success": true, "data": {"id": 1, ...}}
   ```

5. **View All User Queries**
   ```bash
   GET /views/user-query
   # Returns all user-query combinations
   ```

## Documentation

- **Detailed API Docs**: `api/DATABASE_API.md`
- **Original API Docs**: `api/API_USAGE.md`
- **Registration Guide**: `REGISTRATION.md`

## Project Structure

```
api/
├── lib/
│   └── database_service.dart    # Database connection
├── routes/
│   ├── user/
│   │   ├── create.dart          # Create user
│   │   └── [id].dart            # Get user by ID
│   ├── query-profile/
│   │   ├── create.dart          # Create query profile
│   │   ├── [id].dart            # Get query profile
│   │   └── user/[userId].dart   # Get user's profiles
│   ├── query-result/
│   │   ├── create.dart          # Save result
│   │   └── [id].dart            # Get result
│   ├── views/
│   │   ├── user-query.dart      # User-query view
│   │   └── user-query-result.dart # User-query-result view
│   └── learning-plan/
│       └── generate.dart        # AI generation (existing)
└── services/
    └── learning_plan_service.dart
```

## Testing

```bash
# Test user creation
curl -X POST http://localhost:8080/user \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","lastName":"Test"}'

# Test query profile retrieval
curl http://localhost:8080/query-profile/user/1

# Test view
curl http://localhost:8080/views/user-query
```

## Shared Models

All models defined in `shared/lib/src/models/`:
- `User` - User entity
- `QueryProfile` - AI prompt data
- `QueryProfileRecord` - Database record
- `QueryResult` - Learning plan result
- `UserQueryView` - Combined user+query data
- `UserQueryResultView` - Combined user+query+result data

Models use Freezed for immutability and JSON serialization.
