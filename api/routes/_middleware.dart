import 'package:dart_frog/dart_frog.dart';
import '../lib/database_service.dart';

/// Global middleware to initialize database service
Handler middleware(Handler handler) {
  return (context) async {
    print('[Middleware] Request received: ${context.request.method} ${context.request.uri.path}');
    
    try {
      // Ensure database is initialized (singleton pattern ensures this only happens once)
      print('[Middleware] Initializing database...');
      final db = DatabaseService();
      await db.initialize();
      print('[Middleware] Database initialized successfully');
    } catch (e, stackTrace) {
      // Log error but don't fail - let routes handle database errors
      print('[Middleware] Database initialization warning: $e');
      print('[Middleware] Stack trace: $stackTrace');
    }
    
    print('[Middleware] Passing to handler...');
    // Pass to next handler
    final response = await handler(context);
    print('[Middleware] Handler completed, returning response');
    return response;
  };
}
