import 'package:hive_flutter/hive_flutter.dart';
import 'package:myasteer/app/constants/hive_table_constant.dart';
import 'package:myasteer/features/auth/data/model/auth_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}aster.db';

    Hive.init(path);

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
  }

  // **Register User**
  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(auth.userId, auth);
  }

  // **Delete User by ID**
  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.delete(id);
  }

  // **Get All Users**
  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    return box.values.toList();
  }

  // **Login User**
  Future<AuthHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);

    try {
      return box.values.firstWhere(
        (element) => element.email == email && element.password == password,
        // **Fixed: Return null if no user is found**
      );
    } catch (e) {
      return null;
    }
  }

  // **Clear All Users**
  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  // **Close Hive**
  Future<void> close() async {
    await Hive.close();
  }
}
