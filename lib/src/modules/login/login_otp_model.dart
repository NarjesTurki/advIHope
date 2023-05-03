class LoginOtpModel {
  LoginOtpModel({
    bool? status,
    num? success,
    Data? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  LoginOtpModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _msg = json['msg'];
  }
  bool? _status;
  num? _success;
  Data? _data;
  String? _msg;
  LoginOtpModel copyWith({
    bool? status,
    num? success,
    Data? data,
    String? msg,
  }) =>
      LoginOtpModel(
        status: status ?? _status,
        success: success ?? _success,
        data: data ?? _data,
        msg: msg ?? _msg,
      );
  bool? get status => _status;
  num? get success => _success;
  Data? get data => _data;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['msg'] = _msg;
    return map;
  }
}

class Data {
  Data({
    String? accessToken,
    String? tokenType,
    String? expiresAt,
    String? role,
    num? isLogin,
    List<UserDetail>? userDetail,
    num? isProfileComplete,
  }) {
    _accessToken = accessToken;
    _tokenType = tokenType;
    _expiresAt = expiresAt;
    _role = role;
    _isLogin = isLogin;
    _userDetail = userDetail;
    _isProfileComplete = isProfileComplete;
  }

  Data.fromJson(dynamic json) {
    _accessToken = json['AccessToken'];
    _tokenType = json['token_type'];
    _expiresAt = json['expires_at'];
    _role = json['role'];
    _isLogin = json['is_login'];
    if (json['userDetail'] != null) {
      _userDetail = [];
      json['userDetail'].forEach((v) {
        _userDetail?.add(UserDetail.fromJson(v));
      });
    }
    _isProfileComplete = json['is_profile_complete'];
  }
  String? _accessToken;
  String? _tokenType;
  String? _expiresAt;
  String? _role;
  num? _isLogin;
  List<UserDetail>? _userDetail;
  num? _isProfileComplete;
  Data copyWith({
    String? accessToken,
    String? tokenType,
    String? expiresAt,
    String? role,
    num? isLogin,
    List<UserDetail>? userDetail,
    num? isProfileComplete,
  }) =>
      Data(
        accessToken: accessToken ?? _accessToken,
        tokenType: tokenType ?? _tokenType,
        expiresAt: expiresAt ?? _expiresAt,
        role: role ?? _role,
        isLogin: isLogin ?? _isLogin,
        userDetail: userDetail ?? _userDetail,
        isProfileComplete: isProfileComplete ?? _isProfileComplete,
      );
  String? get accessToken => _accessToken;
  String? get tokenType => _tokenType;
  String? get expiresAt => _expiresAt;
  String? get role => _role;
  num? get isLogin => _isLogin;
  List<UserDetail>? get userDetail => _userDetail;
  num? get isProfileComplete => _isProfileComplete;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AccessToken'] = _accessToken;
    map['token_type'] = _tokenType;
    map['expires_at'] = _expiresAt;
    map['role'] = _role;
    map['is_login'] = _isLogin;
    if (_userDetail != null) {
      map['userDetail'] = _userDetail?.map((v) => v.toJson()).toList();
    }
    map['is_profile_complete'] = _isProfileComplete;
    return map;
  }
}

class UserDetail {
  UserDetail({
    num? id,
    dynamic firstName,
    dynamic lastName,
    dynamic email,
    String? phone,
    dynamic imagePath,
    dynamic country,
    dynamic city,
    dynamic address,
    dynamic postalCode,
    dynamic isOtpVerified,
    dynamic fatherName,
    dynamic cnic,
    dynamic gender,
    dynamic religion,
    dynamic dob,
    dynamic occupation,
    String? onlineStatus,
    num? adminUser,
    dynamic fbId,
    dynamic googleId,
    dynamic about,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _phone = phone;
    _imagePath = imagePath;
    _country = country;
    _city = city;
    _address = address;
    _postalCode = postalCode;
    _isOtpVerified = isOtpVerified;
    _fatherName = fatherName;
    _cnic = cnic;
    _gender = gender;
    _religion = religion;
    _dob = dob;
    _occupation = occupation;
    _onlineStatus = onlineStatus;
    _adminUser = adminUser;
    _fbId = fbId;
    _googleId = googleId;
    _about = about;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  UserDetail.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _phone = json['phone'];
    _imagePath = json['image_path'];
    _country = json['country'];
    _city = json['city'];
    _address = json['address'];
    _postalCode = json['postal_code'];
    _isOtpVerified = json['is_otp_verified'];
    _fatherName = json['father_name'];
    _cnic = json['cnic'];
    _gender = json['gender'];
    _religion = json['religion'];
    _dob = json['dob'];
    _occupation = json['occupation'];
    _onlineStatus = json['online_status'];
    _adminUser = json['admin_user'];
    _fbId = json['fb_id'];
    _googleId = json['google_id'];
    _about = json['about'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  dynamic _firstName;
  dynamic _lastName;
  dynamic _email;
  String? _phone;
  dynamic _imagePath;
  dynamic _country;
  dynamic _city;
  dynamic _address;
  dynamic _postalCode;
  dynamic _isOtpVerified;
  dynamic _fatherName;
  dynamic _cnic;
  dynamic _gender;
  dynamic _religion;
  dynamic _dob;
  dynamic _occupation;
  String? _onlineStatus;
  num? _adminUser;
  dynamic _fbId;
  dynamic _googleId;
  dynamic _about;
  String? _createdAt;
  String? _updatedAt;
  UserDetail copyWith({
    num? id,
    dynamic firstName,
    dynamic lastName,
    dynamic email,
    String? phone,
    dynamic imagePath,
    dynamic country,
    dynamic city,
    dynamic address,
    dynamic postalCode,
    dynamic isOtpVerified,
    dynamic fatherName,
    dynamic cnic,
    dynamic gender,
    dynamic religion,
    dynamic dob,
    dynamic occupation,
    String? onlineStatus,
    num? adminUser,
    dynamic fbId,
    dynamic googleId,
    dynamic about,
    String? createdAt,
    String? updatedAt,
  }) =>
      UserDetail(
        id: id ?? _id,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        email: email ?? _email,
        phone: phone ?? _phone,
        imagePath: imagePath ?? _imagePath,
        country: country ?? _country,
        city: city ?? _city,
        address: address ?? _address,
        postalCode: postalCode ?? _postalCode,
        isOtpVerified: isOtpVerified ?? _isOtpVerified,
        fatherName: fatherName ?? _fatherName,
        cnic: cnic ?? _cnic,
        gender: gender ?? _gender,
        religion: religion ?? _religion,
        dob: dob ?? _dob,
        occupation: occupation ?? _occupation,
        onlineStatus: onlineStatus ?? _onlineStatus,
        adminUser: adminUser ?? _adminUser,
        fbId: fbId ?? _fbId,
        googleId: googleId ?? _googleId,
        about: about ?? _about,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  dynamic get firstName => _firstName;
  dynamic get lastName => _lastName;
  dynamic get email => _email;
  String? get phone => _phone;
  dynamic get imagePath => _imagePath;
  dynamic get country => _country;
  dynamic get city => _city;
  dynamic get address => _address;
  dynamic get postalCode => _postalCode;
  dynamic get isOtpVerified => _isOtpVerified;
  dynamic get fatherName => _fatherName;
  dynamic get cnic => _cnic;
  dynamic get gender => _gender;
  dynamic get religion => _religion;
  dynamic get dob => _dob;
  dynamic get occupation => _occupation;
  String? get onlineStatus => _onlineStatus;
  num? get adminUser => _adminUser;
  dynamic get fbId => _fbId;
  dynamic get googleId => _googleId;
  dynamic get about => _about;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['image_path'] = _imagePath;
    map['country'] = _country;
    map['city'] = _city;
    map['address'] = _address;
    map['postal_code'] = _postalCode;
    map['is_otp_verified'] = _isOtpVerified;
    map['father_name'] = _fatherName;
    map['cnic'] = _cnic;
    map['gender'] = _gender;
    map['religion'] = _religion;
    map['dob'] = _dob;
    map['occupation'] = _occupation;
    map['online_status'] = _onlineStatus;
    map['admin_user'] = _adminUser;
    map['fb_id'] = _fbId;
    map['google_id'] = _googleId;
    map['about'] = _about;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
