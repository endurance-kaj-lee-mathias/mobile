import 'package:dio/dio.dart';
import 'package:endurance_mobile_app/services/user/user_model.dart';
import 'package:get/get.dart';

class UserService {
  UserService({Dio? client}) : _client = client ?? Get.find<Dio>();

  final Dio _client;

  Future<UserModel> getProfile() async {
    final response = await _client.get<Map<String, dynamic>>('/users/me');
    return UserModel.fromJson(response.data!);
  }

  Future<void> updateFirstName(String firstName) async {
    await _client.patch('/users/me/first-name', data: {'firstName': firstName});
  }

  Future<void> updateLastName(String lastName) async {
    await _client.patch('/users/me/last-name', data: {'lastName': lastName});
  }

  Future<void> updatePhoneNumber(String phoneNumber) async {
    await _client.patch('/users/me/phone-number', data: {'phoneNumber': phoneNumber});
  }

  Future<void> updateIntroduction(String introduction) async {
    await _client.patch('/users/me/introduction', data: {'introduction': introduction});
  }

  Future<void> updateAbout(String about) async {
    await _client.patch('/users/me/about', data: {'about': about});
  }

  Future<void> updateImage(String image) async {
    await _client.patch('/users/me/image', data: {'image': image});
  }

  Future<void> updatePrivacy(bool isPrivate) async {
    await _client.patch('/users/me/privacy', data: {'isPrivate': isPrivate});
  }

  Future<void> deleteAccount() async {
    await _client.delete('/users/me');
  }

  Future<AddressModel> upsertAddress({
    required String street,
    required String locality,
    required String postalCode,
    required String country,
    String? region,
  }) async {
    final response = await _client.put<Map<String, dynamic>>(
      '/users/me/address',
      data: {
        'street': street,
        'locality': locality,
        'region': region,
        'postalCode': postalCode,
        'country': country,
      },
    );
    return AddressModel.fromJson(response.data!);
  }
}