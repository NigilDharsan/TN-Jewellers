class OrderListModel {
  bool? status;
  List<OrderListData>? data;

  OrderListModel({this.status, this.data});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <OrderListData>[];
      json['data'].forEach((v) {
        data!.add(new OrderListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderListData {
  String? productName;
  String? customerNickName;
  String? designName;
  int? pieces;
  String? customerDueDate;
  String? weight;
  String? status;
  String? statusColour;
  int? pkId;

  OrderListData(
      {this.productName,
      this.customerNickName,
      this.designName,
      this.pieces,
      this.customerDueDate,
      this.weight,
      this.status,
      this.statusColour,
      this.pkId});

  OrderListData.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    customerNickName = json['customer_nick_name'];
    designName = json['design_name'];
    pieces = json['pieces'];
    customerDueDate = json['customer_due_date'];
    weight = json['weight'];
    status = json['status'];
    statusColour = json['status_colour'];
    pkId = json['pk_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['customer_nick_name'] = this.customerNickName;
    data['design_name'] = this.designName;
    data['pieces'] = this.pieces;
    data['customer_due_date'] = this.customerDueDate;
    data['weight'] = this.weight;
    data['status'] = this.status;
    data['status_colour'] = this.statusColour;
    data['pk_id'] = this.pkId;
    return data;
  }
}
