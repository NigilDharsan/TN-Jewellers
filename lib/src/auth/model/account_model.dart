class AccountModel {
  String? accountHolderName;
  String? accountId;
  String? bankAccountNumber;
  String? bankName;
  String? branch;
  String? ifscCode;
  bool? isVerified;
  String? id;
  String? fundAccountId;
  String? userId;

  AccountModel(
      {this.accountHolderName,
      this.accountId,
      this.bankAccountNumber,
      this.bankName,
      this.branch,
      this.ifscCode,
      this.isVerified,
      this.id,
      this.fundAccountId,
      this.userId});

  AccountModel.fromJson(Map<String, dynamic> json) {
    accountHolderName = json['accountHolderName'];
    accountId = json['accountId'];
    bankAccountNumber = json['bankAccountNumber'];
    bankName = json['bankName'];
    branch = json['branch'];
    ifscCode = json['ifscCode'];
    isVerified = json['isVerified'];
    id = json['id'];
    fundAccountId = json['fundAccountId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountHolderName'] = this.accountHolderName;
    data['accountId'] = this.accountId;
    data['bankAccountNumber'] = this.bankAccountNumber;
    data['bankName'] = this.bankName;
    data['branch'] = this.branch;
    data['ifscCode'] = this.ifscCode;
    data['isVerified'] = this.isVerified;
    data['id'] = this.id;
    data['fundAccountId'] = this.fundAccountId;
    data['userId'] = this.userId;
    return data;
  }
}
