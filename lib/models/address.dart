import 'package:simple_social_app/models/geo.dart';

class Address {
  String street = "";
  String suite = "";
  String city = "";
  String zipcode = "";
  Geo geo = Geo(lat: "", lng: "");

  Address(
      {required this.street,
        required this.suite,
        required this.city,
        required this.zipcode,
        required this.geo});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
    geo = json['geo'] != null
        ? new Geo.fromJson(json['geo'])
        : Geo(lat: "", lng: "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['suite'] = this.suite;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    if (this.geo != null) {
      data['geo'] = this.geo.toJson();
    }
    return data;
  }
}