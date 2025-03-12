class SignUpBody {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? dialCode;
  String? address;

  String? city;
  String? comments;
  String? companyName;
  String? country;
  String? isdCountryCode;
  bool? agreements;
  CountryCtrl? countryCtrl;

  SignUpBody(
      {this.firstName,
      this.lastName,
      this.email = '',
      this.dialCode,
      this.phone,
      this.address,
      this.city,
      this.comments,
      this.companyName,
      this.country,
      this.isdCountryCode,
      this.agreements,
      this.countryCtrl});

  SignUpBody.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    dialCode = json['dialCode'];
    phone = json['phone'];
    address = json['address'];

    city = json['city'];
    comments = json['comments'];
    companyName = json['companyName'];
    country = json['country'];
    isdCountryCode = json['isdCountryCode'];
    agreements = json['agreements'];

    countryCtrl = json['countryCtrl'] != null
        ? CountryCtrl.fromJson(json['countryCtrl'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['dialCode'] = dialCode;
    data['comments'] = comments;

    data['address'] = address;
    data['city'] = city;
    data['companyName'] = companyName;
    data['country'] = country;
    data['isdCountryCode'] = isdCountryCode;
    data['agreements'] = agreements;

    if (countryCtrl != null) {
      data['countryCtrl'] = countryCtrl!.toJson();
    }
    return data;
  }

  Map<String, dynamic> toJsonForPhone() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    return data;
  }
}

class CountryCtrl {
  String? id;
  String? code;
  String? name;
  int? displayOrder;
  String? isd;

  CountryCtrl({this.id, this.code, this.name, this.displayOrder, this.isd});

  CountryCtrl.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    displayOrder = json['displayOrder'];
    isd = json['isd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['displayOrder'] = displayOrder;
    data['isd'] = isd;
    return data;
  }
}
