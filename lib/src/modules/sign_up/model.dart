class SignupModel {
  SignupModel({
    bool? status,
    int? success,
    String? accessToken,
    String? tokenType,
    String? expiresAt,
    Data? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _accessToken = accessToken;
    _tokenType = tokenType;
    _expiresAt = expiresAt;
    _data = data;
    _msg = msg;
  }

  SignupModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _accessToken = json['AccessToken'];
    _tokenType = json['token_type'];
    _expiresAt = json['expires_at'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  String? _accessToken;
  String? _tokenType;
  String? _expiresAt;
  Data? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  String? get accessToken => _accessToken;
  String? get tokenType => _tokenType;
  String? get expiresAt => _expiresAt;
  Data? get data => _data;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['success'] = _success;
    map['AccessToken'] = _accessToken;
    map['token_type'] = _tokenType;
    map['expires_at'] = _expiresAt;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['msg'] = _msg;
    return map;
  }
}

class Data {
  Data({
    User? user,
    dynamic role,
  }) {
    _user = user;
    _role = role;
  }

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _role = json['role'];
  }
  User? _user;
  dynamic _role;

  User? get user => _user;
  dynamic get role => _role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['role'] = _role;
    return map;
  }
}

class User {
  User({
    String? firstName,
    String? lastName,
    String? email,
    dynamic fbId,
    String? updatedAt,
    String? createdAt,
    int? id,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _fbId = fbId;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  User.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _fbId = json['fb_id'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  String? _firstName;
  String? _lastName;
  String? _email;
  dynamic _fbId;
  String? _updatedAt;
  String? _createdAt;
  int? _id;

  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  dynamic get fbId => _fbId;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['fb_id'] = _fbId;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }
}
