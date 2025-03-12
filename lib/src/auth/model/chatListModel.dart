import 'dart:typed_data';

class ChatListModel {
  Map<String, dynamic>? extra;
  String? filter;
  List<ConversationItem>? items;
  String? orderBy;
  int? page;
  int? pageSize;
  int? totalItemCount;

  ChatListModel({
    this.extra,
    this.filter,
    this.items,
    this.orderBy,
    this.page,
    this.pageSize,
    this.totalItemCount,
  });

  ChatListModel.fromJson(Map<String, dynamic> json) {
    extra = json['extra'];
    filter = json['filter'];
    if (json['items'] != null) {
      items = <ConversationItem>[];
      json['items'].forEach((v) {
        items!.add(ConversationItem.fromJson(v));
      });
    }
    orderBy = json['orderBy'];
    page = json['page'];
    pageSize = json['pageSize'];
    totalItemCount = json['totalItemCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['extra'] = extra;
    data['filter'] = filter;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['orderBy'] = orderBy;
    data['page'] = page;
    data['pageSize'] = pageSize;
    data['totalItemCount'] = totalItemCount;
    return data;
  }
}

class ConversationItem {
  String? createdAt;
  String? createdBy;
  String? deletedAt;
  String? deletedBy;
  String? groupId;
  String? id;
  bool? isDeleted;
  String? lastMessageSenderFirstName;
  String? lastMessageSenderId;
  String? lastMessageSenderLastName;
  String? lastMessageText;
  String? lastMessageTimestamp;
  String? modifiedAt;
  String? modifiedBy;
  String? module;
  String? name;
  String? referenceNo;
  String? referenceId;
  String? type;
  int? unReadMessageCount;
  String? senderName;
  String? senderId;
  String? receiverName;
  String? receiverId;
  String? groupName;
  String? lastMessageType;
  String? receiverAvatarFile;
  String? receiverAvatarCode;
  Uint8List? ImageByte;
  String? groupAvatarFile;
  String? groupAvatarCode;

  ConversationItem(
      {this.createdAt,
      this.createdBy,
      this.deletedAt,
      this.deletedBy,
      this.groupId,
      this.id,
      this.isDeleted,
      this.lastMessageSenderFirstName,
      this.lastMessageSenderId,
      this.lastMessageSenderLastName,
      this.lastMessageText,
      this.lastMessageTimestamp,
      this.modifiedAt,
      this.modifiedBy,
      this.module,
      this.name,
      this.referenceNo,
      this.referenceId,
      this.type,
      this.unReadMessageCount,
      this.senderName,
      this.senderId,
      this.receiverName,
      this.receiverId,
      this.groupName,
      this.lastMessageType,
      this.receiverAvatarCode,
      this.receiverAvatarFile,
      this.groupAvatarCode,
      this.groupAvatarFile});

  ConversationItem.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    deletedAt = json['deletedAt'];
    deletedBy = json['deletedBy'];
    groupId = json['groupId'];
    id = json['id'];
    isDeleted = json['isDeleted'];
    lastMessageSenderFirstName = json['lastMessageSenderFirstName'];
    lastMessageSenderId = json['lastMessageSenderId'];
    lastMessageSenderLastName = json['lastMessageSenderLastName'];
    lastMessageText = json['lastMessageText'];
    lastMessageTimestamp = json['lastMessageTimestamp'];
    modifiedAt = json['modifiedAt'];
    modifiedBy = json['modifiedBy'];
    module = json['module'];
    name = json['name'];
    referenceNo = json['referenceNo'];
    referenceId = json['referenceId'];
    type = json['type'];
    unReadMessageCount = json['unReadMessageCount'];
    senderName = json['senderName'];
    senderId = json['senderId'];
    receiverName = json['receiverName'];
    receiverId = json['receiverId'];
    groupName = json['groupName'];
    lastMessageType = json['lastMessageType'];
    receiverAvatarCode = json['receiverAvatarCode'];
    receiverAvatarFile = json['receiverAvatarFile'];
    groupAvatarCode = json['groupAvatarCode'];
    groupAvatarFile = json['groupAvatarFile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['deletedAt'] = deletedAt;
    data['deletedBy'] = deletedBy;
    data['groupId'] = groupId;
    data['id'] = id;
    data['isDeleted'] = isDeleted;
    data['lastMessageSenderFirstName'] = lastMessageSenderFirstName;
    data['lastMessageSenderId'] = lastMessageSenderId;
    data['lastMessageSenderLastName'] = lastMessageSenderLastName;
    data['lastMessageText'] = lastMessageText;
    data['lastMessageTimestamp'] = lastMessageTimestamp;
    data['modifiedAt'] = modifiedAt;
    data['modifiedBy'] = modifiedBy;
    data['module'] = module;
    data['name'] = name;
    data['referenceNo'] = referenceNo;
    data['referenceId'] = referenceId;
    data['type'] = type;
    data['unReadMessageCount'] = unReadMessageCount;
    data['senderName'] = senderName;
    data['senderId'] = senderId;
    data['receiverName'] = receiverName;
    data['receiverId'] = receiverId;
    data['groupName'] = groupName;
    data['lastMessageType'] = lastMessageType;
    data['receiverAvatarCode'] = receiverAvatarCode;
    data['receiverAvatarFile'] = receiverAvatarFile;
    data['groupAvatarCode'] = groupAvatarCode;
    data['groupAvatarFile'] = groupAvatarFile;

    return data;
  }
}
