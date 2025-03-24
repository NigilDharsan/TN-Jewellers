class OrderDetailsModel {
  bool? status;
  Data? data;

  OrderDetailsModel({this.status, this.data});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? customerNickName;
  String? status;
  String? statusColour;
  String? orderNo;
  String? orderType;
  String? expDeliveryDate;
  String? productName;
  String? designName;
  String? stoneName;
  double? stoneWt;
  double? reqWt;
  int? pieces;
  String? dimension;
  String? remarks;

  Data(
      {this.customerNickName,
      this.status,
      this.statusColour,
      this.orderNo,
      this.orderType,
      this.expDeliveryDate,
      this.productName,
      this.designName,
      this.stoneName,
      this.stoneWt,
      this.reqWt,
      this.pieces,
      this.dimension,
      this.remarks});

  Data.fromJson(Map<String, dynamic> json) {
    customerNickName = json['customer_nick_name'];
    status = json['status'];
    statusColour = json['status_colour'];
    orderNo = json['order_no'];
    orderType = json['order_type'];
    expDeliveryDate = json['exp_delivery_date'];
    productName = json['product_name'];
    designName = json['design_name'];
    stoneName = json['stone_name'];
    stoneWt = json['stone_wt'];
    reqWt = json['req_wt'];
    pieces = json['pieces'];
    dimension = json['dimension'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_nick_name'] = this.customerNickName;
    data['status'] = this.status;
    data['status_colour'] = this.statusColour;
    data['order_no'] = this.orderNo;
    data['order_type'] = this.orderType;
    data['exp_delivery_date'] = this.expDeliveryDate;
    data['product_name'] = this.productName;
    data['design_name'] = this.designName;
    data['stone_name'] = this.stoneName;
    data['stone_wt'] = this.stoneWt;
    data['req_wt'] = this.reqWt;
    data['pieces'] = this.pieces;
    data['dimension'] = this.dimension;
    data['remarks'] = this.remarks;
    return data;
  }
}
