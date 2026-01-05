import 'dart:io';
import 'package:dotenv/dotenv.dart';

void main() async {
  // Load environment variables from .env file
  final env = DotEnv()..load();
  
  // Verify required environment variables
  final geminiApiKey = env['GEMINI_API_KEY'];
  if (geminiApiKey == null || geminiApiKey.isEmpty) {
    stderr.writeln('Error: GEMINI_API_KEY environment variable is not set');
    stderr.writeln('Please create a .env file in the api directory with: GEMINI_API_KEY=your_key_here');
    exit(1);
  }

  // For Dart Frog, use the CLI commands instead
  // Run: dart_frog dev
  // Or: dart run package:dart_frog/main.dart dev
  stderr.writeln('Please use one of these commands to start the server:');
  stderr.writeln('  dart_frog dev       (for development with hot reload)');
  stderr.writeln('  dart_frog build     (for production build)');
  exit(0);
}