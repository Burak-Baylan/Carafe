import 'package:Carafe/core/hive/hive_constants.dart';
import 'package:hive_flutter/adapters.dart';

class HiveHelper {
  static HiveHelper? _instance;
  static HiveHelper get instance =>
      _instance = _instance == null ? HiveHelper._init() : _instance!;
  HiveHelper._init();

  Future<void> initHive() async {
    await Hive.initFlutter();
    await Hive.openBox<bool>(HiveConstants.BOX_APP_PREFERENCES);
  }

  Future<T?> getData<T>(String boxName, dynamic key, {T? defaultValue}) async {
    var box = Hive.box<T>(boxName);
    return box.get(key, defaultValue: defaultValue);
  }

  Future<List<T>> getAll<T>(String boxName) async {
    var box = Hive.box<T>(boxName);
    return box.values.toList();
  }

  Future<void> putData<T>(String boxName, dynamic key, T data) async {
    var box = Hive.box<T>(boxName);
    await box.put(key, data);
  }

  Future<void> putAllData<T>(String boxName, Map<dynamic, T> data) async {
    var box = Hive.box<T>(boxName);
    await box.putAll(data);
  }

  Future<void> deleteData<T>(String boxName, dynamic key) async {
    var box = Hive.box<T>(boxName);
    await box.delete(key);
  }

  Future<void> deleteDataAt<T>(String boxName, int index) async {
    var box = Hive.box<T>(boxName);
    await box.deleteAt(index);
  }

  Future<void> deleteAll<T>(String boxName, Iterable<dynamic> keys) async {
    var box = Hive.box<T>(boxName);
    await box.deleteAll(keys);
  }

  Future<int> addData<T>(String boxName, T dataToAdd) async {
    var box = Hive.box<T>(boxName);
    return box.add(dataToAdd);
  }
}
