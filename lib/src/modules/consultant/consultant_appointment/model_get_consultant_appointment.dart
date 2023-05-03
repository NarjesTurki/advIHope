class GetConsultantAppointmentModel {
  GetConsultantAppointmentModel({
    bool? status,
    int? success,
    GetConsultantAppointmentModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  GetConsultantAppointmentModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? GetConsultantAppointmentModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  GetConsultantAppointmentModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  GetConsultantAppointmentModelData? get data => _data;
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

class GetConsultantAppointmentModelData {
  GetConsultantAppointmentModelData({
    AppointmentsPageData? pendingAppointments,
    AppointmentsPageData? acceptedAppointments,
    AppointmentsPageData? completedAppointments,
    AppointmentsPageData? cancelledAppointments,
    AppointmentsPageData? archivedAppointments,
  }) {
    _pendingAppointments = pendingAppointments;
    _acceptedAppointments = acceptedAppointments;
    _completedAppointments = completedAppointments;
    _cancelledAppointments = cancelledAppointments;
    _archivedAppointments = archivedAppointments;
  }

  GetConsultantAppointmentModelData.fromJson(dynamic json) {
    _pendingAppointments = json['pendingAppointments'] != null
        ? AppointmentsPageData.fromJson(json['pendingAppointments'])
        : null;
    _acceptedAppointments = json['acceptedAppointments'] != null
        ? AppointmentsPageData.fromJson(json['acceptedAppointments'])
        : null;
    _completedAppointments = json['completedAppointments'] != null
        ? AppointmentsPageData.fromJson(json['completedAppointments'])
        : null;
    _cancelledAppointments = json['cancelledAppointments'] != null
        ? AppointmentsPageData.fromJson(json['cancelledAppointments'])
        : null;
    _archivedAppointments = json['archivedAppointments'] != null
        ? AppointmentsPageData.fromJson(json['archivedAppointments'])
        : null;
  }
  AppointmentsPageData? _pendingAppointments;
  AppointmentsPageData? _acceptedAppointments;
  AppointmentsPageData? _completedAppointments;
  AppointmentsPageData? _cancelledAppointments;
  AppointmentsPageData? _archivedAppointments;

  AppointmentsPageData? get pendingAppointments => _pendingAppointments;
  AppointmentsPageData? get acceptedAppointments => _acceptedAppointments;
  AppointmentsPageData? get completedAppointments => _completedAppointments;
  AppointmentsPageData? get cancelledAppointments => _cancelledAppointments;
  AppointmentsPageData? get archivedAppointments => _archivedAppointments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_pendingAppointments != null) {
      map['pendingAppointments'] = _pendingAppointments?.toJson();
    }
    if (_acceptedAppointments != null) {
      map['acceptedAppointments'] = _acceptedAppointments?.toJson();
    }
    if (_completedAppointments != null) {
      map['completedAppointments'] = _completedAppointments?.toJson();
    }
    if (_cancelledAppointments != null) {
      map['cancelledAppointments'] = _cancelledAppointments?.toJson();
    }
    if (_archivedAppointments != null) {
      map['archiveAppointments'] = _archivedAppointments?.toJson();
    }
    return map;
  }
}

class AppointmentsPageData {
  AppointmentsPageData({
    int? currentPage,
    List<ConsultantAppointmentsData>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Links>? links,
    String? nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  });

  AppointmentsPageData.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ConsultantAppointmentsData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links?.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
  int? currentPage;
  List<ConsultantAppointmentsData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = firstPageUrl;
    map['from'] = from;
    map['last_page'] = lastPage;
    map['last_page_url'] = lastPageUrl;
    if (links != null) {
      map['links'] = links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = nextPageUrl;
    map['path'] = path;
    map['per_page'] = perPage;
    map['prev_page_url'] = prevPageUrl;
    map['to'] = to;
    map['total'] = total;
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

class ConsultantAppointmentsData {
  ConsultantAppointmentsData({
    int? id,
    int? menteeId,
    int? mentorId,
    String? date,
    String? time,
    int? payment,
    int? isPaid,
    int? is_archieve,
    dynamic paymentStatusCode,
    dynamic paymentResponseMsg,
    dynamic paymentOrderRef,
    int? paymentId,
    String? appointmentTypeString,
    int? appointmentTypeId,
    String? questions,
    String? file,
    String? fileType,
    int? appointmentStatus,
    int? refund,
    String? createdAt,
    String? updatedAt,
    int? rating,
    String? category,
    String? endTime,
    Mentee? mentee,
    String? notesConsultant,
    String? fileConsultant,
    String? filetypeConsultant,
  }) {
    _id = id;
    _menteeId = menteeId;
    _mentorId = mentorId;
    _date = date;
    _time = time;
    _payment = payment;
    _isPaid = isPaid;
    _is_archieve = is_archieve;
    _paymentStatusCode = paymentStatusCode;
    _paymentResponseMsg = paymentResponseMsg;
    _paymentOrderRef = paymentOrderRef;
    _paymentId = paymentId;
    _appointmentTypeString = appointmentTypeString;
    _appointmentTypeId = appointmentTypeId;
    _questions = questions;
    _file = file;
    _fileType = fileType;
    _appointmentStatus = appointmentStatus;
    _refund = refund;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _rating = rating;
    _category = category;
    _endTime = endTime;
    _mentee = mentee;
    _notesConsultant = notesConsultant;
    _fileConsultant = fileConsultant;
    _filetypeConsultant = filetypeConsultant;
  }

  ConsultantAppointmentsData.fromJson(dynamic json) {
    _id = json['id'];
    _menteeId = json['mentee_id'];
    _mentorId = json['mentor_id'];
    _date = json['date'];
    _time = json['time'];
    _payment = json['payment'];
    _isPaid = json['is_paid'];
    _is_archieve = json['is_archieve'];
    _paymentStatusCode = json['payment_status_code'];
    _paymentResponseMsg = json['payment_response_msg'];
    _paymentOrderRef = json['payment_order_ref'];
    _paymentId = json['payment_id'];
    _appointmentTypeString = json['appointment_type_string'];
    _appointmentTypeId = json['appointment_type_id'];
    _questions = json['questions'];
    _file = json['file'];
    _fileType = json['file_type'];
    _appointmentStatus = json['appointment_status'];
    _refund = json['refund'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _rating = json['rating'];
    _category = json['category'];
    _endTime = json['end_time'];
    _mentee = json['mentee'] != null ? Mentee.fromJson(json['mentee']) : null;
    _notesConsultant = json['notes_consultant'];
    _fileConsultant = json['file_consultant'];
    _filetypeConsultant = json['filetype_consultant'];
  }
  int? _id;
  int? _menteeId;
  int? _mentorId;
  String? _date;
  String? _time;
  int? _payment;
  int? _isPaid;
  int? _is_archieve;
  dynamic _paymentStatusCode;
  dynamic _paymentResponseMsg;
  dynamic _paymentOrderRef;
  int? _paymentId;
  String? _appointmentTypeString;
  int? _appointmentTypeId;
  String? _questions;
  String? _file;
  String? _fileType;
  int? _appointmentStatus;
  int? _refund;
  String? _createdAt;
  String? _updatedAt;
  int? _rating;
  String? _category;
  String? _endTime;
  Mentee? _mentee;
  String? _notesConsultant;
  String? _fileConsultant;
  String? _filetypeConsultant;

  int? get id => _id;
  int? get menteeId => _menteeId;
  int? get mentorId => _mentorId;
  String? get date => _date;
  String? get time => _time;
  int? get payment => _payment;
  int? get isPaid => _isPaid;
  int? get is_archieve => _is_archieve;
  dynamic get paymentStatusCode => _paymentStatusCode;
  dynamic get paymentResponseMsg => _paymentResponseMsg;
  dynamic get paymentOrderRef => _paymentOrderRef;
  int? get paymentId => _paymentId;
  String? get appointmentTypeString => _appointmentTypeString;
  int? get appointmentTypeId => _appointmentTypeId;
  String? get questions => _questions;
  String? get file => _file;
  String? get fileType => _fileType;
  int? get appointmentStatus => _appointmentStatus;
  int? get refund => _refund;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get rating => _rating;
  String? get category => _category;
  String? get endTime => _endTime;
  Mentee? get mentee => _mentee;
  String? get notesConsultant => _notesConsultant;
  String? get fileConsultant => _fileConsultant;
  String? get filetypeConsultant => _filetypeConsultant;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['mentee_id'] = _menteeId;
    map['mentor_id'] = _mentorId;
    map['date'] = _date;
    map['time'] = _time;
    map['payment'] = _payment;
    map['is_paid'] = _isPaid;
    map['is_archieve'] = _is_archieve;
    map['payment_status_code'] = _paymentStatusCode;
    map['payment_response_msg'] = _paymentResponseMsg;
    map['payment_order_ref'] = _paymentOrderRef;
    map['payment_id'] = _paymentId;
    map['appointment_type_string'] = _appointmentTypeString;
    map['appointment_type_id'] = _appointmentTypeId;
    map['questions'] = _questions;
    map['file'] = _file;
    map['file_type'] = _fileType;
    map['appointment_status'] = _appointmentStatus;
    map['refund'] = _refund;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['rating'] = _rating;
    map['category'] = _category;
    map['end_time'] = endTime;
    map['notes_consultant'] = _notesConsultant;
    map['file_consultant'] = _fileConsultant;
    map['filetype_consultant'] = _filetypeConsultant;
    if (_mentee != null) {
      map['mentee'] = _mentee?.toJson();
    }
    return map;
  }
}

class Mentee {
  Mentee({
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
    int? adminUser,
    dynamic fbId,
    dynamic googleId,
    String? createdAt,
    String? updatedAt,
    MenteeInfo? mentee,
    UserCountry? userCountry,
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
    _mentee = mentee;
    _userCountry = userCountry;
  }

  Mentee.fromJson(dynamic json) {
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
    _mentee =
        json['mentee'] != null ? MenteeInfo.fromJson(json['mentee']) : null;
    _userCountry = json['user_country'] != null
        ? UserCountry.fromJson(json['user_country'])
        : null;
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
  int? _adminUser;
  dynamic _fbId;
  dynamic _googleId;
  String? _createdAt;
  String? _updatedAt;
  MenteeInfo? _mentee;
  UserCountry? _userCountry;

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
  int? get adminUser => _adminUser;
  dynamic get fbId => _fbId;
  dynamic get googleId => _googleId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  MenteeInfo? get mentee => _mentee;
  UserCountry? get userCountry => _userCountry;

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

    if (_mentee != null) {
      map['mentee'] = _mentee?.toJson();
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

class MenteeInfo {
  MenteeInfo({
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

  MenteeInfo.fromJson(dynamic json) {
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
