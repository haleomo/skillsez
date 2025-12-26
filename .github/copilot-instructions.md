# Copilot Instructions for skills-ez

## Architecture Overview

**Monorepo structure**: Full-stack Dart skill planning app with 3 independent modules sharing a common domain package:
- **Web (SSR)**: Jaspr server-rendered site in [lib](../lib) - [main.server.dart](../lib/main.server.dart) pre-renders, [main.client.dart](../lib/main.client.dart) hydrates client components
- **API**: Dart Frog REST server in [api](../api) exposing learning plan generation via Google Gemini AI
- **Mobile**: Flutter app stub in [mobile_app](../mobile_app) (currently placeholder with "Hello World")
- **Shared**: Common models package in [shared](../shared) imported as `path:` dependencies across all modules

**Data flow**: Web/mobile clients → API routes (`/learning-plan/generate`) → `LearningPlanService` → Gemini AI → structured JSON response

## Web App (Jaspr SSR)

**Routing**: Routes declared in [lib/app.dart](../lib/app.dart) using `jaspr_router`. Current routes: `/` (Home), `/about` (About)
- Top-level layout in `div.main` wraps `Header` + `Router` - no separate layout component
- [lib/components/header.dart](../lib/components/header.dart) renders site nav; uses `context.url` to highlight active route
- Register new routes in `App`'s `Router(routes: [...])` array

**@client annotation**: Components marked `@client` (e.g., [lib/pages/home.dart](../lib/pages/home.dart), [lib/pages/about.dart](../lib/pages/about.dart)) are compiled to JS and hydrated on client. Everything else is server-only.
- Use `@client` for interactivity (state, events, `kIsWeb` checks)
- Stateless, non-interactive components can omit `@client` for server-only rendering

**Styling pattern**: CSS defined via static `@css` getters returning `List<StyleRule>` inside each component
- Example: `css('header').styles(display: .flex, padding: .all(1.em))`
- Jaspr auto-injects these into `<head>` during SSR
- Reuse theme tokens: `primaryColor` from [lib/constants/theme.dart](../lib/constants/theme.dart) (`const primaryColor = Color('#01589B')`)
- Global styles (fonts, body reset) live in [lib/main.server.dart](../lib/main.server.dart) `Document(styles: [...])`
- Use Jaspr's type-safe CSS DSL: `.flex`, `1.em`, `100.vh`, `EdgeInsets.symmetric(...)`, `BorderRadius.circular(...)`

**Navigation**: Use `Link(to: '/path')` from `jaspr_router` for client-side routing (see [header.dart](../lib/components/header.dart))

## API Server (Dart Frog)

**Routing convention**: File-based routing mirrors URL structure
- `api/routes/learning-plan/generate.dart` → `POST /learning-plan/generate`
- Each route file exports `Future<Response> onRequest(RequestContext context)`

**Request/response pattern** (see [api/routes/learning-plan/generate.dart](../api/routes/learning-plan/generate.dart)):
1. Check `context.request.method` - return `405` for non-POSTs
2. Parse body: `jsonDecode(await context.request.body())`
3. Deserialize into shared model: `QueryProfile.fromJson(requestData)`
4. Call service layer: `LearningPlanService().generateLearningPlan(queryProfile)`
5. Wrap response: `jsonEncode({'success': true, 'data': {...}})`
6. Catch `FormatException` → `400`, generic exceptions → `500`

**AI service integration**: [api/services/learning_plan_service.dart](../api/services/learning_plan_service.dart)
- Reads `GEMINI_API_KEY` from `Platform.environment` - throws if missing
- Constructs prompt from `QueryProfile` fields in `_buildPrompt()`
- POSTs to `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent`
- Extracts text from `responseData['candidates'][0]['content']['parts'][0]['text']`
- Returns `Map<String, dynamic>` (learning plan structure)

**Environment setup**: Copy `api/.env.example` → `api/.env` and set `GEMINI_API_KEY=your_key_here`

## Shared Package (Domain Models)

**Models location**: [shared/lib/src/models](../shared/lib/src/models) - exported via [shared/lib/shared.dart](../shared/lib/shared.dart)

**Freezed + JSON serialization pattern**: Models use `@freezed` (immutable data classes) + `@JsonSerializable`
- Example: `QueryProfile` has 8 required string fields (`sourceExpertDiscipline`, `subjectEducationLevel`, `topic`, `goal`, `role`, etc.)
- Generated files: `*.freezed.dart` (copyWith, equality), `*.g.dart` (JSON serialization)
- Factory constructors: `QueryProfile.fromJson(json)` / `toJson()`

**Code generation workflow**: After editing models:
```bash
cd shared
dart run build_runner build --delete-conflicting-outputs
```
- Always use `--delete-conflicting-outputs` to cleanly regenerate `*.freezed.dart` and `*.g.dart`
- Run tests: `dart test` from `shared/` directory

**Import pattern**: Other modules reference via `shared: {path: ../shared}` in their `pubspec.yaml`, then `import 'package:shared/shared.dart';`

## Development Workflows

**Starting local dev**:
```bash
# Terminal 1 - API server (port 8080)
cd api
dart run bin/server.dart  # ensure GEMINI_API_KEY is in .env or shell

# Terminal 2 - Web SSR dev server
dart run jaspr serve  # from repo root - hot reload enabled
```

**Build commands**:
- Web production: `dart run jaspr build` (outputs to `build/jaspr/`)
- API production: `dart compile exe api/bin/server.dart` (optional - Dart can run scripts directly)
- Mobile: `cd mobile_app && flutter build ios/apk/appbundle`

**Testing**:
- API tests: `cd api && dart test` - use `mocktail` for mocking (see [api/test/routes/learning_plan_generate_test.dart](../api/test/routes/learning_plan_generate_test.dart))
- Shared tests: `cd shared && dart test`
- Web: No test scaffolding yet
- Mobile: `cd mobile_app && flutter test` (empty for now)

**Test patterns (API)**: Mock `RequestContext` and `Request`, verify status codes and JSON structure
```dart
final context = _MockRequestContext();
when(() => context.request).thenReturn(request);
when(() => request.method).thenReturn(HttpMethod.post);
final response = await route.onRequest(context);
expect(response.statusCode, equals(200));
```

## Project Conventions

**Cross-boundary communication**: Always use shared models (`QueryProfile`) - never ad-hoc maps for data that crosses module boundaries

**API response format**: Consistent envelope pattern:
```json
{"success": true, "data": {...}}  // success
{"error": "message"}              // failure
```

**Error handling**:
- API routes: Catch specific exceptions (`FormatException` → 400), generic → 500
- Services: Throw exceptions; routes translate to HTTP codes

**Path dependencies**: All modules reference `shared` via relative paths (`path: ../shared`). If restructuring, update all `pubspec.yaml` files.

**Mobile integration**: Currently stub - when building out, import `shared` for models and hit API via HTTP client

**Lint/analysis**: Each module has `analysis_options.yaml` - API uses `dart_frog_lint`, web/mobile use standard `lints` package

## Common Tasks

**Add new API route**:
1. Create `api/routes/<path>/<endpoint>.dart` with `onRequest(RequestContext)`
2. Import `package:shared/shared.dart` for models
3. Follow request/response pattern (method check, parse, validate, call service, wrap response)
4. Add test in `api/test/routes/<path>/<endpoint>_test.dart`

**Add new page to web**:
1. Create component in `lib/pages/<page>.dart`, mark `@client` if interactive
2. Add `@css` getter for styles - reuse `primaryColor` from `theme.dart`
3. Register route in [lib/app.dart](../lib/app.dart) `Router(routes: [...])`
4. Update [lib/components/header.dart](../lib/components/header.dart) nav if needed

**Extend shared model**:
1. Edit `shared/lib/src/models/<model>.dart` (add fields to `@freezed` factory)
2. Run `cd shared && dart run build_runner build --delete-conflicting-outputs`
3. Update API service logic to consume new fields
4. Run `cd shared && dart test` to verify

**Debugging**:
- API: Check `GEMINI_API_KEY` env var, inspect `Platform.environment` in service
- Web: Use browser DevTools - check Network tab for hydration, Console for client errors
- Shared: Add print statements before running codegen - Freezed errors show missing parts

## Key Files Reference

- [lib/app.dart](../lib/app.dart) - Route registration, main layout structure
- [lib/main.server.dart](../lib/main.server.dart) - SSR entry, global document styles
- [lib/main.client.dart](../lib/main.client.dart) - Client hydration entry
- [lib/components/header.dart](../lib/components/header.dart) - Site header/nav, active route highlighting
- [lib/constants/theme.dart](../lib/constants/theme.dart) - Shared color tokens
- [api/routes/learning-plan/generate.dart](../api/routes/learning-plan/generate.dart) - Example route with full request/response/error handling
- [api/services/learning_plan_service.dart](../api/services/learning_plan_service.dart) - Gemini AI integration, prompt building
- [shared/lib/shared.dart](../shared/lib/shared.dart) - Package exports
- [shared/lib/src/models/query_profile.dart](../shared/lib/src/models/query_profile.dart) - Example Freezed + JSON model
- [api/API_USAGE.md](../api/API_USAGE.md) - API endpoint docs with curl/Dart examples
- [api/.env.example](../api/.env.example) - Required environment variables
