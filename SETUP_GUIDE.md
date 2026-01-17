# Skills-Ez: Complete Setup Guide

## What's Been Implemented

### 1. Database API Routes ✅
Created complete CRUD operations for all database tables:

**User Management:**
- Create user: `POST /user/create`
- Get user by ID: `GET /user/[id]`

**Query Profile Management:**
- Create profile: `POST /query-profile/create`
- Get profile by ID: `GET /query-profile/[id]`
- Get user's profiles: `GET /query-profile/user/[userId]`

**Query Result Management:**
- Save learning plan: `POST /query-result/create`
- Get result by ID: `GET /query-result/[id]`

**View Endpoints:**
- User-query data: `GET /views/user-query`
- User-query-result data: `GET /views/user-query-result`

### 2. User Registration Popup ✅
Implemented a modal that appears on first page visit:

**Features:**
- Shows automatically if no registration cookie exists
- Two options: "Save" (register) or "Decline" (anonymous)
- Integrates with `/user/create` API endpoint
- Creates browser cookie for 365-day persistence
- Modern, animated design with backdrop blur

**Cookie Data:**
- Registered: `{email, lastName, userId}`
- Declined: `{email: "declined@skills-ez.me", lastName: "Declined"}`

### 3. Shared Models ✅
Created Freezed models for database entities:
- `User` - User records
- `QueryProfileRecord` - Query profile records
- `QueryResult` - Learning plan results
- `UserQueryView` - Combined user+query data
- `UserQueryResultView` - Combined user+query+result data

### 4. Database Service ✅
Singleton service managing MySQL connections:
- Auto-connects using environment variables
- Supports connection pooling
- Error handling and logging

## Quick Start

### Prerequisites
- Dart SDK 3.10.0+
- MySQL 8.0+
- Gemini API key

### Step 1: Database Setup

```bash
# Create database
mysql -u root -p
CREATE DATABASE skills_ez;
exit

# Create user and run schema
mysql -u root -p < sql/CREATE\ USER\ \'skills-ez\'@\'localhost\'\ IDEN.sql
mysql -u root -p skills_ez < sql/create-tables.sql
```

### Step 2: Environment Configuration

```bash
# Copy example env file
cd api
cp .env.example .env

# Edit .env with your credentials
nano .env
```

Required variables:
```env
GEMINI_API_KEY=your_gemini_api_key
DB_HOST=localhost
DB_PORT=3306
DB_USER=skills-ez
DB_PASSWORD=your_mysql_password
DB_NAME=skills_ez
```

### Step 3: Install Dependencies

```bash
# Install shared package dependencies
cd shared
dart pub get
dart run build_runner build --delete-conflicting-outputs

# Install API dependencies
cd ../api
dart pub get
```

### Step 4: Start the API Server

```bash
cd api
dart_frog dev
```

Server runs on: `http://localhost:8080`

### Step 5: Start the Web Server

```bash
# In project root
cd lib
python3 -m http.server 8000
```

Web app runs on: `http://localhost:8000`

## Testing

### Automated API Tests

```bash
# Run the test script
./test-api.sh
```

This tests all endpoints and creates sample data.

### Manual Testing

1. **Test Registration Modal:**
   - Clear browser cookies
   - Visit `http://localhost:8000`
   - Modal should appear automatically
   - Try both "Save" and "Decline"

2. **Test API Endpoints:**
   ```bash
   # Create user
   curl -X POST http://localhost:8080/user/create \
     -H "Content-Type: application/json" \
     -d '{"email":"test@example.com","lastName":"Test"}'
   
   # Get user (replace 1 with actual ID)
   curl http://localhost:8080/user/1
   ```

3. **Test Learning Plan Generation:**
   - Fill out the form on the homepage
   - Click "Generate learning plan"
   - Check that plan displays correctly

## Project Structure

```
skills-ez/
├── api/                          # Dart Frog API
│   ├── lib/
│   │   └── database_service.dart # Database connection
│   ├── routes/
│   │   ├── user/                 # User endpoints
│   │   ├── query-profile/        # Query profile endpoints
│   │   ├── query-result/         # Query result endpoints
│   │   ├── views/                # View endpoints
│   │   └── learning-plan/        # AI generation
│   ├── services/
│   │   └── learning_plan_service.dart
│   ├── .env                      # Environment config (create this)
│   └── DATABASE_API.md           # Detailed API docs
├── shared/                       # Shared models package
│   └── lib/src/models/           # Freezed models
├── lib/                          # Web frontend
│   ├── index.html                # Main page with registration modal
│   ├── main.js                   # JS with registration logic
│   └── styles.css                # Styles including modal
├── sql/                          # Database schema
│   └── create-tables.sql
├── test-api.sh                   # Automated API tests
├── API_ROUTES_SUMMARY.md         # Quick API reference
└── REGISTRATION.md               # Registration system docs
```

## How It Works

### User Registration Flow

1. **Page Load:** `checkUserRegistration()` checks for cookie
2. **No Cookie:** Registration modal displays
3. **User Saves:**
   - Form data sent to `POST /user/create`
   - User saved to database
   - Cookie created with user ID
   - Modal closes
4. **User Declines:**
   - Cookie created with decline values
   - Modal closes
5. **Subsequent Visits:** Cookie exists, modal doesn't show

### Learning Plan Generation Flow

1. User fills out learning profile form
2. Form data sent to `POST /learning-plan/generate`
3. API calls Gemini AI with optimized prompt
4. Response parsed and displayed on page
5. **(Future)** Save to database with `POST /query-result/create`

### Database Schema

**Tables:**
- `skillsez_user` - User accounts
- `query_profile` - Learning profile queries
- `query_result` - Generated learning plans

**Views:**
- `user_query_view` - User + Query Profile joined
- `user_query_result_view` - User + Query + Result joined

## Next Steps

### Immediate Enhancements
1. Link learning plan generation to database
   - Save query profile on form submission
   - Save generated plan as query result
   - Display user's saved plans

2. User dashboard
   - View all saved plans
   - Edit/delete plans
   - Track progress

3. Authentication
   - Email verification
   - Password protection
   - Session management

### Future Features
- Export plans to PDF
- Share plans with others
- Progress tracking
- Plan templates
- Mobile app integration

## Documentation

- **API Routes:** `api/DATABASE_API.md`
- **Registration System:** `REGISTRATION.md`
- **Quick Reference:** `API_ROUTES_SUMMARY.md`
- **Original API Docs:** `api/API_USAGE.md`

## Troubleshooting

### API won't start
- Check `.env` file exists and has correct values
- Verify MySQL is running: `mysql.server status`
- Test database connection: `mysql -u skills-ez -p skills_ez`

### Modal not showing
- Clear browser cookies
- Check browser console for JavaScript errors
- Verify `main.js` is loading

### Database connection fails
- Check MySQL credentials in `.env`
- Verify database exists: `mysql -u root -p -e "SHOW DATABASES;"`
- Check user permissions

### API tests fail
- Ensure API server is running
- Check database is accessible
- Verify all tables exist

## Support

For issues or questions:
1. Check documentation files
2. Review browser console / API logs
3. Test with `test-api.sh`
4. Check database directly with MySQL client

---

**Built with:** Dart Frog, MySQL, Vanilla JS, Gemini AI
