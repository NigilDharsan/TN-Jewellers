class DriverVehicleModel {
  String? scheduleId;
  String? email;
  String? phoneDailCode;
  String? phoneNumber;
  String? driverLicenceNumber;
  String? licenceValidTo;
  String? dimUomTypeName;
  String? registrationNo;
  String? storageCapacity;
  String? storageHeight;
  String? storageLength;
  String? storageWidth;
  String? vehicleMake;
  String? vehicleTypeName;
  String? ownerAddress;
  String? ownerName;
  String? ownerPhoneNumber;
  String? ownerEmail;

  DriverVehicleModel({
    this.scheduleId,
    this.email,
    this.phoneDailCode,
    this.phoneNumber,
    this.driverLicenceNumber,
    this.licenceValidTo,
    this.dimUomTypeName,
    this.registrationNo,
    this.storageCapacity,
    this.storageHeight,
    this.storageLength,
    this.storageWidth,
    this.vehicleMake,
    this.vehicleTypeName,
    this.ownerAddress,
    this.ownerName,
    this.ownerPhoneNumber,
    this.ownerEmail,
  });
  DriverVehicleModel.fromJson(Map<String, dynamic> json) {
    scheduleId = json["scheduleId"];
    email = json["email"];
    phoneDailCode = json["phoneDailCode"];
    phoneNumber = json["fromStateCode"];
    driverLicenceNumber = json["fromStateId"];
    licenceValidTo = json["fromStateName"];
    dimUomTypeName = json["dimUomTypeName"];
    registrationNo = json["registrationNo"];
    storageCapacity = json["storageCapacity"];
    storageHeight = json["storageHeight"];
    storageLength = json["storageLength"];
    storageWidth = json["storageWidth"];
    vehicleMake = json["vehicleMake"];
    vehicleTypeName = json["vehicleTypeName"];
    ownerAddress = json["ownerAddress"];
    ownerName = json["ownerName"];
    ownerPhoneNumber = json["ownerPhoneNumber"];
    ownerEmail = json["ownerEmail"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scheduleId'] = scheduleId;
    data['email'] = email;
    data['phoneDailCode'] = phoneDailCode;
    data['phoneNumber'] = phoneNumber;
    data['driverLicenceNumber'] = driverLicenceNumber;
    data['licenceValidTo'] = licenceValidTo;
    data['dimUomTypeName'] = dimUomTypeName;
    data['registrationNo'] = registrationNo;
    data['storageCapacity'] = storageCapacity;
    data['storageHeight'] = storageHeight;
    data['storageLength'] = storageLength;
    data['storageWidth'] = storageWidth;
    data['vehicleMake'] = vehicleMake;
    data['vehicleTypeName'] = vehicleTypeName;
    data['ownerAddress'] = ownerAddress;
    data['ownerName'] = ownerName;
    data['ownerPhoneNumber'] = ownerPhoneNumber;
    data['ownerEmail'] = ownerEmail;

    return data;
  }
}
