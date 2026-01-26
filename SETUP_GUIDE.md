# Skills-Ez: Setup & Operations Guide

This guide reflects the current application state: Dart Frog API with MySQL backend, static web UI in `lib/`, saved plans, profile editing (PUT /user/[id]), and CORS handled globally.

## Current API Surface

**User**
- `POST /user` – upsert by email (returns `id`)
- `GET /user/[id]`
- `PUT /user/[id]` – update `email`, `lastName`

**Query Profile**
- `POST /query-profile` – upsert (userId + topic/goal/role unique)
- `GET /query-profile/[id]`
- `GET /query-profile/user/[userId]`

**Query Result (Learning Plan)**
- `POST /query-result` – upsert by (query_id, nickname)
- `GET /query-result/[id]`

**Views**
- `GET /views/user-query`
- `GET /views/user-query-result` (includes `resultId`, `queryId`)

**AI Generation**
- `POST /learning-plan/generate` – Gemini-powered plan

## Prerequisites
- Dart SDK 3.10+
- MySQL 8.0+
- Gemini API key

## Database Setup

```bash
mysql -u root -p
CREATE DATABASE skills_ez;
exit

# Create user and load schema
mysql -u root -p < sql/CREATE\ USER\ 'skills-ez'@'localhost'\ IDEN.sql
mysql -u root -p skills_ez < sql/create-tables.sql
```

## Environment Configuration

Create `api/.env` (or export env vars before start):

```env
GEMINI_API_KEY=your_gemini_api_key
DB_HOST=localhost
DB_PORT=3306
DB_USER=skills-ez
DB_PASSWORD=your_mysql_password
DB_NAME=skills_ez
```

> Tip: You can also use `api/start-frog.sh` (sets env and runs `dart_frog dev`). Update credentials in that script for your machine.

## Install Dependencies & Codegen

```bash
# shared models
cd shared
dart pub get
dart run build_runner build --delete-conflicting-outputs

# API
cd ../api
dart pub get
```

## Run Locally

### API (dev)

```bash
cd api
./start-frog.sh    # sets env + dart_frog dev
# or: dart_frog dev
```

Serves at `http://localhost:8080` with CORS enabled for all origins.

### Web UI (static)

```bash
cd lib
python3 -m http.server 8000
```

Open `http://localhost:8000`. The UI will call the API at `localhost:8080` (dev) or `192.168.102.194:8081` (prod) depending on `window.ENVIRONMENT`.

## Key Frontend Flows
- Registration modal creates `skillsez_user` cookie `{ email, lastName, userId }` (or a declined marker).
- Saved plans modal lists plans via `/views/user-query-result`, filtered by email; selecting loads query profile and displays plan.
- Edit Profile uses `PUT /user/[id]` and updates the cookie.

## Production Notes
- Run API without hot-reload:
  ```bash
  cd api
  dart run bin/server.dart
  # or compile: dart compile exe bin/server.dart -o server
  # set env (GEMINI_API_KEY, DB_*) before launching
  ```
- Frontend: serve `lib/` static assets via nginx/Apache/S3; set `window.ENVIRONMENT='prod'` and point DNS to your API host.
- CORS: middleware allows all origins by default; tighten in `routes/_middleware.dart` if needed.
- Systemd/example: create a service that exports env vars then runs the compiled server.

## Testing
- Shared models: `cd shared && dart test` (if present)
- API: `cd api && dart test` (or targeted route tests)
- Smoke test: generate a plan from UI, save it, reopen from Saved Plans, edit profile, confirm cookie updates.

## Project Structure (high-level)

```
skills-ez/
├─ api/                # Dart Frog API
│  ├─ routes/          # REST + view endpoints
│  ├─ services/        # Gemini integration
│  ├─ lib/             # database_service
│  └─ start-frog.sh    # dev startup (sets env)
├─ shared/             # Freezed models (path dependency)
├─ lib/                # Static web UI (index.html, main.js, styles.css)
├─ sql/                # Schema and views
└─ test-api.sh         # API smoke script
```

## Notes & Tips
- Ensure MySQL user in `DB_USER` has rights on `skills_ez`.
- If CORS errors occur, confirm API is reachable and middleware is loaded.
- After model changes in `shared/`, rerun build_runner with `--delete-conflicting-outputs`.
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
