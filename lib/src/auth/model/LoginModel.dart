class LoginModel {
  bool? status;
  String? token;
  String? loginExpiry;
  bool? redirect;
  Customer? customer;
  String? currencySybmol;

  LoginModel(
      {this.status,
      this.token,
      this.loginExpiry,
      this.redirect,
      this.customer,
      this.currencySybmol});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    loginExpiry = json['login_expiry'];
    redirect = json['redirect'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    currencySybmol = json['currency_sybmol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    data['login_expiry'] = this.loginExpiry;
    data['redirect'] = this.redirect;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['currency_sybmol'] = this.currencySybmol;
    return data;
  }
}

class Customer {
  int? idCustomer;
  String? email;
  String? mobCode;
  Null? referenceNo;
  Null? idBranch;
  Null? idArea;
  Null? title;
  String? lastname;
  String? firstname;
  Null? dateOfBirth;
  Null? dateOfWed;
  Null? gender;
  String? mobile;
  Null? phoneNo;
  Null? cusImg;
  Null? comments;
  Null? profileComplete;
  bool? active;
  Null? dateAdd;
  String? customEntryDate;
  Null? dateUpd;
  bool? notification;
  String? gstNumber;
  String? panNumber;
  Null? aadharNumber;
  Null? cusRefCode;
  bool? isRefbenefitCrtCus;
  Null? empRefCode;
  bool? isRefbenefitCrtEmp;
  Null? religion;
  bool? kycStatus;
  bool? isCusSynced;
  Null? lastSyncTime;
  Null? lastPaymentOn;
  bool? isVip;
  bool? isEmailVerified;
  String? creditBalance;
  String? debitBalance;
  int? registeredThrough;
  String? cusType;
  bool? sendPromoSms;
  String? isRetailer;
  String? retailerType;
  String? profileType;
  String? createdOn;
  Null? updatedOn;
  int? user;
  Null? profession;
  Null? createdBy;
  Null? updatedBy;

  Customer(
      {this.idCustomer,
      this.email,
      this.mobCode,
      this.referenceNo,
      this.idBranch,
      this.idArea,
      this.title,
      this.lastname,
      this.firstname,
      this.dateOfBirth,
      this.dateOfWed,
      this.gender,
      this.mobile,
      this.phoneNo,
      this.cusImg,
      this.comments,
      this.profileComplete,
      this.active,
      this.dateAdd,
      this.customEntryDate,
      this.dateUpd,
      this.notification,
      this.gstNumber,
      this.panNumber,
      this.aadharNumber,
      this.cusRefCode,
      this.isRefbenefitCrtCus,
      this.empRefCode,
      this.isRefbenefitCrtEmp,
      this.religion,
      this.kycStatus,
      this.isCusSynced,
      this.lastSyncTime,
      this.lastPaymentOn,
      this.isVip,
      this.isEmailVerified,
      this.creditBalance,
      this.debitBalance,
      this.registeredThrough,
      this.cusType,
      this.sendPromoSms,
      this.isRetailer,
      this.retailerType,
      this.profileType,
      this.createdOn,
      this.updatedOn,
      this.user,
      this.profession,
      this.createdBy,
      this.updatedBy});

  Customer.fromJson(Map<String, dynamic> json) {
    idCustomer = json['id_customer'];
    email = json['email'];
    mobCode = json['mob_code'];
    referenceNo = json['reference_no'];
    idBranch = json['id_branch'];
    idArea = json['id_area'];
    title = json['title'];
    lastname = json['lastname'];
    firstname = json['firstname'];
    dateOfBirth = json['date_of_birth'];
    dateOfWed = json['date_of_wed'];
    gender = json['gender'];
    mobile = json['mobile'];
    phoneNo = json['phone_no'];
    cusImg = json['cus_img'];
    comments = json['comments'];
    profileComplete = json['profile_complete'];
    active = json['active'];
    dateAdd = json['date_add'];
    customEntryDate = json['custom_entry_date'];
    dateUpd = json['date_upd'];
    notification = json['notification'];
    gstNumber = json['gst_number'];
    panNumber = json['pan_number'];
    aadharNumber = json['aadhar_number'];
    cusRefCode = json['cus_ref_code'];
    isRefbenefitCrtCus = json['is_refbenefit_crt_cus'];
    empRefCode = json['emp_ref_code'];
    isRefbenefitCrtEmp = json['is_refbenefit_crt_emp'];
    religion = json['religion'];
    kycStatus = json['kyc_status'];
    isCusSynced = json['is_cus_synced'];
    lastSyncTime = json['last_sync_time'];
    lastPaymentOn = json['last_payment_on'];
    isVip = json['is_vip'];
    isEmailVerified = json['is_email_verified'];
    creditBalance = json['credit_balance'];
    debitBalance = json['debit_balance'];
    registeredThrough = json['registered_through'];
    cusType = json['cus_type'];
    sendPromoSms = json['send_promo_sms'];
    isRetailer = json['is_retailer'];
    retailerType = json['retailer_type'];
    profileType = json['profile_type'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    user = json['user'];
    profession = json['profession'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_customer'] = this.idCustomer;
    data['email'] = this.email;
    data['mob_code'] = this.mobCode;
    data['reference_no'] = this.referenceNo;
    data['id_branch'] = this.idBranch;
    data['id_area'] = this.idArea;
    data['title'] = this.title;
    data['lastname'] = this.lastname;
    data['firstname'] = this.firstname;
    data['date_of_birth'] = this.dateOfBirth;
    data['date_of_wed'] = this.dateOfWed;
    data['gender'] = this.gender;
    data['mobile'] = this.mobile;
    data['phone_no'] = this.phoneNo;
    data['cus_img'] = this.cusImg;
    data['comments'] = this.comments;
    data['profile_complete'] = this.profileComplete;
    data['active'] = this.active;
    data['date_add'] = this.dateAdd;
    data['custom_entry_date'] = this.customEntryDate;
    data['date_upd'] = this.dateUpd;
    data['notification'] = this.notification;
    data['gst_number'] = this.gstNumber;
    data['pan_number'] = this.panNumber;
    data['aadhar_number'] = this.aadharNumber;
    data['cus_ref_code'] = this.cusRefCode;
    data['is_refbenefit_crt_cus'] = this.isRefbenefitCrtCus;
    data['emp_ref_code'] = this.empRefCode;
    data['is_refbenefit_crt_emp'] = this.isRefbenefitCrtEmp;
    data['religion'] = this.religion;
    data['kyc_status'] = this.kycStatus;
    data['is_cus_synced'] = this.isCusSynced;
    data['last_sync_time'] = this.lastSyncTime;
    data['last_payment_on'] = this.lastPaymentOn;
    data['is_vip'] = this.isVip;
    data['is_email_verified'] = this.isEmailVerified;
    data['credit_balance'] = this.creditBalance;
    data['debit_balance'] = this.debitBalance;
    data['registered_through'] = this.registeredThrough;
    data['cus_type'] = this.cusType;
    data['send_promo_sms'] = this.sendPromoSms;
    data['is_retailer'] = this.isRetailer;
    data['retailer_type'] = this.retailerType;
    data['profile_type'] = this.profileType;
    data['created_on'] = this.createdOn;
    data['updated_on'] = this.updatedOn;
    data['user'] = this.user;
    data['profession'] = this.profession;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}
