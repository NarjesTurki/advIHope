import '../consultant/create_profile/models/model_post_education_info.dart';
import '../consultant/create_profile/models/model_post_experience_info.dart';

class GetConsultantProfileModel {
  GetConsultantProfileModel({
    bool? status,
    int? success,
    GetConsultantProfileModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  GetConsultantProfileModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? GetConsultantProfileModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  GetConsultantProfileModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  GetConsultantProfileModelData? get data => _data;
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

class GetConsultantProfileModelData {
  GetConsultantProfileModelData({
    ConsultantDetailFromGetProfile? userDetail,
  }) {
    _userDetail = userDetail;
  }

  GetConsultantProfileModelData.fromJson(dynamic json) {
    _userDetail = json['userDetail'] != null
        ? ConsultantDetailFromGetProfile.fromJson(json['userDetail'])
        : null;
  }
  ConsultantDetailFromGetProfile? _userDetail;

  ConsultantDetailFromGetProfile? get userDetail => _userDetail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_userDetail != null) {
      map['userDetail'] = _userDetail?.toJson();
    }
    return map;
  }
}

class ConsultantDetailFromGetProfile {
  ConsultantDetailFromGetProfile({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? about,
    String? imagePath,
    String? createdAt,
    int? country,
    String? fatherName,
    String? cnic,
    String? gender,
    String? dob,
    String? city,
    String? address,
    int? occupation,
    String? religion,
    String? onlineStatus,
    int? ratingsAvg,
    String? registerDate,
    List<ScheduleTypes>? scheduleTypes,
    List<ScheduleTypes>? withoutScheduleTypes,
    int? appointmentCount,
    Mentor? mentor,
    UserCountry? userCountry,
    List<Education>? educations,
    List<Experience>? experiences,
    CardDetail? cardDetail,
  }) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _about = about;
    _imagePath = imagePath;
    _createdAt = createdAt;
    _country = country;
    _fatherName = fatherName;
    _cnic = cnic;
    _gender = gender;
    _dob = dob;
    _city = city;
    _address = address;
    _occupation = occupation;
    _religion = religion;
    _onlineStatus = onlineStatus;
    _ratingsAvg = ratingsAvg;
    _registerDate = registerDate;
    _scheduleTypes = scheduleTypes;
    _withoutScheduleTypes = withoutScheduleTypes;
    _appointmentCount = appointmentCount;
    _mentor = mentor;
    _userCountry = userCountry;
    _educations = educations;
    _experiences = experiences;
    _cardDetail = cardDetail;
  }

  ConsultantDetailFromGetProfile.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _about = json['about'];
    _imagePath = json['image_path'];
    _createdAt = json['created_at'];
    _country = json['country'];
    _fatherName = json['father_name'];
    _cnic = json['cnic'];
    _gender = json['gender'];
    _dob = json['dob'];
    _city = json['city'];
    _address = json['address'];
    _occupation = json['occupation'];
    _religion = json['religion'];
    _onlineStatus = json['online_status'];
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
    _mentor = json['mentor'] != null ? Mentor.fromJson(json['mentor']) : null;
    _userCountry = json['user_country'] != null
        ? UserCountry.fromJson(json['user_country'])
        : null;
    if (json['educations'] != null) {
      _educations = [];
      json['educations'].forEach((v) {
        _educations?.add(Education.fromJson(v));
      });
    }
    if (json['experiences'] != null) {
      _experiences = [];
      json['experiences'].forEach((v) {
        _experiences?.add(Experience.fromJson(v));
      });
    }
    _cardDetail = json['card_detail'] != null
        ? CardDetail.fromJson(json['card_detail'])
        : null;
  }
  int? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _about;
  String? _imagePath;
  String? _createdAt;
  int? _country;
  String? _fatherName;
  String? _cnic;
  String? _gender;
  String? _dob;
  String? _city;
  String? _address;
  int? _occupation;
  String? _religion;
  String? _onlineStatus;
  int? _ratingsAvg;
  String? _registerDate;
  List<ScheduleTypes>? _scheduleTypes;
  List<ScheduleTypes>? _withoutScheduleTypes;
  int? _appointmentCount;
  Mentor? _mentor;
  UserCountry? _userCountry;
  List<Education>? _educations;
  List<Experience>? _experiences;
  CardDetail? _cardDetail;

  int? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get about => _about;
  String? get imagePath => _imagePath;
  String? get createdAt => _createdAt;
  int? get country => _country;
  String? get fatherName => _fatherName;
  String? get cnic => _cnic;
  String? get gender => _gender;
  String? get dob => _dob;
  String? get city => _city;
  String? get address => _address;
  int? get occupation => _occupation;
  String? get religion => _religion;
  String? get onlineStatus => _onlineStatus;
  int? get ratingsAvg => _ratingsAvg;
  String? get registerDate => _registerDate;
  List<ScheduleTypes>? get scheduleTypes => _scheduleTypes;
  List<ScheduleTypes>? get withoutScheduleTypes => _withoutScheduleTypes;
  int? get appointmentCount => _appointmentCount;
  Mentor? get mentor => _mentor;
  UserCountry? get userCountry => _userCountry;
  List<Education>? get educations => _educations;
  List<Experience>? get experiences => _experiences;
  CardDetail? get cardDetail => _cardDetail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['about'] = _about;
    map['image_path'] = _imagePath;
    map['created_at'] = _createdAt;
    map['country'] = _country;
    map['father_name'] = _fatherName;
    map['cnic'] = _cnic;
    map['gender'] = _gender;
    map['dob'] = _dob;
    map['city'] = _city;
    map['address'] = _address;
    map['occupation'] = _occupation;
    map['religion'] = _religion;
    map['online_status'] = _onlineStatus;
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
    if (_userCountry != null) {
      map['user_country'] = _userCountry?.toJson();
    }
    if (_educations != null) {
      map['educations'] = _educations?.map((v) => v.toJson()).toList();
    }
    if (_experiences != null) {
      map['experiences'] = _experiences?.map((v) => v.toJson()).toList();
    }
    if (_cardDetail != null) {
      map['card_detail'] = _cardDetail?.toJson();
    }
    return map;
  }
}

class CardDetail {
  CardDetail({
    int? id,
    String? accountTitle,
    String? accountNumber,
    String? bank,
    int? mentorId,
  }) {
    _id = id;
    _accountTitle = accountTitle;
    _accountNumber = accountNumber;
    _bank = bank;
    _mentorId = mentorId;
  }

  CardDetail.fromJson(dynamic json) {
    _id = json['id'];
    _accountTitle = json['account_title'];
    _accountNumber = json['account_number'];
    _bank = json['bank'];
    _mentorId = json['mentor_id'];
  }
  int? _id;
  String? _accountTitle;
  String? _accountNumber;
  String? _bank;
  int? _mentorId;

  int? get id => _id;
  String? get accountTitle => _accountTitle;
  String? get accountNumber => _accountNumber;
  String? get bank => _bank;
  int? get mentorId => _mentorId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['account_title'] = _accountTitle;
    map['account_number'] = _accountNumber;
    map['bank'] = _bank;
    map['mentor_id'] = _mentorId;
    return map;
  }
}

class UserCountry {
  UserCountry({
    int? id,
    String? name,
    String? isoCode3,
    String? isoCode2,
    String? phoneCode,
    String? capital,
    String? currency,
    String? currencySymbol,
    String? tld,
    String? native,
    String? region,
    int? isActive,
    String? subregion,
    String? timezones,
    String? translations,
    String? latitude,
    String? longitude,
    String? emoji,
    String? emojiU,
    String? createdAt,
    String? updatedAt,
    int? flag,
    String? wikiDataId,
  }) {
    _id = id;
    _name = name;
    _isoCode3 = isoCode3;
    _isoCode2 = isoCode2;
    _phoneCode = phoneCode;
    _capital = capital;
    _currency = currency;
    _currencySymbol = currencySymbol;
    _tld = tld;
    _native = native;
    _region = region;
    _isActive = isActive;
    _subregion = subregion;
    _timezones = timezones;
    _translations = translations;
    _latitude = latitude;
    _longitude = longitude;
    _emoji = emoji;
    _emojiU = emojiU;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _flag = flag;
    _wikiDataId = wikiDataId;
  }

  UserCountry.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _isoCode3 = json['iso_code_3'];
    _isoCode2 = json['iso_code_2'];
    _phoneCode = json['phone_code'];
    _capital = json['capital'];
    _currency = json['currency'];
    _currencySymbol = json['currency_symbol'];
    _tld = json['tld'];
    _native = json['native'];
    _region = json['region'];
    _isActive = json['is_active'];
    _subregion = json['subregion'];
    _timezones = json['timezones'];
    _translations = json['translations'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _emoji = json['emoji'];
    _emojiU = json['emojiU'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _flag = json['flag'];
    _wikiDataId = json['wikiDataId'];
  }
  int? _id;
  String? _name;
  String? _isoCode3;
  String? _isoCode2;
  String? _phoneCode;
  String? _capital;
  String? _currency;
  String? _currencySymbol;
  String? _tld;
  String? _native;
  String? _region;
  int? _isActive;
  String? _subregion;
  String? _timezones;
  String? _translations;
  String? _latitude;
  String? _longitude;
  String? _emoji;
  String? _emojiU;
  String? _createdAt;
  String? _updatedAt;
  int? _flag;
  String? _wikiDataId;

  int? get id => _id;
  String? get name => _name;
  String? get isoCode3 => _isoCode3;
  String? get isoCode2 => _isoCode2;
  String? get phoneCode => _phoneCode;
  String? get capital => _capital;
  String? get currency => _currency;
  String? get currencySymbol => _currencySymbol;
  String? get tld => _tld;
  String? get native => _native;
  String? get region => _region;
  int? get isActive => _isActive;
  String? get subregion => _subregion;
  String? get timezones => _timezones;
  String? get translations => _translations;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get emoji => _emoji;
  String? get emojiU => _emojiU;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get flag => _flag;
  String? get wikiDataId => _wikiDataId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['iso_code_3'] = _isoCode3;
    map['iso_code_2'] = _isoCode2;
    map['phone_code'] = _phoneCode;
    map['capital'] = _capital;
    map['currency'] = _currency;
    map['currency_symbol'] = _currencySymbol;
    map['tld'] = _tld;
    map['native'] = _native;
    map['region'] = _region;
    map['is_active'] = _isActive;
    map['subregion'] = _subregion;
    map['timezones'] = _timezones;
    map['translations'] = _translations;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['emoji'] = _emoji;
    map['emojiU'] = _emojiU;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['flag'] = _flag;
    map['wikiDataId'] = _wikiDataId;
    return map;
  }
}

class Mentor {
  Mentor({
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

  Mentor.fromJson(dynamic json) {
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
