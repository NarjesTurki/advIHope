class ConsultantProfileModel {
  ConsultantProfileModel({
    bool? status,
    int? success,
    ConsultantProfileModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  ConsultantProfileModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? ConsultantProfileModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }

  bool? _status;
  int? _success;
  ConsultantProfileModelData? _data;
  String? _msg;

  bool? get status => _status;

  int? get success => _success;

  ConsultantProfileModelData? get data => _data;

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

class ConsultantProfileModelData {
  ConsultantProfileModelData({
    ConsultantUserDetail? userDetail,
  }) {
    _userDetail = userDetail;
  }

  ConsultantProfileModelData.fromJson(dynamic json) {
    _userDetail = json['userDetail'] != null
        ? ConsultantUserDetail.fromJson(json['userDetail'])
        : null;
  }

  ConsultantUserDetail? _userDetail;

  ConsultantUserDetail? get userDetail => _userDetail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_userDetail != null) {
      map['userDetail'] = _userDetail?.toJson();
    }
    return map;
  }
}

class ConsultantUserDetail {
  ConsultantUserDetail({
    int? id,
    dynamic firstName,
    dynamic lastName,
    dynamic imagePath,
    String? createdAt,
    int? ratingsAvg,
    String? registerDate,
    List<ScheduleTypes>? scheduleTypes,
    List<ScheduleTypes>? withoutScheduleTypes,
    int? appointmentCount,
    MentorProfile? mentor,
  }) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _imagePath = imagePath;
    _createdAt = createdAt;
    _ratingsAvg = ratingsAvg;
    _registerDate = registerDate;
    _scheduleTypes = scheduleTypes;
    _withoutScheduleTypes = withoutScheduleTypes;
    _appointmentCount = appointmentCount;
    _mentor = mentor;
  }

  ConsultantUserDetail.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _imagePath = json['image_path'];
    _createdAt = json['created_at'];
    _ratingsAvg = json['ratingsAvg'];
    _registerDate = json['register_date'];
    if (json['schedule_types'] != null) {
      _scheduleTypes = [];
      json['schedule_types'].forEach((v) {
        _scheduleTypes?.add(ScheduleTypes.fromJson(v));
      });
    }
    if (json['without_schedule_types'] != null) {
      _withoutScheduleTypes = [];
      json['without_schedule_types'].forEach((v) {
        _withoutScheduleTypes?.add(ScheduleTypes.fromJson(v));
      });
    }
    _appointmentCount = json['appointmentCount'];
    _mentor =
        json['mentor'] != null ? MentorProfile.fromJson(json['mentor']) : null;
  }

  int? _id;
  dynamic _firstName;
  dynamic _lastName;
  dynamic _imagePath;
  String? _createdAt;
  int? _ratingsAvg;
  String? _registerDate;
  List<ScheduleTypes>? _scheduleTypes;
  List<ScheduleTypes>? _withoutScheduleTypes;
  int? _appointmentCount;
  MentorProfile? _mentor;

  int? get id => _id;

  dynamic get firstName => _firstName;

  dynamic get lastName => _lastName;

  dynamic get imagePath => _imagePath;

  String? get createdAt => _createdAt;

  int? get ratingsAvg => _ratingsAvg;

  String? get registerDate => _registerDate;

  List<ScheduleTypes>? get scheduleTypes => _scheduleTypes;

  List<ScheduleTypes>? get withoutScheduleTypes => _withoutScheduleTypes;

  int? get appointmentCount => _appointmentCount;

  MentorProfile? get mentor => _mentor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['image_path'] = _imagePath;
    map['created_at'] = _createdAt;
    map['ratingsAvg'] = _ratingsAvg;
    map['register_date'] = _registerDate;
    if (_scheduleTypes != null) {
      map['schedule_types'] = _scheduleTypes?.map((v) => v.toJson()).toList();
    }
    if (_withoutScheduleTypes != null) {
      map['without_schedule_types'] =
          _withoutScheduleTypes?.map((v) => v.toJson()).toList();
    }
    map['appointmentCount'] = _appointmentCount;
    if (_mentor != null) {
      map['mentor'] = _mentor?.toJson();
    }
    return map;
  }
}

class MentorProfile {
  MentorProfile({
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
    List<Categories>? categories,
    String? about,
    int? experience,
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
    _categories = categories;
    _about = about;
    _experience = experience;
  }

  MentorProfile.fromJson(dynamic json) {
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
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(Categories.fromJson(v));
      });
    }
    _about = json['about'];
    _experience = json['experience'];
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
  List<Categories>? _categories;
  String? _about;
  int? _experience;

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

  List<Categories>? get categories => _categories;

  String? get about => _about;

  int? get experience => _experience;

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
    if (_categories != null) {
      map['categories'] = _categories?.map((v) => v.toJson()).toList();
    }
    map['about'] = _about;
    map['experience'] = _experience;
    return map;
  }
}

class Categories {
  Categories({
    int? id,
    int? mentorId,
    int? categoryId,
    Category? category,
  }) {
    _id = id;
    _mentorId = mentorId;
    _categoryId = categoryId;
    _category = category;
  }

  Categories.fromJson(dynamic json) {
    _id = json['id'];
    _mentorId = json['mentor_id'];
    _categoryId = json['category_id'];
    _category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  int? _id;
  int? _mentorId;
  int? _categoryId;
  Category? _category;

  int? get id => _id;

  int? get mentorId => _mentorId;

  int? get categoryId => _categoryId;

  Category? get category => _category;

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

class Category {
  Category({
    int? id,
    int? parentId,
    String? name,
    String? slug,
    dynamic imagePath,
    dynamic description,
    dynamic createdAt,
    dynamic updatedAt,
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
  dynamic _imagePath;
  dynamic _description;
  dynamic _createdAt;
  dynamic _updatedAt;

  int? get id => _id;

  int? get parentId => _parentId;

  String? get name => _name;

  String? get slug => _slug;

  dynamic get imagePath => _imagePath;

  dynamic get description => _description;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

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

class ScheduleTypes {
  ScheduleTypes({
    int? appointmentTypeId,
    int? fee,
    AppointmentType? appointmentType,
  }) {
    _appointmentTypeId = appointmentTypeId;
    _fee = fee;
    _appointmentType = appointmentType;
  }

  ScheduleTypes.fromJson(dynamic json) {
    _appointmentTypeId = json['appointment_type_id'];
    _fee = json['fee'];
    _appointmentType = json['appointment_type'] != null
        ? AppointmentType.fromJson(json['appointment_type'])
        : null;
  }

  int? _appointmentTypeId;
  int? _fee;
  AppointmentType? _appointmentType;

  int? get appointmentTypeId => _appointmentTypeId;

  int? get fee => _fee;

  AppointmentType? get appointmentType => _appointmentType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appointment_type_id'] = _appointmentTypeId;
    map['fee'] = _fee;
    if (_appointmentType != null) {
      map['appointment_type'] = _appointmentType?.toJson();
    }
    return map;
  }
}

class AppointmentType {
  AppointmentType({
    int? id,
    String? name,
    int? isScheduleRequired,
  }) {
    _id = id;
    _name = name;
    _isScheduleRequired = isScheduleRequired;
  }

  AppointmentType.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _isScheduleRequired = json['is_schedule_required'];
  }

  int? _id;
  String? _name;
  int? _isScheduleRequired;

  int? get id => _id;

  String? get name => _name;

  int? get isScheduleRequired => _isScheduleRequired;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['is_schedule_required'] = _isScheduleRequired;
    return map;
  }
}
