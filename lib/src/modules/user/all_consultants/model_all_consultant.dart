class AllCategoriesWithConsultantModel {
  AllCategoriesWithConsultantModel({
    bool? status,
    int? success,
    AllCategoriesWithConsultantModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  AllCategoriesWithConsultantModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? AllCategoriesWithConsultantModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  AllCategoriesWithConsultantModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  AllCategoriesWithConsultantModelData? get data => _data;
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

class AllCategoriesWithConsultantModelData {
  AllCategoriesWithConsultantModelData({
    List<Categories>? categories,
  }) {
    _categories = categories;
  }

  AllCategoriesWithConsultantModelData.fromJson(dynamic json) {
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(Categories.fromJson(v));
      });
    }
  }
  List<Categories>? _categories;

  List<Categories>? get categories => _categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_categories != null) {
      map['categories'] = _categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Categories {
  Categories({
    int? id,
    int? parentId,
    String? name,
    String? slug,
    String? imagePath,
    dynamic description,
    String? createdAt,
    String? updatedAt,
    Mentors? mentors,
  }) {
    _id = id;
    _parentId = parentId;
    _name = name;
    _slug = slug;
    _imagePath = imagePath;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _mentors = mentors;
  }

  Categories.fromJson(dynamic json) {
    _id = json['id'];
    _parentId = json['parent_id'];
    _name = json['name'];
    _slug = json['slug'];
    _imagePath = json['image_path'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _mentors =
        json['mentors'] != null ? Mentors.fromJson(json['mentors']) : null;
  }
  int? _id;
  int? _parentId;
  String? _name;
  String? _slug;
  String? _imagePath;
  dynamic _description;
  String? _createdAt;
  String? _updatedAt;
  Mentors? _mentors;

  int? get id => _id;
  int? get parentId => _parentId;
  String? get name => _name;
  String? get slug => _slug;
  String? get imagePath => _imagePath;
  dynamic get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Mentors? get mentors => _mentors;

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
    if (_mentors != null) {
      map['mentors'] = _mentors?.toJson();
    }
    return map;
  }
}

class Mentors {
  Mentors({
    int? currentPage,
    List<MentorsData>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Links>? links,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) {
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _links = links;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
  }

  Mentors.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MentorsData.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }
  int? _currentPage;
  List<MentorsData>? _data;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  List<Links>? _links;
  dynamic _nextPageUrl;
  String? _path;
  int? _perPage;
  dynamic _prevPageUrl;
  int? _to;
  int? _total;

  int? get currentPage => _currentPage;
  List<MentorsData>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  int? get from => _from;
  int? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  List<Links>? get links => _links;
  dynamic get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  int? get perPage => _perPage;
  dynamic get prevPageUrl => _prevPageUrl;
  int? get to => _to;
  int? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }
}

class Links {
  Links({
    dynamic url,
    String? label,
    bool? active,
  }) {
    _url = url;
    _label = label;
    _active = active;
  }

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }
  dynamic _url;
  String? _label;
  bool? _active;

  dynamic get url => _url;
  String? get label => _label;
  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }
}

class MentorsData {
  MentorsData({
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
    int? ratingCount,
    int? ratingAvg,
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
    _ratingCount = ratingCount;
    _ratingAvg = ratingAvg;
    _user = user;
  }

  MentorsData.fromJson(dynamic json) {
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
    _ratingCount = json['ratingCount'];
    _ratingAvg = json['ratingAvg'];
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
  int? _ratingCount;
  int? _ratingAvg;
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
  int? get ratingCount => _ratingCount;
  int? get ratingAvg => _ratingAvg;
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
    map['ratingCount'] = _ratingCount;
    map['ratingAvg'] = _ratingAvg;
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
