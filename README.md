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
- **Technology**: JASPR (Server-Side Rendered)
- **Purpose**: SEO-friendly public website
- **Responsibilities**:
  - Landing pages and marketing content
  - Blog and educational resources
  - Server-rendered skill plan views for SEO
  - User registration and authentication flows
  - Responsive web interface

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

- **Language**: Dart
- **Backend Framework**: Dart Frog
- **Web Framework**: JASPR (Server-Side Rendering)
- **Mobile Framework**: Flutter
- **AI Integration**: Google Gemini AI
- **Package Management**: Dart Pub

## Key Features

### Core Functionality
- **AI-Powered Skill Planning**: Generate comprehensive learning plans using Gemini AI
- **Personalized Recommendations**: Tailored content based on user background and goals
- **Progress Tracking**: Monitor learning milestones and achievements
- **Resource Curation**: AI-curated learning materials, courses, and tutorials
- **Time Management**: Realistic timelines based on user availability

### Advanced Features
- **Multi-Platform Support**: Seamless experience across web and mobile
- **SEO Optimization**: Server-rendered content for better discoverability
- **Offline Access**: View skill plans without internet connection (mobile)
- **Social Features**: Share plans and progress with others
- **Analytics**: Track learning patterns and optimize recommendations

## Project Structure

```
skills-ez/
├── api/                    # Dart Frog API Server
│   ├── routes/            # API endpoints
│   └── test/              # API tests
│
├── lib/                   # JASPR Web Application
│   ├── components/        # Reusable UI components
│   ├── pages/            # Web pages/routes
│   ├── constants/        # Web-specific constants
│   ├── main.server.dart  # Server entry point
│   └── main.client.dart  # Client hydration entry
│
├── mobile_app/           # Flutter Mobile App
│   ├── lib/              # Mobile app source
│   ├── android/          # Android configuration
│   ├── ios/              # iOS configuration
│   ├── linux/            # Linux desktop
│   ├── macos/            # macOS desktop
│   ├── windows/          # Windows desktop
│   └── web/              # Web build
│
└── shared/               # Shared Dart Package
    ├── lib/              # Shared source code
    │   └── src/          # Implementation files
    └── test/             # Shared tests
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
   # Install API dependencies
   cd api
   dart pub get
   
   # Install shared package dependencies
   cd ../shared
   dart pub get
   
   # Install web app dependencies
   cd ..
   dart pub get
   
   # Install mobile app dependencies
   cd mobile_app
   flutter pub get
   ```

3. **Configure environment variables**
   ```bash
   # Create .env file in api/
   GEMINI_API_KEY=your_api_key_here
   DATABASE_URL=your_database_url
   JWT_SECRET=your_jwt_secret
   ```

### Database Setup (MySQL)

#### Install MySQL with Homebrew (macOS)

1. **Install MySQL**
   ```bash
   brew install mysql

### Running the Applications

#### API Server
```bash
cd api
dart run build_runner build
dart run bin/server.dart
# Server runs on http://localhost:8080
```

#### Web Server (Mac)
# Development
$ cd lib (run this in the lib directory so the paths are all correct.)
$ python3 -m http.server
Serving HTTP on :: port 8000 (http://[::]:8000/) ...

#### MySQL Database Setup
# Launch MySQL as a background service (persists across restarts)
install mysql on macos brew

brew services start mysql

# Check service status
brew services list

# Start MySQL in the foreground
mysql.server start

# Stop MySQL when done
mysql.server stop

# Run mysql_secure_installation
## Follow the prompts in the terminal to:
### Set a password for the root user.
### Remove anonymous users.
### Disallow remote root login.
### Remove the test database.
### Reload privilege tables. 

Connect to MySQL
mysql -u root (rob4MySQL77)

After securing the installation, you can connect to the MySQL server using the following command and entering the password you just set: 
mysql -u root -p

# Stop MySQL
brew services stop mysql

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
1. Add/update components in `lib/components/`
2. Create pages in `lib/pages/`
3. Server-side rendering ensures SEO optimization
4. Test with `jaspr serve`

### Mobile Development
1. Use Flutter best practices
2. Import shared package for data models
3. Hot reload available during development
4. Test on multiple platforms

## API Integration

All API calls use the shared client interface:

```dart
import 'package:shared/shared.dart';

final client = SkillEZApiClient(baseUrl: 'https://api.skillez.app');

// Generate a skill plan
final plan = await client.generateSkillPlan(
  skill: 'Flutter Development',
  currentLevel: 'Beginner',
  targetLevel: 'Advanced',
  timeCommitment: '10 hours/week',
);
```

## Adding Query and Result Save Routes to API

Prompt: Create a route in the API to save the query profile, query results, and user into the database. Also provide routes to retrieve the user, query profile, and query results. Also, provide routes to retrive a list of user-query, and user-query-results using the views. The tables and views are defined in the file: /Users/robnelson/projects/flutter_project/skills-ez/sql/create-tables.sql

Now I'll create the API with database support. I'll:

  Update pubspec.yaml to include MySQL/database package
  Create a database service
  Create routes for user, query_profile, and query_result CRUD operations
  Create routes for retrieving from views

Now I'll create a database service:

Created database_service.dart

Now I'll create models for the database operations. First, let me extend the shared package with database models:

Read query_profile.dart, lines 1 to 40

Now I'll create additional models for database records. First, let me create a User model:

Now update the shared package's main export file:

Edited
shared.dart+5-0
Now let me generate the Freezed files. First, let me check the pubspec.yaml for shared:

Read pubspec.yaml

Good, the dependencies are there. Now let me run the build_runner:

cd /Users/robnelson/projects/flutter_project/skills-ez/shared && dart run build_runner build --delete-conflicting-outputs

## Required Tables
mysql -u root -p -e "DROP DATABASE IF EXISTS skills_ez; CREATE DATABASE skills_ez;"
mysql -u root -p skills_ez --database=skills_ez < sql/create-tables.sql

## Contributing

1. Create a feature branch
2. Make your changes
3. Run all tests across projects
4. Submit a pull request

## Testing

```bash
# Test all projects
./scripts/test_all.sh

# Test individual projects
cd api && dart test
cd shared && dart test
cd mobile_app && flutter test
```

## License

[Choose appropriate license]

## Contact

[Contact information or link to issue tracker]

---

**Built with ❤️ using Dart, Flutter, JASPR, and Dart Frog**
