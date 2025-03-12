import 'dart:typed_data';

class PostConversationModel {
  String? createdAt;
  String? createdBy;
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
  String? referenceId;
  String? referenceNo;
  String? type;
  List<Members>? members;
  List<Messages>? messages;
  String? groupName;
  Uint8List? imageByte;
  String? profileName;

  PostConversationModel(
      {this.createdAt,
      this.createdBy,
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
      this.referenceId,
      this.referenceNo,
      this.type,
      this.members,
      this.messages,
      this.groupName,
      this.imageByte,
      this.profileName});

  PostConversationModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
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
    referenceId = json['referenceId'];
    referenceNo = json['referenceNo'];
    type = json['type'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
    groupName = json['groupName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
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
    data['referenceId'] = referenceId;
    data['referenceNo'] = referenceNo;
    data['type'] = type;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    data['groupName'] = groupName;
    return data;
  }
}

class Members {
  String? id;
  String? groupId;
  String? conversationId;
  String? userId;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? userEmail;
  String? firstName;
  String? lastName;
  String? userType;
  String? avatarFile;
  String? avatarCode;

  Members(
      {this.id,
      this.groupId,
      this.conversationId,
      this.userId,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.userEmail,
      this.firstName,
      this.lastName,
      this.userType,
      this.avatarCode,
      this.avatarFile});

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['groupId'];
    conversationId = json['conversationId'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    modifiedAt = json['modifiedAt'];
    modifiedBy = json['modifiedBy'];
    userEmail = json['userEmail'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userType = json['userType'];
    avatarCode = json['avatarCode'];
    avatarFile = json['avatarFile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['groupId'] = groupId;
    data['conversationId'] = conversationId;
    data['userId'] = userId;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['modifiedAt'] = modifiedAt;
    data['modifiedBy'] = modifiedBy;
    data['userEmail'] = userEmail;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['userType'] = userType;
    data['avatarCode'] = avatarCode;
    data['avatarFile'] = avatarFile;

    return data;
  }
}

class Messages {
  String? conversationId;
  String? createdAt;
  String? createdBy;
  String? id;
  bool? isDeleted;
  String? message;
  String? modifiedAt;
  String? modifiedBy;
  String? senderId;
  String? timestamp;
  String? type;
  String? documentId;
  String? filePath;
  String? fileExtension;

  Messages(
      {this.conversationId,
      this.createdAt,
      this.createdBy,
      this.id,
      this.isDeleted,
      this.message,
      this.modifiedAt,
      this.modifiedBy,
      this.senderId,
      this.timestamp,
      this.type,
      this.documentId,
      this.filePath,
      this.fileExtension});

  Messages.fromJson(Map<String, dynamic> json) {
    conversationId = json['conversationId'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    id = json['id'];
    isDeleted = json['isDeleted'];
    message = json['message'];
    modifiedAt = json['modifiedAt'];
    modifiedBy = json['modifiedBy'];
    senderId = json['senderId'];
    timestamp = json['timestamp'];
    type = json['type'];
    documentId = json['documentId'];
    filePath = json['filePath'];
    fileExtension = json['fileExtension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conversationId'] = conversationId;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['id'] = id;
    data['isDeleted'] = isDeleted;
    data['message'] = message;
    data['modifiedAt'] = modifiedAt;
    data['modifiedBy'] = modifiedBy;
    data['senderId'] = senderId;
    data['timestamp'] = timestamp;
    data['type'] = type;
    data['documentId'] = documentId;
    data['filePath'] = filePath;
    data['fileExtension'] = fileExtension;
    return data;
  }
}
