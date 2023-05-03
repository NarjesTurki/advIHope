class GetMenteeProfileModel {
  GetMenteeProfileModel({
    bool? status,
    int? success,
    GetMenteeProfileModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  GetMenteeProfileModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? GetMenteeProfileModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  GetMenteeProfileModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  GetMenteeProfileModelData? get data => _data;
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

class GetMenteeProfileModelData {
  GetMenteeProfileModelData({
    UserForMenteeModel? user,
  }) {
    _user = user;
  }

  GetMenteeProfileModelData.fromJson(dynamic json) {
    _user =
        json['user'] != null ? UserForMenteeModel.fromJson(json['user']) : null;
  }
  UserForMenteeModel? _user;

  UserForMenteeModel? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

class UserForMenteeModel {
  UserForMenteeModel({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
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
    String? createdAt,
    String? updatedAt,
    dynamic userCountry,
    MenteeModel? mentee,
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
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _userCountry = userCountry;
    _mentee = mentee;
  }

  UserForMenteeModel.fromJson(dynamic json) {
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
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _userCountry = json['user_country'];
    _mentee =
        json['mentee'] != null ? MenteeModel.fromJson(json['mentee']) : null;
  }
  int? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
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
  String? _createdAt;
  String? _updatedAt;
  dynamic _userCountry;
  MenteeModel? _mentee;

  int? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
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
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get userCountry => _userCountry;
  MenteeModel? get mentee => _mentee;

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
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['user_country'] = _userCountry;
    if (_mentee != null) {
      map['mentee'] = _mentee?.toJson();
    }
    return map;
  }
}

class MenteeModel {
  MenteeModel({
    int? id,
    int? userId,
    dynamic description,
    dynamic walletId,
    dynamic walletAmount,
    dynamic isActive,
    int? identityHidden,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _userId = userId;
    _description = description;
    _walletId = walletId;
    _walletAmount = walletAmount;
    _isActive = isActive;
    _identityHidden = identityHidden;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  MenteeModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _description = json['description'];
    _walletId = json['wallet_id'];
    _walletAmount = json['wallet_amount'];
    _isActive = json['is_active'];
    _identityHidden = json['identity_hidden'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _userId;
  dynamic _description;
  dynamic _walletId;
  dynamic _walletAmount;
  dynamic _isActive;
  int? _identityHidden;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get userId => _userId;
  dynamic get description => _description;
  dynamic get walletId => _walletId;
  dynamic get walletAmount => _walletAmount;
  dynamic get isActive => _isActive;
  int? get identityHidden => _identityHidden;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['description'] = _description;
    map['wallet_id'] = _walletId;
    map['wallet_amount'] = _walletAmount;
    map['is_active'] = _isActive;
    map['identity_hidden'] = _identityHidden;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
