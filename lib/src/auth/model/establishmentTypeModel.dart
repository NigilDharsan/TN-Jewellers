class EastablishmentModel {
  List<Countries>? countries;
  List<AccountTypes>? accountTypes;
  List<OperationalArea>? OpAreas;
  List<Configurations>? configurations;

  EastablishmentModel(
      {this.countries, this.accountTypes, this.OpAreas, this.configurations});

  EastablishmentModel.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
    if (json['accountTypes'] != null) {
      accountTypes = <AccountTypes>[];
      json['accountTypes'].forEach((v) {
        accountTypes!.add(new AccountTypes.fromJson(v));
      });
    }
    if (json['OpAreas'] != null) {
      OpAreas = <OperationalArea>[];
      json['OpAreas'].forEach((v) {
        OpAreas!.add(new OperationalArea.fromJson(v));
      });
    }
    if (json['Configurations'] != null) {
      configurations = <Configurations>[];
      json['Configurations'].forEach((v) {
        configurations!.add(new Configurations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    if (this.accountTypes != null) {
      data['accountTypes'] = this.accountTypes!.map((v) => v.toJson()).toList();
    }
    if (this.OpAreas != null) {
      data['OpAreas'] = this.OpAreas!.map((v) => v.toJson()).toList();
    }
    if (this.configurations != null) {
      data['Configurations'] =
          this.configurations!.map((v) => v.toJson()).toList();
    }
    if (this.configurations != null) {
      data['Configurations'] =
          this.configurations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countries {
  String? id;
  String? name;
  String? code;
  String? dialCode;

  Countries({this.id, this.name, this.code, this.dialCode});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    dialCode = json['dialCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['dialCode'] = this.dialCode;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Countries) return false;
    return id == other.id; // Compare based on id (or another unique field)
  }

  @override
  int get hashCode => id.hashCode; // Use id for hash code
}

class AccountTypes {
  String? id;
  String? name;
  String? code;

  AccountTypes({this.id, this.name, this.code});

  factory AccountTypes.fromJson(Map<String, dynamic> json) {
    final localizedName;
    if (json['localized'] != null) {
      localizedName = json['localized']['name'];
    } else {
      localizedName = json['name'];
    }
    return AccountTypes(
      id: json['id'],
      name: localizedName,
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AccountTypes &&
        other.id == id &&
        other.name == name &&
        other.code == code;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ code.hashCode;

  @override
  String toString() {
    return 'AccountTypes{id: $id, name: $name, code: $code}';
  }
}

class OperationalArea {
  String? id;
  String? name;

  OperationalArea({this.id, this.name});

  factory OperationalArea.fromJson(Map<String, dynamic> json) {
    return OperationalArea(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OperationalArea && other.id == id && other.name == name;
  }

  @override
  String toString() {
    return 'OperationalArea{id: $id, name: $name}';
  }
}

class Configurations {
  String? androidVersion;
  String? iosVersion;
  bool? isForceUpdate;
  bool? isSmsRequired;
  bool? isEmailRequired;
  bool? isStartPickRequired;
  bool? isDeleteAccount;

  Configurations(
      {this.androidVersion,
      this.iosVersion,
      this.isForceUpdate,
      this.isSmsRequired,
      this.isEmailRequired,
      this.isStartPickRequired,
      this.isDeleteAccount});

  Configurations.fromJson(Map<String, dynamic> json) {
    androidVersion = json['androidVersion'];
    iosVersion = json['iosVersion'];
    isForceUpdate = json['isForceUpdate'];
    isSmsRequired = json['isSmsRequired'];
    isEmailRequired = json['isEmailRequired'];
    isStartPickRequired = json['isStartPickRequired'];
    isDeleteAccount = json['isDeleteAccount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['androidVersion'] = this.androidVersion;
    data['iosVersion'] = this.iosVersion;
    data['isForceUpdate'] = this.isForceUpdate;
    data['isSmsRequired'] = this.isSmsRequired;
    data['isEmailRequired'] = this.isEmailRequired;
    data['isStartPickRequired'] = this.isStartPickRequired;
    data['isDeleteAccount'] = this.isDeleteAccount;
    return data;
  }
}
