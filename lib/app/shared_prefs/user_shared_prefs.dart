import 'package:dartz/dartz.dart';
import 'package:myAster/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPrefs {
  static const String _userIdKey = 'userId';
  static const String _userNameKey = 'userName';
  static const String _userEmailKey = 'userEmail';
  static const String _userRoleKey = 'userRole';

  final SharedPreferences _sharedPreferences;

  UserSharedPrefs(this._sharedPreferences);

  Future<Either<Failure, void>> saveUserData(
      String userId, String name, String email, String role) async {
    try {
      await _sharedPreferences.setString(_userIdKey, userId);
      await _sharedPreferences.setString(_userNameKey, name);
      await _sharedPreferences.setString(_userEmailKey, email);
      await _sharedPreferences.setString(_userRoleKey, role);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, String>>> getUserData() async {
    try {
      final userId = _sharedPreferences.getString(_userIdKey) ?? '';
      final name = _sharedPreferences.getString(_userNameKey) ?? '';
      final email = _sharedPreferences.getString(_userEmailKey) ?? '';
      final role = _sharedPreferences.getString(_userRoleKey) ?? '';

      return Right({
        'userId': userId,
        'name': name,
        'email': email,
        'role': role,
      });
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> removeUserData() async {
    try {
      await _sharedPreferences.remove(_userIdKey);
      await _sharedPreferences.remove(_userNameKey);
      await _sharedPreferences.remove(_userEmailKey);
      await _sharedPreferences.remove(_userRoleKey);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}
