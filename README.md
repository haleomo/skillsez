# SkillEZ

An AI-powered skill acquisition planning platform that helps people create personalized learning paths using Google's Gemini AI.

## Overview

SkillEZ leverages artificial intelligence to guide users through the process of learning new skills. By analyzing their current knowledge, goals, and available time, the platform generates customized learning plans with actionable steps, resources, and milestones.

## Project Architecture

This project follows a modular, full-stack architecture with four main components:

### 1. **API Server** (`/api`)
- **Technology**: Dart Frog
- **Purpose**: Centralized REST API serving both web and mobile clients
- **Responsibilities**:
  - Gemini AI integration for skill plan generation
  - User authentication and authorization
  - Data persistence and retrieval
  - Business logic processing
  - Rate limiting and API management

### 2. **Web Application** (`/lib`)
- **Technology**: Vanilla JavaScript, HTML, CSS
- **Purpose**: Interactive client-side web interface
- **Responsibilities**:
  - User registration and profile management
  - Learning plan generation form
  - Saved plans management and retrieval
  - Learning plan display and printing
  - Responsive web interface with cookie-based sessions

### 3. **Mobile Application** (`/mobile_app`)
- **Technology**: Flutter
- **Purpose**: Native iOS and Android mobile experience
- **Responsibilities**:
  - On-the-go skill plan access
  - Push notifications for learning reminders
  - Offline capability for viewing plans
  - Progress tracking and gamification
  - Native mobile UX patterns

### 4. **Shared Library** (`/shared`)
- **Technology**: Dart Package
- **Purpose**: Common code shared across all platforms
- **Responsibilities**:
  - Data models (User, SkillPlan, Milestone, etc.)
  - Business logic and validation rules
  - API client interfaces
  - Utility functions and helpers
  - Constants and configuration

## Technology Stack

- **Backend**: Dart Frog REST API
- **Frontend**: Vanilla JavaScript, HTML5, CSS3
- **Database**: MySQL 8.0+
- **AI Integration**: Google Gemini AI
- **Shared Models**: Dart (Freezed + JSON serialization)
- **Mobile**: Flutter (placeholder for future development)

## Key Features

### Current Implementation
- **User Registration Modal**: Automatic registration dialog on first visit with email/name capture
- **AI-Powered Skill Planning**: Generate personalized learning plans using Google Gemini AI
- **Learning Plan Forms**: Structured input for skill level, discipline, background, and learning goals
- **Plan Generation**: AI creates comprehensive plans with objectives, resources, timeline, and assessment methods
- **Saved Plans**: Users can name and save generated plans to database
- **Plan History**: View all previously saved learning plans organized by date
- **Profile Management**: Edit email and last name in user account
- **Plan Display**: Render AI-generated markdown content with proper formatting
- **Plan Printing**: Export learning plans to PDF/print via browser

### Infrastructure
- **UPSERT Operations**: Duplicate prevention via database unique constraints
- **Cookie-Based Sessions**: 365-day persistent user sessions
- **CORS-Enabled API**: Global CORS headers for cross-origin requests
- **Database Views**: Combined user-query-result data for efficient retrieval

## Project Structure

```
skills-ez/
├── api/                           # Dart Frog API Server
│   ├── routes/                    # REST API endpoints
│   │   ├── user/                  # User CRUD (create, read, update)
│   │   ├── query-profile/         # Learning plan query endpoints
│   │   ├── query-result/          # Saved learning plan endpoints
│   │   ├── views/                 # Database view endpoints
│   │   └── learning-plan/         # Gemini AI generation
│   ├── services/                  # Business logic (AI service)
│   ├── lib/database_service.dart  # MySQL connection manager
│   ├── start-frog.sh              # Dev startup script
│   └── .env                       # Environment config (create this)
│
├── lib/                           # Web Frontend (static)
│   ├── index.html                 # Main page with modals
│   ├── main.js                    # Application logic
│   ├── styles.css                 # Styling
│   ├── assets/                    # Images and static assets
│   ├── pages/                     # HTML pages (about, help)
│   └── data/                      # Static data files
│
├── shared/                        # Shared Dart Models Package
│   └── lib/src/models/            # Freezed data models
│       ├── user.dart
│       ├── query_profile_record.dart
│       └── user_query_result_view.dart
│
├── mobile_app/                    # Flutter Mobile (Placeholder)
│   └── lib/main.dart              # Stub implementation
│
├── sql/                           # Database Schema
│   └── create-tables.sql          # Tables and views
│
└── docs/                          # Documentation
    ├── SETUP_GUIDE.md             # Development setup
    ├── API_ROUTES_SUMMARY.md      # API endpoint reference
    └── DATABASE_API.md            # Detailed API docs
```

## Getting Started

### Prerequisites
- Dart SDK (latest stable)
- Flutter SDK (latest stable)
- Google Gemini API key
- MySQL (optional, for database features)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd skills-ez
   ```

2. **Install dependencies**
   ```bash
   # Install shared package dependencies (used by API)
   cd shared
   dart pub get
   dart run build_runner build --delete-conflicting-outputs
   
   # Install API dependencies
   cd ../api
   dart pub get
   
   # Web frontend has no build step (vanilla JS)
   # Mobile app (placeholder - no setup needed yet)
   ```

3. **Configure environment variables**
   ```bash
   # Create .env file in api/
   GEMINI_API_KEY=your_api_key_here
   DB_HOST=localhost
   DB_PORT=3306
   DB_USER=root
   DB_PASSWORD=your_password
   DB_NAME=skills_ez
   ```

4. **Web Application - Configure Environment**
   
   Edit `lib/index.html` and set the `window.ENVIRONMENT` variable:
   ```html
   <script>
       // Set to 'dev' for development, 'prod' for production
       window.ENVIRONMENT = 'dev';
   </script>
   ```
   
   **Environment Configuration:**
   - **dev**: API runs at `http://localhost:8080` (local development)
   - **prod**: API runs at `http://192.168.102.194:8081` (production server)
   
   The web application automatically uses the correct API endpoint based on this setting.

### Database Setup (MySQL)

#### Install MySQL with Homebrew (macOS)

1. **Install MySQL**
   ```bash
   brew install mysql

### Running the Applications

#### API Server (Development)
Set environment variables and start the server:
```bash
cd api
./start-frog.sh    # Loads .env and runs dart_frog dev
# OR manually:
# export GEMINI_API_KEY=your_key DB_HOST=localhost DB_USER=rob ...
# dart_frog dev
```
API server runs on: `http://localhost:8080` with hot reload enabled

#### API Server (Production)
```bash
cd api
# Compile to executable
dart compile exe bin/server.dart -o server
# Or run directly with env vars set
export GEMINI_API_KEY=...
dart run bin/server.dart
```

#### Web Server (Development)
```bash
cd lib
python3 -m http.server 8000
# Open: http://localhost:8000
```
Web frontend automatically calls API at `localhost:8080` (dev) or `192.168.102.194:8080` (prod)

#### Database Setup

**macOS (Homebrew)**
```bash
# Install MySQL
brew install mysql

# Start service (persists across restarts)
brew services start mysql

# Secure installation
mysql_secure_installation

# Connect and create database
mysql -u root -p
CREATE DATABASE skills_ez;
CREATE USER 'skills-ez'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON skills_ez.* TO 'skills-ez'@'localhost';
FLUSH PRIVILEGES;
exit

# Load schema
mysql -u skills-ez -p skills_ez < sql/create-tables.sql

# Stop MySQL when done
brew services stop mysql
```

#### Database Schema

The application uses three main tables with UNIQUE constraints to manage duplicate prevention:

1. **skillsez_user** - Stores user registration information
   - `id`: Primary key (auto-increment)
   - `email`: User's email (UNIQUE constraint)
   - `last_name`: User's last name
   - `created_at`: Registration date
   - **UNIQUE KEY**: `UNI_USER_EMAIL` on `email`

2. **query_profile** - Stores learning plan queries
   - `id`: Primary key (auto-increment)
   - `user_id`: Foreign key referencing skillsez_user
   - `query_date`: Date of the query
   - `query_text`: Original query text
   - `source_discipline`, `subjecteducation_level`, `subject_discipline`: User background
   - `topic`: Subject to learn
   - `goal`: Learning goal
   - `role`: Target role
   - **UNIQUE KEY**: `UNI_QUERY_PROFILE` on `(user_id, source_discipline, subject_discipline, topic, goal, role)`

3. **query_result** - Stores generated learning plans
   - `id`: Primary key (auto-increment)
   - `query_result_nickname`: User-defined name for the plan
   - `query_id`: Foreign key referencing query_profile
   - `result_text`: The generated learning plan content
   - `result_date`: Date the plan was generated
   - **UNIQUE KEY**: `UNI_QUERY_RESULT` on `(query_id, query_result_nickname)`

4. **user_query_view** - View combining user and query information
5. **user_query_result_view** - View combining user, query, and result information

**INSERT ... ON DUPLICATE KEY UPDATE**

All three tables support upsert operations. When inserting duplicate records (based on UNIQUE constraints), the database will automatically UPDATE the existing row instead of raising an error:

- Duplicate user email: Updates `last_name`
- Duplicate query profile: Updates `query_date` and `query_text`
- Duplicate query result: Updates `result_text` and `result_date`

This enables safe "Save Plan" operations even if the user clicks multiple times.

#### Initialize Database

Create the database and tables:
```bash
mysql -u root -p -e "DROP DATABASE IF EXISTS skills_ez; CREATE DATABASE skills_ez;"
mysql -u root -p skills_ez < sql/create-tables.sql
```

#### Mobile Application
```bash
cd mobile_app

# Run on iOS
flutter run -d ios

# Run on Android
flutter run -d android

# Run on web
flutter run -d chrome
```

## Development Workflow

### Shared Package Development
When making changes to shared models or business logic:

1. Update code in `shared/lib/`
2. Run tests: `cd shared && dart test`
3. Changes are automatically available to other projects via path dependency

### API Development
1. Add routes in `api/routes/`
2. Implement business logic using shared package
3. Test with `dart test`
4. Hot reload available during development

### Web Development
1. Edit `lib/index.html` for markup and modals
2. Edit `lib/main.js` for application logic (registration, saved plans, API calls)
3. Edit `lib/styles.css` for styling
4. No build step required—refresh browser to see changes
5. API calls route through `getApiUrl()` which respects `window.ENVIRONMENT`

### Mobile Development
1. Currently a placeholder with "Hello World" example
2. Future: Use Flutter best practices
3. Future: Import shared package for data models

## Additional Resources

- [SETUP_GUIDE.md](SETUP_GUIDE.md) – Detailed development and production setup
- [API_ROUTES_SUMMARY.md](API_ROUTES_SUMMARY.md) – Quick API endpoint reference
- [DATABASE_API.md](api/DATABASE_API.md) – Full API documentation with examples

## License

MIT

---

**Built with Dart, Dart Frog, and Google Gemini AI**
