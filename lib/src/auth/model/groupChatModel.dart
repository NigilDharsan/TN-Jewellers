class GroupChatModel {
  String? createdAt;
  String? createdBy;
  String? createdLocalDate;
  String? createdUTCDate;
  String? deletedAt;
  String? deletedBy;
  String? id;
  bool? isDeleted;
  String? modifiedAt;
  String? modifiedBy;
  String? name;
  bool? status;
  String? operationalAreaId;
  String? operationalAreaName;
  List<Member>? members;

  GroupChatModel({
    this.createdAt,
    this.createdBy,
    this.createdLocalDate,
    this.createdUTCDate,
    this.deletedAt,
    this.deletedBy,
    this.id,
    this.isDeleted,
    this.modifiedAt,
    this.modifiedBy,
    this.name,
    this.status,
    this.operationalAreaId,
    this.operationalAreaName,
    this.members,
  });

  GroupChatModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    createdLocalDate = json['createdLocalDate'];
    createdUTCDate = json['createdUTCDate'];
    deletedAt = json['deletedAt'];
    deletedBy = json['deletedBy'];
    id = json['id'];
    isDeleted = json['isDeleted'];
    modifiedAt = json['modifiedAt'];
    modifiedBy = json['modifiedBy'];
    name = json['name'];
    status = json['status'];
    operationalAreaId = json['operationalAreaId'];
    operationalAreaName = json['operationalAreaName'];
    if (json['members'] != null) {
      members = (json['members'] as List)
          .map((member) => Member.fromJson(member))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['createdLocalDate'] = createdLocalDate;
    data['createdUTCDate'] = createdUTCDate;
    data['deletedAt'] = deletedAt;
    data['deletedBy'] = deletedBy;
    data['id'] = id;
    data['isDeleted'] = isDeleted;
    data['modifiedAt'] = modifiedAt;
    data['modifiedBy'] = modifiedBy;
    data['name'] = name;
    data['status'] = status;
    data['operationalAreaId'] = operationalAreaId;
    data['operationalAreaName'] = operationalAreaName;
    if (members != null) {
      data['members'] = members!.map((member) => member.toJson()).toList();
    }
    return data;
  }
}

class Member {
  String? id;
  String? groupId;
  String? conversationId;
  String? userId;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? userEmail;

  Member({
    this.id,
    this.groupId,
    this.conversationId,
    this.userId,
    this.createdAt,
    this.createdBy,
    this.modifiedAt,
    this.modifiedBy,
    this.userEmail,
  });

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['groupId'];
    conversationId = json['conversationId'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    modifiedAt = json['modifiedAt'];
    modifiedBy = json['modifiedBy'];
    userEmail = json['userEmail'];
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
    return data;
  }
}
