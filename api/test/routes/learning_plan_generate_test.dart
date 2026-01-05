import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:shared/shared.dart';

import '../../routes/learning-plan/generate.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}
class _MockRequest extends Mock implements Request {}

void main() {
  group('POST /learning-plan/generate', () {
    late RequestContext context;
    late Request request;

    setUp(() {
      context = _MockRequestContext();
      request = _MockRequest();
      when(() => context.request).thenReturn(request);
    });

    test('returns 405 for non-POST requests', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.get);

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, equals(405));
      final body = await response.body();
      final jsonBody = jsonDecode(body);
      expect(jsonBody['error'], equals('Method not allowed'));
    });

    test('returns 400 for invalid JSON', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.post);
      when(() => request.body()).thenAnswer((_) async => 'invalid json');

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, equals(400));
      final body = await response.body();
      final jsonBody = jsonDecode(body);
      expect(jsonBody['error'], equals('Invalid JSON format in request body'));
    });

    test('returns 400 for empty topic', () async {
      // Arrange
      final queryProfile = QueryProfile(
        sourceExpertDiscipline: 'Software Engineering',
        subjectEducationLevel: 'Bachelor\'s',
        subjectDiscipline: 'Computer Science',
        subjectWorkExperience: '2 years',
        topic: '', // Empty topic
        goal: 'work',
        role: 'developer',
      );

      when(() => request.method).thenReturn(HttpMethod.post);
      when(() => request.body()).thenAnswer((_) async => jsonEncode(queryProfile.toJson()));

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, equals(400));
      final body = await response.body();
      final jsonBody = jsonDecode(body);
      expect(jsonBody['error'], equals('Topic is required'));
    });

    test('returns 500 when GEMINI_API_KEY is not set', () async {
      // Arrange
      final queryProfile = QueryProfile(
        sourceExpertDiscipline: 'Software Engineering',
        subjectEducationLevel: 'Bachelor\'s',
        subjectDiscipline: 'Computer Science',
        subjectWorkExperience: '2 years',
        topic: 'Flutter Development',
        goal: 'work',
        role: 'mobile developer',
      );

      when(() => request.method).thenReturn(HttpMethod.post);
      when(() => request.body()).thenAnswer((_) async => jsonEncode(queryProfile.toJson()));

      // Make sure API key is not set
      Platform.environment.remove('GEMINI_API_KEY');

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, equals(500));
      final body = await response.body();
      final jsonBody = jsonDecode(body);
      expect(jsonBody['error'], contains('Internal server error'));
    });
  });
}