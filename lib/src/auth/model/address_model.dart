class AddressData {
  String? id;
  String? userId;
  String? accountId;
  int? addressTypeId;
  String? addressLine1;
  String? addressLine2;
  String? addressType;
  String? postalCode;
  String? city;
  String? landmark;
  double? latitude;
  double? longitude;
  String? countryId;
  String? countryCode;
  String? countryName;
  String? subDivisionCode;
  int? subDivisionId;
  String? subDivisionName;
  bool? isDefault;

  AddressData(
      {this.id,
      this.userId,
      this.accountId,
      this.addressTypeId,
      this.addressLine1,
      this.addressLine2,
      this.addressType,
      this.postalCode,
      this.city,
      this.landmark,
      this.latitude,
      this.longitude,
      this.countryId,
      this.countryCode,
      this.countryName,
      this.subDivisionCode,
      this.subDivisionId,
      this.subDivisionName,
      this.isDefault});

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    accountId = json['accountId'];
    addressTypeId = json['addressTypeId'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    addressType = json['addressType'];
    postalCode = json['postalCode'];
    city = json['city'];
    landmark = json['landmark'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    countryId = json['countryId'];
    countryCode = json['countryCode'];
    countryName = json['countryName'];
    subDivisionCode = json['subDivisionCode'];
    subDivisionId = json['subDivisionId'];
    subDivisionName = json['subDivisionName'];
    isDefault = json['isDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['accountId'] = this.accountId;
    data['addressTypeId'] = this.addressTypeId;
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    data['addressType'] = this.addressType;
    data['postalCode'] = this.postalCode;
    data['city'] = this.city;
    data['landmark'] = this.landmark;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['countryId'] = this.countryId;
    data['countryCode'] = this.countryCode;
    data['countryName'] = this.countryName;
    data['subDivisionCode'] = this.subDivisionCode;
    data['subDivisionId'] = this.subDivisionId;
    data['subDivisionName'] = this.subDivisionName;
    data['isDefault'] = this.isDefault;
    return data;
  }
}
