class GetUserResponse {
  int id = 0;
  String name = "";
  String username = "";
  String email = "";
  Address address = Address(
      street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng: ""));
  String phone = "";
  String website = "";
  Company company = Company(name: "", catchPhrase: "", bs: "");

  GetUserResponse(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.address,
      required this.phone,
      required this.website,
      required this.company});

  GetUserResponse.fromJson(Map<String, dynamic> json) {
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

class Geo {
  String lat = "";
  String lng = "";

  Geo({required this.lat, required this.lng});

  Geo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Company {
  String name = "";
  String catchPhrase = "";
  String bs = "";

  Company({required this.name, required this.catchPhrase, required this.bs});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    catchPhrase = json['catchPhrase'];
    bs = json['bs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['catchPhrase'] = this.catchPhrase;
    data['bs'] = this.bs;
    return data;
  }
}
