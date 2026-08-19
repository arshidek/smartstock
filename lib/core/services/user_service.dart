import 'package:hive/hive.dart';

import '../../data/models/user_model.dart';
import '../constants/hive_boxes.dart';
import 'auth_service.dart';

class UserService {
  final AuthService _authService = AuthService();
  final Box<UserModel> _box = Hive.box<UserModel>(HiveBoxes.users);

  // Save User
  Future<void> saveUser(UserModel user) async {
    await _box.put(user.id, user);
  }

  // Get All Users
  List<UserModel> getAllUsers() {
    return _box.values.toList();
  }

  // Get User by Username or Email
  UserModel? getUserByUsernameOrEmail(String value) {
    try {
      return _box.values.firstWhere(
        (user) =>
            user.username.toLowerCase() == value.toLowerCase() ||
            user.email.toLowerCase() == value.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  // Exist User
  bool userExists(String username, String email) {
    return _box.values.any(
      (user) =>
          user.username.toLowerCase() == username.toLowerCase() ||
          user.email.toLowerCase() == email.toLowerCase(),
    );
  }

  UserModel? login(String usernameOrEmail, String password) {
    try {
      return _box.values.firstWhere(
        (user) =>
            (user.username.trim().toLowerCase() ==
                    usernameOrEmail.trim().toLowerCase() ||
                user.email.trim().toLowerCase() ==
                    usernameOrEmail.trim().toLowerCase()) &&
            user.password == password,
      );
    } catch (e) {
      return null;
    }
  }

  // Get Current Logged-in User
  UserModel? getCurrentUser() {
    final currentUserId = _authService.getCurrentUserId();

    if (currentUserId == null) {
      return null;
    }

    try {
      return _box.values.firstWhere((user) => user.id == currentUserId);
    } catch (e) {
      return null;
    }
  }

  // Update User
  Future<void> updateUser({
    required UserModel user,
    required String username,
    required String email,
    required String phone,
    required String shopName,
  }) async {
    user.username = username;
    user.email = email;
    user.phone = phone;
    user.shopName = shopName;

    await user.save();
  }
}
