import 'package:hive/hive.dart';

import '../constants/hive_boxes.dart';

class AuthService {
  final Box _box = Hive.box(HiveBoxes.settings);

  Future<void> login(String userId) async {
    await _box.put("isLoggedIn", true);
    await _box.put("currentUserId", userId);
  }

  Future<void> logout() async {
    await _box.put("isLoggedIn", false);
    await _box.delete("currentUserId");
  }

  bool isLoggedIn() {
    return _box.get("isLoggedIn", defaultValue: false);
  }

  String? getCurrentUserId() {
    return _box.get("currentUserId");
  }
}
