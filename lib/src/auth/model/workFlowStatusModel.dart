class WorkFlowStatusModel {
  String? auditAction;
  String? createdAt;
  String? createdBy;
  String? fromStateCode;
  String? fromStateId;
  String? fromStateName;
  String? id;
  String? referenceId;
  String? submissionComments;
  String? toStateCode;
  String? toStateId;
  String? toStateName;

  WorkFlowStatusModel(
      {this.auditAction,
      this.createdAt,
      this.createdBy,
      this.fromStateCode,
      this.fromStateId,
      this.fromStateName,
      this.id,
      this.referenceId,
      this.submissionComments,
      this.toStateCode,
      this.toStateId,
      this.toStateName});

  WorkFlowStatusModel.fromJson(Map<String, dynamic> json) {
    auditAction = json["auditAction"];
    createdAt = json["createdAt"];
    createdBy = json["createdBy"];
    fromStateCode = json["fromStateCode"];
    fromStateId = json["fromStateId"];
    fromStateName = json["fromStateName"];
    id = json["id"];
    referenceId = json["referenceId"].toString();
    submissionComments = json["submissionComments"];
    toStateCode = json["toStateCode"];
    toStateId = json["toStateId"].toString();
    toStateName = json["toStateName"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['auditAction'] = auditAction;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['fromStateCode'] = fromStateCode;
    data['id'] = id;
    data['referenceId'] = referenceId;
    data['submissionComments'] = submissionComments;
    data['toStateCode'] = toStateCode;
    data['toStateId'] = toStateId;
    data['toStateName'] = toStateName;

    return data;
  }
}
