class GetAccountMoel {
  Map<String, dynamic>? extra;
  String? filter;
  List<Items>? items;
  String? orderBy;
  int? page;
  int? pageSize;
  int? totalItemCount;

  GetAccountMoel(
      {this.extra,
      this.filter,
      this.items,
      this.orderBy,
      this.page,
      this.pageSize,
      this.totalItemCount});

  GetAccountMoel.fromJson(Map<String, dynamic> json) {
    extra = json['extra'];
    filter = json['filter'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    orderBy = json['orderBy'];
    page = json['page'];
    pageSize = json['pageSize'];
    totalItemCount = json['totalItemCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['extra'] = this.extra;
    data['filter'] = this.filter;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['orderBy'] = this.orderBy;
    data['page'] = this.page;
    data['pageSize'] = this.pageSize;
    data['totalItemCount'] = this.totalItemCount;
    return data;
  }
}

class Items {
  String? accountHolderName;
  String? accountId;
  String? bankAccountNumber;
  String? bankName;
  String? branch;
  String? createdAt;
  String? createdBy;
  String? id;
  String? ifscCode;
  bool? isVerified;
  String? modifiedAt;
  String? modifiedBy;

  Items(
      {this.accountHolderName,
      this.accountId,
      this.bankAccountNumber,
      this.bankName,
      this.branch,
      this.createdAt,
      this.createdBy,
      this.id,
      this.ifscCode,
      this.isVerified,
      this.modifiedAt,
      this.modifiedBy});

  Items.fromJson(Map<String, dynamic> json) {
    accountHolderName = json['accountHolderName'];
    accountId = json['accountId'];
    bankAccountNumber = json['bankAccountNumber'];
    bankName = json['bankName'];
    branch = json['branch'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    id = json['id'];
    ifscCode = json['ifscCode'];
    isVerified = json['isVerified'];
    modifiedAt = json['modifiedAt'];
    modifiedBy = json['modifiedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountHolderName'] = this.accountHolderName;
    data['accountId'] = this.accountId;
    data['bankAccountNumber'] = this.bankAccountNumber;
    data['bankName'] = this.bankName;
    data['branch'] = this.branch;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['id'] = this.id;
    data['ifscCode'] = this.ifscCode;
    data['isVerified'] = this.isVerified;
    data['modifiedAt'] = this.modifiedAt;
    data['modifiedBy'] = this.modifiedBy;
    return data;
  }
}
