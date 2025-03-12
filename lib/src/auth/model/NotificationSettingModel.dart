class NotificationSettingModel {
  String? extra;
  String? filter;
  List<Items>? items;
  String? orderBy;
  int? page;
  int? pageSize;
  int? totalItemCount;

  NotificationSettingModel(
      {this.extra,
      this.filter,
      this.items,
      this.orderBy,
      this.page,
      this.pageSize,
      this.totalItemCount});

  NotificationSettingModel.fromJson(Map<String, dynamic> json) {
    if (json['extra'] != null) {
      extra = "";
    }

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
  String? createdAt;
  String? createdBy;
  String? id;
  String? modifiedAt;
  String? modifiedBy;
  String? notification;
  String? notificationType;
  String? userId;

  Items(
      {this.createdAt,
      this.createdBy,
      this.id,
      this.modifiedAt,
      this.modifiedBy,
      this.notification,
      this.notificationType,
      this.userId});

  Items.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    id = json['id'];
    modifiedAt = json['modifiedAt'];
    modifiedBy = json['modifiedBy'];
    notification = json['notification'];
    notificationType = json['notificationType'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['id'] = this.id;
    data['modifiedAt'] = this.modifiedAt;
    data['modifiedBy'] = this.modifiedBy;
    data['notification'] = this.notification;
    data['notificationType'] = this.notificationType;
    data['userId'] = this.userId;
    return data;
  }
}
