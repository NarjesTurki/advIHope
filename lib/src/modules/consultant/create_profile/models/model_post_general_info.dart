class GeneralInfoPostModel {
  GeneralInfoPostModel({
    bool? status,
    int? success,
    GeneralInfoPostModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  GeneralInfoPostModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? GeneralInfoPostModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  GeneralInfoPostModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  GeneralInfoPostModelData? get data => _data;
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

class GeneralInfoPostModelData {
  GeneralInfoPostModelData({
    String? accessToken,
    UserDetail? userDetail,
  }) {
    _accessToken = accessToken;
    _userDetail = userDetail;
  }

  GeneralInfoPostModelData.fromJson(dynamic json) {
    _accessToken = json['AccessToken'];
    _userDetail = json['userDetail'] != null
        ? UserDetail.fromJson(json['userDetail'])
        : null;
  }
  String? _accessToken;
  UserDetail? _userDetail;

  String? get accessToken => _accessToken;
  UserDetail? get userDetail => _userDetail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AccessToken'] = _accessToken;
    if (_userDetail != null) {
      map['userDetail'] = _userDetail?.toJson();
    }
    return map;
  }
}

class UserDetail {
  UserDetail({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? imagePath,
    String? country,
    String? city,
    String address = "",
    dynamic postalCode,
    dynamic isOtpVerified,
    String? fatherName,
    String? cnic,
    String? gender,
    String? religion,
    String? dob,
    String? occupation,
    //lien
    String? facebookUrl,
    String? instagramUrl,
    String? tiktokUrl,
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
    _facebookUrl = facebookUrl;
    _instagramUrl = instagramUrl;
    _tiktokUrl = tiktokUrl;
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
    _country = json['country'].toString();
    _city = json['city'];
    _address = json['address'];
    _postalCode = json['postal_code'];
    _isOtpVerified = json['is_otp_verified'];
    _fatherName = json['father_name'];
    _cnic = json['cnic'];
    _gender = json['gender'];
    _religion = json['religion'];
    _dob = json['dob'];
    _occupation = json['occupation'].toString();
    _facebookUrl = json['facebookUrl'];
    _instagramUrl = json['instagramUrl'];
    _tiktokUrl = json['tiktokUrl'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  String? _imagePath;
  String? _country;
  String? _city;
  String? _address;
  dynamic _postalCode;
  dynamic _isOtpVerified;
  String? _fatherName;
  String? _cnic;
  String? _gender;
  String? _religion;
  String? _dob;
  String? _occupation;
  String? _facebookUrl;
  String? _instagramUrl;
  String? _tiktokUrl;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get phone => _phone;
  String? get imagePath => _imagePath;
  String? get country => _country;
  String? get city => _city;
  String? get address => _address;
  dynamic get postalCode => _postalCode;
  dynamic get isOtpVerified => _isOtpVerified;
  String? get fatherName => _fatherName;
  String? get cnic => _cnic;
  String? get gender => _gender;
  String? get religion => _religion;
  String? get dob => _dob;
  String? get occupation => _occupation;
  String? get facebookUrl => _facebookUrl;
  String? get instagramUrl => _instagramUrl;
  String? get tiktokUrl => _tiktokUrl;
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
    map['facebookUrl'] = _facebookUrl;
    map['instagramUrl'] = _instagramUrl;
    map['tiktokUrl'] = _tiktokUrl;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
