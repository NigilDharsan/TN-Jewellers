class SignupModel {
  UserDetail? user;
  AccountDetail? account;
  AccountContact? accountContact;

  SignupModel({this.user, this.account, this.accountContact});

  SignupModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new UserDetail.fromJson(json['user']) : null;
    account = json['account'] != null
        ? new AccountDetail.fromJson(json['account'])
        : null;
    accountContact = json['accountContact'] != null
        ? new AccountContact.fromJson(json['accountContact'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    if (this.accountContact != null) {
      data['accountContact'] = this.accountContact!.toJson();
    }
    return data;
  }
}

class UserDetail {
  String? email;
  bool? emailConfirmed;
  String? externalId;
  String? firstName;
  bool? isDeleted;
  String? lastName;
  String? middleName;
  String? phoneDialCode;
  String? phoneNumber;
  bool? phoneNumberConfirmed;
  String? username;
  String? id;
  String? workflowId;
  String? workflowStatusCode;
  String? workflowStatusId;
  String? workflowStatusName;
  String? userType;
  String? operationalArea;
  String? password;
  String? accountId;
  bool? isEstablishmentRequired;
  String? avatar;
  String? registrationType;

  UserDetail({
    this.email,
    this.emailConfirmed,
    this.externalId,
    this.firstName,
    this.isDeleted,
    this.lastName,
    this.middleName,
    this.phoneDialCode,
    this.phoneNumber,
    this.phoneNumberConfirmed,
    this.username,
    this.id,
    this.workflowId,
    this.workflowStatusCode,
    this.workflowStatusId,
    this.workflowStatusName,
    this.userType,
    this.password,
    this.accountId,
    this.isEstablishmentRequired,
    this.avatar,
    this.registrationType,
    this.operationalArea,
  });

  UserDetail.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    emailConfirmed = json['emailConfirmed'];
    externalId = json['externalId'];
    firstName = json['firstName'];
    isDeleted = json['isDeleted'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    phoneDialCode = json['phoneDialCode'];
    phoneNumber = json['phoneNumber'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
    username = json['username'];
    id = json['id'];
    workflowId = json['workflowId'];
    workflowStatusCode = json['workflowStatusCode'];
    workflowStatusId = json['workflowStatusId'];
    workflowStatusName = json['workflowStatusName'];
    userType = json['userType'];
    password = json['password'];
    accountId = json['accountId'];
    isEstablishmentRequired = json['isEstablishmentRequired'];
    avatar = json['avatar'];
    registrationType = json['registrationType'];
    operationalArea = json['operationalArea'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['emailConfirmed'] = this.emailConfirmed;
    data['externalId'] = this.externalId;
    data['firstName'] = this.firstName;
    data['isDeleted'] = this.isDeleted;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['phoneDialCode'] = this.phoneDialCode;
    data['phoneNumber'] = this.phoneNumber;
    data['phoneNumberConfirmed'] = this.phoneNumberConfirmed;
    data['username'] = this.username;
    data['id'] = this.id;
    data['workflowId'] = this.workflowId;
    data['workflowStatusCode'] = this.workflowStatusCode;
    data['workflowStatusId'] = this.workflowStatusId;
    data['workflowStatusName'] = this.workflowStatusName;
    data['userType'] = this.userType;
    data['password'] = this.password;
    data['accountId'] = this.accountId;
    data['isEstablishmentRequired'] = this.isEstablishmentRequired;
    data['avatar'] = this.avatar;
    data['registrationType'] = this.registrationType;
    data['operationalArea'] = this.operationalArea;
    return data;
  }
}

class AccountDetail {
  String? accountType;
  String? industry;
  bool? isPersonAccount;
  String? name;
  String? workflowStatusCode;
  String? workflowStatusName;
  String? accountTypeId;
  String? countryId;
  String? GSTINNumber;

  AccountDetail(
      {this.accountType,
      this.industry,
      this.isPersonAccount,
      this.name,
      this.workflowStatusCode,
      this.workflowStatusName,
      this.accountTypeId,
      this.GSTINNumber,
      this.countryId});

  AccountDetail.fromJson(Map<String, dynamic> json) {
    accountType = json['accountType'];
    industry = json['industry'];
    isPersonAccount = json['isPersonAccount'];
    name = json['name'];
    workflowStatusCode = json['workflowStatusCode'];
    workflowStatusName = json['workflowStatusName'];
    accountTypeId = json['accountTypeId'];
    countryId = json['countryId'];
    GSTINNumber = json['gstinNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountType'] = this.accountType;
    data['industry'] = this.industry;
    data['isPersonAccount'] = this.isPersonAccount;
    data['name'] = this.name;
    data['workflowStatusCode'] = this.workflowStatusCode;
    data['workflowStatusName'] = this.workflowStatusName;
    data['accountTypeId'] = this.accountTypeId;
    data['countryId'] = this.countryId;
    data['gstinNumber'] = this.GSTINNumber;
    return data;
  }
}

class AccountContact {
  String? accountId;
  String? email;
  bool? isActive;
  bool? isDefault;
  String? mobile;
  String? mobileDialCode;

  AccountContact(
      {this.accountId,
      this.email,
      this.isActive,
      this.isDefault,
      this.mobile,
      this.mobileDialCode});

  AccountContact.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    email = json['email'];
    isActive = json['isActive'];
    isDefault = json['isDefault'];
    mobile = json['mobile'];
    mobileDialCode = json['mobileDialCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountId'] = this.accountId;
    data['email'] = this.email;
    data['isActive'] = this.isActive;
    data['isDefault'] = this.isDefault;
    data['mobile'] = this.mobile;
    data['mobileDialCode'] = this.mobileDialCode;
    return data;
  }
}
