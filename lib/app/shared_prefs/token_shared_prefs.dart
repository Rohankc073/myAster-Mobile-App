import 'package:dartz/dartz.dart';
import 'package:myasteer/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _sharedPreferences.setString('token', token);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      return Right(token ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> removeLoginData() async {
    try {
      await _sharedPreferences.remove('token'); // Remove token
      await _sharedPreferences.remove('userId'); // Remove user ID
      await _sharedPreferences.remove('userName'); // Remove name
      await _sharedPreferences.remove('userEmail'); // Remove email
      await _sharedPreferences.remove('userRole'); // Remove role
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}
