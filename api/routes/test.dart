import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';

/// GET /test
/// Simple test route without database
Future<Response> onRequest(RequestContext context) async {
  print('[Test Route] Request received');
  
  return Response(
    statusCode: 200,
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    },
    body: jsonEncode({
      'status': 'ok',
      'message': 'Server is running',
    }),
  );
}
