import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// Represents a user in the system
@freezed
abstract class User with _$User {
  const factory User({
    /// Unique identifier for the user
    int? id,
    
    /// User's email address
    required String email,
    
    /// User's last name
    required String lastName,
    
    /// Date the user was created
    DateTime? createdAt,
  }) = _User;

  /// Creates a User from JSON
  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
}
