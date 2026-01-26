import 'package:dart_frog/dart_frog.dart';
import '../lib/database_service.dart';

/// CORS headers map
Map<String, String> _corsHeaders() {
  return {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type, Authorization',
  };
}

/// Global middleware to handle CORS and initialize database service
Handler middleware(Handler handler) {
  return (context) async {
    print('[Middleware] Request received: ${context.request.method} ${context.request.uri.path}');
    
    // Handle CORS preflight requests (OPTIONS)
    if (context.request.method == HttpMethod.options) {
      print('[Middleware] Handling CORS preflight request');
      return Response(
        statusCode: 200,
        headers: _corsHeaders(),
      );
    }
    
    try {
      // ignore: lines_longer_than_80_chars
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
    
    // Add CORS headers to all responses
    return response.copyWith(
      headers: {
        ...response.headers,
        ..._corsHeaders(),
      },
    );
  };
}
