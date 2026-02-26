import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:endurance_mobile_app/services/user/user_model.dart';
import 'package:endurance_mobile_app/services/user/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final Rxn<UserModel> user = Rxn<UserModel>();
  final RxBool isLoading = false.obs;

  final _service = UserService();

  @override
  void onInit() {
    super.onInit();
    final auth = Get.find<AuthController>();

    // Load profile whenever the user becomes authenticated (covers both
    // initial session restore and fresh logins).
    ever(auth.isAuthenticated, (bool authenticated) {
      if (authenticated) _loadProfile();
    });

    // If auth is already done by the time this controller initialises, load now.
    if (auth.isAuthenticated.value) _loadProfile();
  }

  Future<void> _loadProfile() async {
    isLoading.value = true;
    try {
      user.value = await _service.getProfile();
    } catch (e) {
      debugPrint('Failed to load user profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Future<void> refresh() => _loadProfile();
}
