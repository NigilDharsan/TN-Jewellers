class OrderDetailsModel {
  bool? status;
  Data? data;
  OrderDetailsModel({this.status, this.data});
  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
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
  int? stoneWt;
  int? reqWt;
  int? pieces;
  String? dimension;
  String? remarks;
  List<Images>? images;
  List<Videos>? videos;
  List<Audios>? audios;

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
      this.remarks,
      this.images,
      this.videos,
      this.audios});

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
    stoneWt = json['stone_wt'].toInt();
    reqWt = json['req_wt'].toInt();
    pieces = json['pieces'].toInt();
    dimension = json['dimension'];
    remarks = json['remarks'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(Videos.fromJson(v));
      });
    }
    if (json['audios'] != null) {
      audios = <Audios>[];
      json['audios'].forEach((v) {
        audios!.add(Audios.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_nick_name'] = customerNickName;
    data['status'] = status;
    data['status_colour'] = statusColour;
    data['order_no'] = orderNo;
    data['order_type'] = orderType;
    data['exp_delivery_date'] = expDeliveryDate;
    data['product_name'] = productName;
    data['design_name'] = designName;
    data['stone_name'] = stoneName;
    data['stone_wt'] = stoneWt;
    data['req_wt'] = reqWt;
    data['pieces'] = pieces;
    data['dimension'] = dimension;
    data['remarks'] = remarks;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    if (audios != null) {
      data['audios'] = audios!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? detOrderImgId;
  String? name;
  String? image;
  String? orderDetail;

  Images({this.detOrderImgId, this.name, this.image, this.orderDetail});

  Images.fromJson(Map<String, dynamic> json) {
    detOrderImgId = json['det_order_img_id'];
    name = json['name'];
    image = json['image'];
    orderDetail = json['order_detail'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['det_order_img_id'] = detOrderImgId;
    data['name'] = name;
    data['image'] = image;
    data['order_detail'] = orderDetail;
    return data;
  }
}

class Videos {
  int? detOrderVidId;
  int? orderDetail;
  String? name;
  String? video;

  Videos({this.detOrderVidId, this.orderDetail, this.name, this.video});

  Videos.fromJson(Map<String, dynamic> json) {
    detOrderVidId = json['det_order_vid_id'];
    orderDetail = json['order_detail'];
    name = json['name'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['det_order_vid_id'] = detOrderVidId;
    data['order_detail'] = orderDetail;
    data['name'] = name;
    data['video'] = video;
    return data;
  }
}

class Audios {
  int? detOrderAudioId;
  int? orderDetail;
  String? name;
  String? audio;

  Audios({this.detOrderAudioId, this.orderDetail, this.name, this.audio});

  Audios.fromJson(Map<String, dynamic> json) {
    detOrderAudioId = json['det_order_audio_id'];
    orderDetail = json['order_detail'];
    name = json['name'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['det_order_audio_id'] = this.detOrderAudioId;
    data['order_detail'] = this.orderDetail;
    data['name'] = this.name;
    data['audio'] = this.audio;
    return data;
  }
}
