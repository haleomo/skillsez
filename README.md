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
$ python3 -m http.server
Serving HTTP on :: port 8000 (http://[::]:8000/) ...


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
