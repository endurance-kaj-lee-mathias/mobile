class AddressModel {
  final String? id;
  final String? street;
  final String? locality;
  final String? region;
  final String? postalCode;
  final String? country;

  const AddressModel({
    this.id,
    this.street,
    this.locality,
    this.region,
    this.postalCode,
    this.country,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id']?.toString(),
      street: json['street']?.toString(),
      locality: json['locality']?.toString(),
      region: json['region']?.toString(),
      postalCode: json['postalCode']?.toString(),
      country: json['country']?.toString(),
    );
  }
}

class UserModel {
  final String id;
  final String firstName;
  final String? lastName;
  final String username;
  final String? phoneNumber;
  final String? about;
  final String? introduction;
  final String? image;
  final bool isPrivate;
  final AddressModel? address;

  const UserModel({
    required this.id,
    required this.firstName,
    this.lastName,
    required this.username,
    this.phoneNumber,
    this.about,
    this.introduction,
    this.image,
    this.isPrivate = false,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString(),
      username: json['username']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString(),
      about: json['about']?.toString(),
      introduction: json['introduction']?.toString(),
      image: json['image']?.toString(),
      isPrivate: json['isPrivate'] as bool? ?? false,
      address: json['address'] != null ? AddressModel.fromJson(json['address']) : null,
    );
  }
}
