class GetUserProfileModel {
  GetUserProfileModel({
    bool? status,
    int? success,
    GetUserProfileModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  GetUserProfileModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? GetUserProfileModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }

  bool? _status;
  int? _success;
  GetUserProfileModelData? _data;
  String? _msg;

  bool? get status => _status;

  int? get success => _success;

  GetUserProfileModelData? get data => _data;

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

class GetUserProfileModelData {
  GetUserProfileModelData({
    UserProfileModel? user,
  }) {
    _user = user;
  }

  GetUserProfileModelData.fromJson(dynamic json) {
    _user =
        json['user'] != null ? UserProfileModel.fromJson(json['user']) : null;
  }

  UserProfileModel? _user;

  UserProfileModel? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

class UserProfileModel {
  UserProfileModel({
    int? id,
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
    int? adminUser,
    dynamic fbId,
    dynamic googleId,
    String? createdAt,
    String? updatedAt,
    dynamic userCountry,
    dynamic mentee,
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
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _userCountry = userCountry;
    _mentee = mentee;
  }

  UserProfileModel.fromJson(dynamic json) {
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
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _userCountry = json['user_country'];
    _mentee = json['mentee'];
  }

  int? _id;
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
  int? _adminUser;
  dynamic _fbId;
  dynamic _googleId;
  String? _createdAt;
  String? _updatedAt;
  dynamic _userCountry;
  dynamic _mentee;

  int? get id => _id;

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

  int? get adminUser => _adminUser;

  dynamic get fbId => _fbId;

  dynamic get googleId => _googleId;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  dynamic get userCountry => _userCountry;

  dynamic get mentee => _mentee;

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
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['user_country'] = _userCountry;
    map['mentee'] = _mentee;
    return map;
  }
}
