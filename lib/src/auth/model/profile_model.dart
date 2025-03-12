class ProfileData {
  String? id;
  String? firstName;
  String? lastName;
  String? name;
  String? countryId;
  String? accountTypeId;
  String? industry;
  String? mobile;
  String? mobileDialCode;
  String? email;
  bool? isEstablishmentRequired;
  String? gstinNumber;

  ProfileData(
      {this.id,
      this.firstName,
      this.lastName,
      this.name,
      this.countryId,
      this.accountTypeId,
      this.industry,
      this.mobile,
      this.mobileDialCode,
      this.email,
      this.gstinNumber,
      this.isEstablishmentRequired});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    name = json['name'];
    countryId = json['countryId'];
    accountTypeId = json['accountTypeId'];
    industry = json['industry'];
    mobile = json['mobile'];
    mobileDialCode = json['mobileDialCode'];
    email = json['email'];
    gstinNumber = json['gstinNumber'];
    isEstablishmentRequired = json['isEstablishmentRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['name'] = this.name;
    data['countryId'] = this.countryId;
    data['accountTypeId'] = this.accountTypeId;
    data['industry'] = this.industry;
    data['mobile'] = this.mobile;
    data['mobileDialCode'] = this.mobileDialCode;
    data['email'] = this.email;
    data['gstinNumber'] = this.gstinNumber;
    data['isEstablishmentRequired'] = this.isEstablishmentRequired;
    return data;
  }
}
