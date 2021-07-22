import 'package:simple_social_app/models/address.dart';
import 'package:simple_social_app/models/company.dart';
import 'package:simple_social_app/models/geo.dart';

class User {
  int id = 0;
  String name = "";
  String username = "";
  String email = "";
  Address address = Address(
      street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng: ""));
  String phone = "";
  String website = "";
  Company company = Company(name: "", catchPhrase: "", bs: "");

  User(
      {required this.id,
        required this.name,
        required this.username,
        required this.email,
        required this.address,
        required this.phone,
        required this.website,
        required this.company});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    address = json['address'] != null
        ? new Address.fromJson(json['address'])
        : Address(
        street: '',
        zipcode: '',
        suite: '',
        geo: Geo(lat: "", lng: ""),
        city: '');
    phone = json['phone'];
    website = json['website'];
    company = json['company'] != null
        ? new Company.fromJson(json['company'])
        : Company(name: "", catchPhrase: "", bs: "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['phone'] = this.phone;
    data['website'] = this.website;
    if (this.company != null) {
      data['company'] = this.company.toJson();
    }
    return data;
  }
}






