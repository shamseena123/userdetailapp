class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  final Address address;
  final Company company;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.company,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int? ?? -1,
      name: json['name'] as String? ?? 'Unknown',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      website: json['website'] as String? ?? '',

      address: json['address'] != null
          ? Address.fromJson(json['address'])
          : Address.empty(),

      company: json['company'] != null
          ? Company.fromJson(json['company'])
          : Company.empty(),
    );
  }
}

class Address {
  final String street;
  final String city;
  final Geo geo;

  Address({required this.street, required this.city, required this.geo});

  Address.empty() : street = '', city = '', geo = Geo.empty();

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      city: json['city'],

      geo: Geo.fromJson(json['geo']),
    );
  }
}

class Geo {
  final String lat;
  final String lng;

  Geo({required this.lat, required this.lng});

  Geo.empty() : lat = '', lng = '';

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(lat: json['lat'], lng: json['lng']);
  }
}

class Company {
  final String name;

  Company({required this.name});

  Company.empty() : name = '';

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(name: json['name'] ?? '');
  }
}
