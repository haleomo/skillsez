import 'dart:io';
import 'package:dotenv/dotenv.dart';

void main() async {
  // Load environment variables from .env file
  final env = DotEnv()..load();
  
  // Set environment variables from .env file if not already set
  env.map.forEach((key, value) {
    if (!Platform.environment.containsKey(key)) {
      // Note: This doesn't actually modify Platform.environment at runtime
      // We need to use the env object directly in our code
      print('Loaded $key from .env file');
    }
  });
  
  // Verify required environment variables
  final geminiApiKey = env['GEMINI_API_KEY'] ?? Platform.environment['GEMINI_API_KEY'];
  if (geminiApiKey == null || geminiApiKey.isEmpty) {
    stderr.writeln('Error: GEMINI_API_KEY environment variable is not set');
    stderr.writeln('Please create a .env file in the api directory with: GEMINI_API_KEY=your_key_here');
    exit(1);
  }

  final dbPassword = env['DB_PASSWORD'] ?? Platform.environment['DB_PASSWORD'];
  if (dbPassword == null || dbPassword.isEmpty) {
    stderr.writeln('Error: DB_PASSWORD environment variable is not set');
    stderr.writeln('Please check your .env file has database configuration');
    exit(1);
  }

  print('Environment variables loaded successfully');
  print('DB_HOST: ${env['DB_HOST'] ?? Platform.environment['DB_HOST']}');
  print('DB_USER: ${env['DB_USER'] ?? Platform.environment['DB_USER']}');
  
  // For Dart Frog, use the CLI commands instead
  // Run: dart_frog dev
  // Or: dart run package:dart_frog/main.dart dev
  stderr.writeln('Please use one of these commands to start the server:');
  stderr.writeln('  dart_frog dev       (for development with hot reload)');
  stderr.writeln('  dart_frog build     (for production build)');
  exit(0);
}