import 'package:hive_flutter/hive_flutter.dart';
import 'package:myasteer/app/constants/hive_table_constant.dart';
import 'package:myasteer/features/auth/data/model/auth_hive_model.dart';
import 'package:myasteer/features/doctor/data/model/doctor_hive_model.dart';
import 'package:myasteer/features/product/data/model/product_hive_model.dart';
import 'package:myasteer/features/user/data/model/user_hive_model.dart';
// import 'package:myasteer/features/doctor/data/model/doctor_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}aster.db';

    Hive.init(path);

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());

    //Doctor Adapter

    // Hive.registerAdapter(DoctorHiveModelAdapter());
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

  // **Add Doctor**
  Future<void> addDoctor(DoctorHiveModel doctor) async {
    var box = await Hive.openBox<DoctorHiveModel>(HiveTableConstant.doctorBox);
    await box.put(doctor.id, doctor);
  }

  Future<void> deleteDoctor(String id) async {
    var box = await Hive.openBox<DoctorHiveModel>(HiveTableConstant.doctorBox);
    await box.delete(id);
  }

  Future<List<DoctorHiveModel>> getAllDoctor() async {
    var box = await Hive.openBox<DoctorHiveModel>(HiveTableConstant.doctorBox);
    return box.values.toList();
  }

  // ** Product**
  Future<List<ProductHiveModel>> getAllProduct() async {
    var box =
        await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
    return box.values.toList();
  }

  Future<void> deleteProduct(String id) async {
    var box = await Hive.openBox<DoctorHiveModel>(HiveTableConstant.doctorBox);
    await box.delete(id);
  }

  Future<List<UserHiveModel>> getUserById() async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    return box.values.toList();
  }

  // Future<List<DoctorHiveModel>> getAllDoctor() async {
  //   var box = await Hive.openBox<DoctorHiveModel>(HiveTableConstant.doctorBox);
  //   return box.values.toList();
  // }

  Future<List<ProductHiveModel>> getProductById() async {
    var box =
        await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
    return box.values.toList();
  }

  // **Close Hive**
  Future<void> close() async {
    await Hive.close();
  }
}
