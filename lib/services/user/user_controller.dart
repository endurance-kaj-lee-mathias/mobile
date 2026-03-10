import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:endurance_mobile_app/services/user/user_model.dart';
import 'package:endurance_mobile_app/services/user/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  UserController({UserService? service}) : _service = service ?? UserService();

  final UserService _service;

  final Rxn<UserModel> user = Rxn<UserModel>();
  final RxBool isLoading = false.obs;

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

  Future<void> updateFirstName(String firstName) async {
    try {
      await _service.updateFirstName(firstName);
    } catch (e) {
      debugPrint('Failed to update first name: $e');
      rethrow;
    }
  }

  Future<void> updateLastName(String lastName) async {
    try {
      await _service.updateLastName(lastName);
    } catch (e) {
      debugPrint('Failed to update last name: $e');
      rethrow;
    }
  }

  Future<void> updatePhoneNumber(String phoneNumber) async {
    try {
      await _service.updatePhoneNumber(phoneNumber);
    } catch (e) {
      debugPrint('Failed to update phone number: $e');
      rethrow;
    }
  }

  Future<void> updateIntroduction(String introduction) async {
    try {
      await _service.updateIntroduction(introduction);
    } catch (e) {
      debugPrint('Failed to update introduction: $e');
      rethrow;
    }
  }

  Future<void> updateAbout(String about) async {
    try {
      await _service.updateAbout(about);
    } catch (e) {
      debugPrint('Failed to update about: $e');
      rethrow;
    }
  }

  Future<void> updatePrivacy(bool isPrivate) async {
    try {
      await _service.updatePrivacy(isPrivate);
    } catch (e) {
      debugPrint('Failed to update privacy: $e');
      rethrow;
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _service.deleteAccount();
    } catch (e) {
      debugPrint('Failed to delete account: $e');
      rethrow;
    }
  }

  Future<AddressModel> upsertAddress({
    required String street,
    required String locality,
    required String postalCode,
    required String country,
    String? region,
  }) async {
    try {
      return await _service.upsertAddress(
        street: street,
        locality: locality,
        postalCode: postalCode,
        country: country,
        region: region,
      );
    } catch (e) {
      debugPrint('Failed to upsert address: $e');
      rethrow;
    }
  }
}
