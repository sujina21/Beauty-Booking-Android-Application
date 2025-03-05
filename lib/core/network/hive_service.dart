import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/constants/hive_table_constant.dart';
import '../../features/auth/data/model/user_hive_model.dart';

class HiveService {
  Future<void> init() async {
    //Initialize the Database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}beauty_booking.db';

    //Create Database
    Hive.init(path);

    //Register Adapters
    Hive.registerAdapter(UserHiveModelAdapter());
  }

// User Queries

  Future<void> addUser(UserHiveModel user) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.put(user.id, user);
  }

  Future<void> deleteUser(String id) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.delete(id);
  }

  Future<List<UserHiveModel>> getAllUsers() async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    var users = box.values.toList();
    return users;
  }

  Future<UserHiveModel?> loginUser(String email, String password) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);

    var auth = box.values.firstWhere(
        (element) => element.email == email && element.password == password,
        orElse: () => UserHiveModel.initial());

    return auth;
  }
}
