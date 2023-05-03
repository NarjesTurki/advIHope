class GetMentorProfileForMenteeModel {
  GetMentorProfileForMenteeModel({
    bool? status,
    int? success,
    GetMentorProfileForMenteeModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  GetMentorProfileForMenteeModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? GetMentorProfileForMenteeModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  GetMentorProfileForMenteeModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  GetMentorProfileForMenteeModelData? get data => _data;
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

class GetMentorProfileForMenteeModelData {
  GetMentorProfileForMenteeModelData({
    String? accessToken,
    GetMentorProfileForMenteeModelDataUserDetail? userDetail,
  }) {
    _accessToken = accessToken;
    _userDetail = userDetail;
  }

  GetMentorProfileForMenteeModelData.fromJson(dynamic json) {
    _accessToken = json['AccessToken'];
    _userDetail = json['userDetail'] != null
        ? GetMentorProfileForMenteeModelDataUserDetail.fromJson(
            json['userDetail'])
        : null;
  }
  String? _accessToken;
  GetMentorProfileForMenteeModelDataUserDetail? _userDetail;

  String? get accessToken => _accessToken;
  GetMentorProfileForMenteeModelDataUserDetail? get userDetail => _userDetail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AccessToken'] = _accessToken;
    if (_userDetail != null) {
      map['userDetail'] = _userDetail?.toJson();
    }
    return map;
  }
}

class GetMentorProfileForMenteeModelDataUserDetail {
  GetMentorProfileForMenteeModelDataUserDetail({
    int? id,
    String? firstName,
    String? lastName,
    String? fatherName,
    String? gender,
    String? city,
    int? country,
    String? imagePath,
    String? onlineStatus,
    int? ratingsAvg,
    int? ratingCount,
    Mentor? mentor,
    List<Educations>? educations,
    List<Experiences>? experiences,
    UserCountry? userCountry,
  }) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _fatherName = fatherName;
    _gender = gender;
    _city = city;
    _country = country;
    _imagePath = imagePath;
    _onlineStatus = onlineStatus;
    _ratingsAvg = ratingsAvg;
    _ratingCount = ratingCount;
    _mentor = mentor;
    _educations = educations;
    _experiences = experiences;
    _userCountry = userCountry;
  }

  GetMentorProfileForMenteeModelDataUserDetail.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _fatherName = json['father_name'];
    _gender = json['gender'];
    _city = json['city'];
    _country = json['country'];
    _imagePath = json['image_path'];
    _onlineStatus = json['online_status'];
    _ratingsAvg = json['ratingsAvg'];
    _ratingCount = json['ratingCount'];
    _mentor = json['mentor'] != null ? Mentor.fromJson(json['mentor']) : null;
    if (json['educations'] != null) {
      _educations = [];
      json['educations'].forEach((v) {
        _educations?.add(Educations.fromJson(v));
      });
    }
    if (json['experiences'] != null) {
      _experiences = [];
      json['experiences'].forEach((v) {
        _experiences?.add(Experiences.fromJson(v));
      });
    }
    _userCountry = json['user_country'] != null
        ? UserCountry.fromJson(json['user_country'])
        : null;
  }
  int? _id;
  String? _firstName;
  String? _lastName;
  String? _fatherName;
  String? _gender;
  String? _city;
  int? _country;
  String? _imagePath;
  String? _onlineStatus;
  int? _ratingsAvg;
  int? _ratingCount;
  Mentor? _mentor;
  List<Educations>? _educations;
  List<Experiences>? _experiences;
  UserCountry? _userCountry;

  int? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get fatherName => _fatherName;
  String? get gender => _gender;
  String? get city => _city;
  int? get country => _country;
  String? get imagePath => _imagePath;
  String? get onlineStatus => _onlineStatus;
  int? get ratingsAvg => _ratingsAvg;
  int? get ratingCount => _ratingCount;
  Mentor? get mentor => _mentor;
  List<Educations>? get educations => _educations;
  List<Experiences>? get experiences => _experiences;
  UserCountry? get userCountry => _userCountry;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['father_name'] = _fatherName;
    map['gender'] = _gender;
    map['city'] = _city;
    map['country'] = _country;
    map['image_path'] = _imagePath;
    map['online_status'] = _onlineStatus;
    map['ratingsAvg'] = _ratingsAvg;
    map['ratingCount'] = _ratingCount;
    if (_mentor != null) {
      map['mentor'] = _mentor?.toJson();
    }
    if (_educations != null) {
      map['educations'] = _educations?.map((v) => v.toJson()).toList();
    }
    if (_experiences != null) {
      map['experiences'] = _experiences?.map((v) => v.toJson()).toList();
    }
    if (_userCountry != null) {
      map['user_country'] = _userCountry?.toJson();
    }
    return map;
  }
}

class UserCountry {
  UserCountry({
    int? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  UserCountry.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  String? _name;

  int? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}

class Experiences {
  Experiences({
    int? id,
    int? mentorId,
    String? company,
    String? from,
    String? to,
    String? imagePath,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _mentorId = mentorId;
    _company = company;
    _from = from;
    _to = to;
    _imagePath = imagePath;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Experiences.fromJson(dynamic json) {
    _id = json['id'];
    _mentorId = json['mentor_id'];
    _company = json['company'];
    _from = json['from'];
    _to = json['to'];
    _imagePath = json['image_path'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _mentorId;
  String? _company;
  String? _from;
  String? _to;
  String? _imagePath;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get mentorId => _mentorId;
  String? get company => _company;
  String? get from => _from;
  String? get to => _to;
  String? get imagePath => _imagePath;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['mentor_id'] = _mentorId;
    map['company'] = _company;
    map['from'] = _from;
    map['to'] = _to;
    map['image_path'] = _imagePath;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Educations {
  Educations({
    int? id,
    int? mentorId,
    String? institute,
    String? degree,
    String? subject,
    String? period,
    String? imagePath,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _mentorId = mentorId;
    _institute = institute;
    _degree = degree;
    _subject = subject;
    _period = period;
    _imagePath = imagePath;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Educations.fromJson(dynamic json) {
    _id = json['id'];
    _mentorId = json['mentor_id'];
    _institute = json['institute'];
    _degree = json['degree'];
    _subject = json['subject'];
    _period = json['period'];
    _imagePath = json['image_path'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _mentorId;
  String? _institute;
  String? _degree;
  String? _subject;
  String? _period;
  String? _imagePath;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get mentorId => _mentorId;
  String? get institute => _institute;
  String? get degree => _degree;
  String? get subject => _subject;
  String? get period => _period;
  String? get imagePath => _imagePath;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['mentor_id'] = _mentorId;
    map['institute'] = _institute;
    map['degree'] = _degree;
    map['subject'] = _subject;
    map['period'] = _period;
    map['image_path'] = _imagePath;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Mentor {
  Mentor({
    int? id,
    int? userId,
    int? mentorCategoryId,
    int? parentCategoryId,
    dynamic description,
    dynamic paymentType,
    int? status,
    int? isProfileCompleted,
    dynamic isVerified,
    dynamic fee,
    String? createdAt,
    String? updatedAt,
    List<CategoryListFromGetProfile>? category,
  }) {
    _id = id;
    _userId = userId;
    _mentorCategoryId = mentorCategoryId;
    _parentCategoryId = parentCategoryId;
    _description = description;
    _paymentType = paymentType;
    _status = status;
    _isProfileCompleted = isProfileCompleted;
    _isVerified = isVerified;
    _fee = fee;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _category = category;
  }

  Mentor.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _mentorCategoryId = json['mentor_category_id'];
    _parentCategoryId = json['parent_category_id'];
    _description = json['description'];
    _paymentType = json['payment_type'];
    _status = json['status'];
    _isProfileCompleted = json['is_profile_completed'];
    _isVerified = json['is_verified'];
    _fee = json['fee'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['categories'] != null) {
      _category = [];
      json['categories'].forEach((v) {
        _category?.add(CategoryListFromGetProfile.fromJson(v));
      });
    }
  }
  int? _id;
  int? _userId;
  int? _mentorCategoryId;
  int? _parentCategoryId;
  dynamic _description;
  dynamic _paymentType;
  int? _status;
  int? _isProfileCompleted;
  dynamic _isVerified;
  dynamic _fee;
  String? _createdAt;
  String? _updatedAt;
  List<CategoryListFromGetProfile>? _category;

  int? get id => _id;
  int? get userId => _userId;
  int? get mentorCategoryId => _mentorCategoryId;
  int? get parentCategoryId => _parentCategoryId;
  dynamic get description => _description;
  dynamic get paymentType => _paymentType;
  int? get status => _status;
  int? get isProfileCompleted => _isProfileCompleted;
  dynamic get isVerified => _isVerified;
  dynamic get fee => _fee;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<CategoryListFromGetProfile>? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['mentor_category_id'] = _mentorCategoryId;
    map['parent_category_id'] = _parentCategoryId;
    map['description'] = _description;
    map['payment_type'] = _paymentType;
    map['status'] = _status;
    map['is_profile_completed'] = _isProfileCompleted;
    map['is_verified'] = _isVerified;
    map['fee'] = _fee;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_category != null) {
      map['categories'] = _category?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class CategoryListFromGetProfile {
  CategoryListFromGetProfile({
    int? id,
    int? mentorId,
    int? categoryId,
    CategoryFromGetProfile? category,
  }) {
    _id = id;
    _mentorId = mentorId;
    _categoryId = categoryId;
    _category = category;
  }

  CategoryListFromGetProfile.fromJson(dynamic json) {
    _id = json['id'];
    _mentorId = json['mentor_id'];
    _categoryId = json['category_id'];
    _category = json['category'] != null
        ? CategoryFromGetProfile.fromJson(json['category'])
        : null;
  }
  int? _id;
  int? _mentorId;
  int? _categoryId;
  CategoryFromGetProfile? _category;

  int? get id => _id;
  int? get mentorId => _mentorId;
  int? get categoryId => _categoryId;
  CategoryFromGetProfile? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['mentor_id'] = _mentorId;
    map['category_id'] = _categoryId;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    return map;
  }
}

class CategoryFromGetProfile {
  CategoryFromGetProfile({
    int? id,
    int? parentId,
    String? name,
    String? slug,
    String? imagePath,
    dynamic description,
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

  CategoryFromGetProfile.fromJson(dynamic json) {
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
  dynamic _description;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get parentId => _parentId;
  String? get name => _name;
  String? get slug => _slug;
  String? get imagePath => _imagePath;
  dynamic get description => _description;
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

// class Category {
//   Category({
//       int? id,
//       int? parentId,
//       String? name,
//       String? slug,
//       String? imagePath,
//       dynamic description,
//       String? createdAt,
//       String? updatedAt,}){
//     _id = id;
//     _parentId = parentId;
//     _name = name;
//     _slug = slug;
//     _imagePath = imagePath;
//     _description = description;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
// }
//
//   Category.fromJson(dynamic json) {
//     _id = json['id'];
//     _parentId = json['parent_id'];
//     _name = json['name'];
//     _slug = json['slug'];
//     _imagePath = json['image_path'];
//     _description = json['description'];
//     _createdAt = json['created_at'];
//     _updatedAt = json['updated_at'];
//   }
//   int? _id;
//   int? _parentId;
//   String? _name;
//   String? _slug;
//   String? _imagePath;
//   dynamic _description;
//   String? _createdAt;
//   String? _updatedAt;
//
//   int? get id => _id;
//   int? get parentId => _parentId;
//   String? get name => _name;
//   String? get slug => _slug;
//   String? get imagePath => _imagePath;
//   dynamic get description => _description;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['parent_id'] = _parentId;
//     map['name'] = _name;
//     map['slug'] = _slug;
//     map['image_path'] = _imagePath;
//     map['description'] = _description;
//     map['created_at'] = _createdAt;
//     map['updated_at'] = _updatedAt;
//     return map;
//   }
//
// }