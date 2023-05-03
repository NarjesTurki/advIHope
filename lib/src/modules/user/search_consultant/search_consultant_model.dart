class SearchConsultantModel {
  SearchConsultantModel({
    bool? status,
    int? success,
    SearchConsultantModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  SearchConsultantModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? SearchConsultantModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  SearchConsultantModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  SearchConsultantModelData? get data => _data;
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

class SearchConsultantModelData {
  SearchConsultantModelData({
    List<Results>? results,
  }) {
    _results = results;
  }

  SearchConsultantModelData.fromJson(dynamic json) {
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Results.fromJson(v));
      });
    }
  }
  List<Results>? _results;

  List<Results>? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Results {
  Results({
    int? id,
    int? userId,
    dynamic description,
    dynamic paymentType,
    int? status,
    int? isProfileCompleted,
    int? isFeatured,
    int? isLive,
    dynamic isVerified,
    dynamic fee,
    String? createdAt,
    String? updatedAt,
    Category? category,
    int? ratingAvg,
    int? ratingCount,
    User? user,
  }) {
    _id = id;
    _userId = userId;
    _description = description;
    _paymentType = paymentType;
    _status = status;
    _isProfileCompleted = isProfileCompleted;
    _isFeatured = isFeatured;
    _isLive = isLive;
    _isVerified = isVerified;
    _fee = fee;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _category = category;
    _ratingAvg = ratingAvg;
    _ratingCount = ratingCount;
    _user = user;
  }

  Results.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _description = json['description'];
    _paymentType = json['payment_type'];
    _status = json['status'];
    _isProfileCompleted = json['is_profile_completed'];
    _isFeatured = json['is_featured'];
    _isLive = json['is_live'];
    _isVerified = json['is_verified'];
    _fee = json['fee'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    _ratingAvg = json['ratingAvg'];
    _ratingCount = json['ratingCount'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  int? _id;
  int? _userId;
  dynamic _description;
  dynamic _paymentType;
  int? _status;
  int? _isProfileCompleted;
  int? _isFeatured;
  int? _isLive;
  dynamic _isVerified;
  dynamic _fee;
  String? _createdAt;
  String? _updatedAt;
  Category? _category;
  int? _ratingAvg;
  int? _ratingCount;
  User? _user;

  int? get id => _id;
  int? get userId => _userId;
  dynamic get description => _description;
  dynamic get paymentType => _paymentType;
  int? get status => _status;
  int? get isProfileCompleted => _isProfileCompleted;
  int? get isFeatured => _isFeatured;
  int? get isLive => _isLive;
  dynamic get isVerified => _isVerified;
  dynamic get fee => _fee;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Category? get category => _category;
  int? get ratingAvg => _ratingAvg;
  int? get ratingCount => _ratingCount;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['description'] = _description;
    map['payment_type'] = _paymentType;
    map['status'] = _status;
    map['is_profile_completed'] = _isProfileCompleted;
    map['is_featured'] = _isFeatured;
    map['is_live'] = _isLive;
    map['is_verified'] = _isVerified;
    map['fee'] = _fee;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    map['ratingAvg'] = _ratingAvg;
    map['ratingCount'] = _ratingCount;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

class User {
  User({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? imagePath,
    int? country,
    String? city,
    String? address,
    dynamic postalCode,
    dynamic isOtpVerified,
    String? fatherName,
    String? cnic,
    String? gender,
    String? religion,
    String? dob,
    int? occupation,
    String? onlineStatus,
    int? adminUser,
    dynamic fbId,
    dynamic googleId,
    String? about,
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

  User.fromJson(dynamic json) {
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
  int? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  String? _imagePath;
  int? _country;
  String? _city;
  String? _address;
  dynamic _postalCode;
  dynamic _isOtpVerified;
  String? _fatherName;
  String? _cnic;
  String? _gender;
  String? _religion;
  String? _dob;
  int? _occupation;
  String? _onlineStatus;
  int? _adminUser;
  dynamic _fbId;
  dynamic _googleId;
  String? _about;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get phone => _phone;
  String? get imagePath => _imagePath;
  int? get country => _country;
  String? get city => _city;
  String? get address => _address;
  dynamic get postalCode => _postalCode;
  dynamic get isOtpVerified => _isOtpVerified;
  String? get fatherName => _fatherName;
  String? get cnic => _cnic;
  String? get gender => _gender;
  String? get religion => _religion;
  String? get dob => _dob;
  int? get occupation => _occupation;
  String? get onlineStatus => _onlineStatus;
  int? get adminUser => _adminUser;
  dynamic get fbId => _fbId;
  dynamic get googleId => _googleId;
  String? get about => _about;
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

class Category {
  Category({
    int? id,
    int? parentId,
    String? name,
    String? slug,
    String? imagePath,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _parentId = parentId;
    _name = name;
    _slug = slug;
    _imagePath = imagePath;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _parentId = json['parent_id'];
    _name = json['name'];
    _slug = json['slug'];
    _imagePath = json['image_path'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _parentId;
  String? _name;
  String? _slug;
  String? _imagePath;
  String? _description;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get parentId => _parentId;
  String? get name => _name;
  String? get slug => _slug;
  String? get imagePath => _imagePath;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['parent_id'] = _parentId;
    map['name'] = _name;
    map['slug'] = _slug;
    map['image_path'] = _imagePath;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
