class GetAppDetailForReschedule {
  GetAppDetailForReschedule({
    bool? status,
    num? success,
    RescheduleAppDetail? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  GetAppDetailForReschedule.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? RescheduleAppDetail.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  num? _success;
  RescheduleAppDetail? _data;
  String? _msg;
  GetAppDetailForReschedule copyWith({
    bool? status,
    num? success,
    RescheduleAppDetail? data,
    String? msg,
  }) =>
      GetAppDetailForReschedule(
        status: status ?? _status,
        success: success ?? _success,
        data: data ?? _data,
        msg: msg ?? _msg,
      );
  bool? get status => _status;
  num? get success => _success;
  RescheduleAppDetail? get data => _data;
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

class RescheduleAppDetail {
  Data({
    Appointment? appointment,
  }) {
    _appointment = appointment;
  }

  RescheduleAppDetail.fromJson(dynamic json) {
    _appointment = json['appointment'] != null
        ? Appointment.fromJson(json['appointment'])
        : null;
  }
  Appointment? _appointment;
  RescheduleAppDetail copyWith({
    Appointment? appointment,
  }) =>
      Data(
        appointment: appointment ?? _appointment,
      );
  Appointment? get appointment => _appointment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_appointment != null) {
      map['appointment'] = _appointment?.toJson();
    }
    return map;
  }
}

class Appointment {
  Appointment({
    num? id,
    num? menteeId,
    num? mentorId,
    String? date,
    String? time,
    num? payment,
    num? isPaid,
    dynamic paymentStatusCode,
    dynamic paymentResponseMsg,
    dynamic paymentOrderRef,
    num? paymentId,
    String? appointmentTypeString,
    num? appointmentTypeId,
    String? questions,
    String? file,
    String? fileType,
    dynamic notesConsultant,
    dynamic fileConsultant,
    dynamic filetypeConsultant,
    num? appointmentStatus,
    num? isArchieve,
    num? refund,
    String? createdAt,
    String? updatedAt,
    String? endTime,
    num? menteeVisibility,
    Mentor? mentor,
    Mentee? mentee,
    dynamic rating,
  }) {
    _id = id;
    _menteeId = menteeId;
    _mentorId = mentorId;
    _date = date;
    _time = time;
    _payment = payment;
    _isPaid = isPaid;
    _paymentStatusCode = paymentStatusCode;
    _paymentResponseMsg = paymentResponseMsg;
    _paymentOrderRef = paymentOrderRef;
    _paymentId = paymentId;
    _appointmentTypeString = appointmentTypeString;
    _appointmentTypeId = appointmentTypeId;
    _questions = questions;
    _file = file;
    _fileType = fileType;
    _notesConsultant = notesConsultant;
    _fileConsultant = fileConsultant;
    _filetypeConsultant = filetypeConsultant;
    _appointmentStatus = appointmentStatus;
    _isArchieve = isArchieve;
    _refund = refund;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _endTime = endTime;
    _menteeVisibility = menteeVisibility;
    _mentor = mentor;
    _mentee = mentee;
    _rating = rating;
  }

  Appointment.fromJson(dynamic json) {
    _id = json['id'];
    _menteeId = json['mentee_id'];
    _mentorId = json['mentor_id'];
    _date = json['date'];
    _time = json['time'];
    _payment = json['payment'];
    _isPaid = json['is_paid'];
    _paymentStatusCode = json['payment_status_code'];
    _paymentResponseMsg = json['payment_response_msg'];
    _paymentOrderRef = json['payment_order_ref'];
    _paymentId = json['payment_id'];
    _appointmentTypeString = json['appointment_type_string'];
    _appointmentTypeId = json['appointment_type_id'];
    _questions = json['questions'];
    _file = json['file'];
    _fileType = json['file_type'];
    _notesConsultant = json['notes_consultant'];
    _fileConsultant = json['file_consultant'];
    _filetypeConsultant = json['filetype_consultant'];
    _appointmentStatus = json['appointment_status'];
    _isArchieve = json['is_archieve'];
    _refund = json['refund'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _endTime = json['end_time'];
    _menteeVisibility = json['mentee_visibility'];
    _mentor = json['mentor'] != null ? Mentor.fromJson(json['mentor']) : null;
    _mentee = json['mentee'] != null ? Mentee.fromJson(json['mentee']) : null;
    _rating = json['rating'];
  }
  num? _id;
  num? _menteeId;
  num? _mentorId;
  String? _date;
  String? _time;
  num? _payment;
  num? _isPaid;
  dynamic _paymentStatusCode;
  dynamic _paymentResponseMsg;
  dynamic _paymentOrderRef;
  num? _paymentId;
  String? _appointmentTypeString;
  num? _appointmentTypeId;
  String? _questions;
  String? _file;
  String? _fileType;
  dynamic _notesConsultant;
  dynamic _fileConsultant;
  dynamic _filetypeConsultant;
  num? _appointmentStatus;
  num? _isArchieve;
  num? _refund;
  String? _createdAt;
  String? _updatedAt;
  String? _endTime;
  num? _menteeVisibility;
  Mentor? _mentor;
  Mentee? _mentee;
  dynamic _rating;
  Appointment copyWith({
    num? id,
    num? menteeId,
    num? mentorId,
    String? date,
    String? time,
    num? payment,
    num? isPaid,
    dynamic paymentStatusCode,
    dynamic paymentResponseMsg,
    dynamic paymentOrderRef,
    num? paymentId,
    String? appointmentTypeString,
    num? appointmentTypeId,
    String? questions,
    String? file,
    String? fileType,
    dynamic notesConsultant,
    dynamic fileConsultant,
    dynamic filetypeConsultant,
    num? appointmentStatus,
    num? isArchieve,
    num? refund,
    String? createdAt,
    String? updatedAt,
    String? endTime,
    num? menteeVisibility,
    Mentor? mentor,
    Mentee? mentee,
    dynamic rating,
  }) =>
      Appointment(
        id: id ?? _id,
        menteeId: menteeId ?? _menteeId,
        mentorId: mentorId ?? _mentorId,
        date: date ?? _date,
        time: time ?? _time,
        payment: payment ?? _payment,
        isPaid: isPaid ?? _isPaid,
        paymentStatusCode: paymentStatusCode ?? _paymentStatusCode,
        paymentResponseMsg: paymentResponseMsg ?? _paymentResponseMsg,
        paymentOrderRef: paymentOrderRef ?? _paymentOrderRef,
        paymentId: paymentId ?? _paymentId,
        appointmentTypeString: appointmentTypeString ?? _appointmentTypeString,
        appointmentTypeId: appointmentTypeId ?? _appointmentTypeId,
        questions: questions ?? _questions,
        file: file ?? _file,
        fileType: fileType ?? _fileType,
        notesConsultant: notesConsultant ?? _notesConsultant,
        fileConsultant: fileConsultant ?? _fileConsultant,
        filetypeConsultant: filetypeConsultant ?? _filetypeConsultant,
        appointmentStatus: appointmentStatus ?? _appointmentStatus,
        isArchieve: isArchieve ?? _isArchieve,
        refund: refund ?? _refund,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        endTime: endTime ?? _endTime,
        menteeVisibility: menteeVisibility ?? _menteeVisibility,
        mentor: mentor ?? _mentor,
        mentee: mentee ?? _mentee,
        rating: rating ?? _rating,
      );
  num? get id => _id;
  num? get menteeId => _menteeId;
  num? get mentorId => _mentorId;
  String? get date => _date;
  String? get time => _time;
  num? get payment => _payment;
  num? get isPaid => _isPaid;
  dynamic get paymentStatusCode => _paymentStatusCode;
  dynamic get paymentResponseMsg => _paymentResponseMsg;
  dynamic get paymentOrderRef => _paymentOrderRef;
  num? get paymentId => _paymentId;
  String? get appointmentTypeString => _appointmentTypeString;
  num? get appointmentTypeId => _appointmentTypeId;
  String? get questions => _questions;
  String? get file => _file;
  String? get fileType => _fileType;
  dynamic get notesConsultant => _notesConsultant;
  dynamic get fileConsultant => _fileConsultant;
  dynamic get filetypeConsultant => _filetypeConsultant;
  num? get appointmentStatus => _appointmentStatus;
  num? get isArchieve => _isArchieve;
  num? get refund => _refund;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get endTime => _endTime;
  num? get menteeVisibility => _menteeVisibility;
  Mentor? get mentor => _mentor;
  Mentee? get mentee => _mentee;
  dynamic get rating => _rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['mentee_id'] = _menteeId;
    map['mentor_id'] = _mentorId;
    map['date'] = _date;
    map['time'] = _time;
    map['payment'] = _payment;
    map['is_paid'] = _isPaid;
    map['payment_status_code'] = _paymentStatusCode;
    map['payment_response_msg'] = _paymentResponseMsg;
    map['payment_order_ref'] = _paymentOrderRef;
    map['payment_id'] = _paymentId;
    map['appointment_type_string'] = _appointmentTypeString;
    map['appointment_type_id'] = _appointmentTypeId;
    map['questions'] = _questions;
    map['file'] = _file;
    map['file_type'] = _fileType;
    map['notes_consultant'] = _notesConsultant;
    map['file_consultant'] = _fileConsultant;
    map['filetype_consultant'] = _filetypeConsultant;
    map['appointment_status'] = _appointmentStatus;
    map['is_archieve'] = _isArchieve;
    map['refund'] = _refund;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['end_time'] = _endTime;
    map['mentee_visibility'] = _menteeVisibility;
    if (_mentor != null) {
      map['mentor'] = _mentor?.toJson();
    }
    if (_mentee != null) {
      map['mentee'] = _mentee?.toJson();
    }
    map['rating'] = _rating;
    return map;
  }
}

class Mentee {
  Mentee({
    num? id,
    String? firstName,
    String? lastName,
    String? email,
    dynamic phone,
    dynamic imagePath,
    dynamic country,
    dynamic city,
    dynamic address,
    dynamic postalCode,
    dynamic isOtpVerified,
    dynamic fatherName,
    dynamic cnic,
    String? gender,
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
    _about = json['about'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  dynamic _phone;
  dynamic _imagePath;
  dynamic _country;
  dynamic _city;
  dynamic _address;
  dynamic _postalCode;
  dynamic _isOtpVerified;
  dynamic _fatherName;
  dynamic _cnic;
  String? _gender;
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
  Mentee copyWith({
    num? id,
    String? firstName,
    String? lastName,
    String? email,
    dynamic phone,
    dynamic imagePath,
    dynamic country,
    dynamic city,
    dynamic address,
    dynamic postalCode,
    dynamic isOtpVerified,
    dynamic fatherName,
    dynamic cnic,
    String? gender,
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
      Mentee(
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
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  dynamic get phone => _phone;
  dynamic get imagePath => _imagePath;
  dynamic get country => _country;
  dynamic get city => _city;
  dynamic get address => _address;
  dynamic get postalCode => _postalCode;
  dynamic get isOtpVerified => _isOtpVerified;
  dynamic get fatherName => _fatherName;
  dynamic get cnic => _cnic;
  String? get gender => _gender;
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

class Mentor {
  Mentor({
    num? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? imagePath,
    num? country,
    String? city,
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
    Category? category,
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
    _category = category;
  }

  Mentor.fromJson(dynamic json) {
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
    _category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }
  num? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  String? _imagePath;
  num? _country;
  String? _city;
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
  Category? _category;
  Mentor copyWith({
    num? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? imagePath,
    num? country,
    String? city,
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
    Category? category,
  }) =>
      Mentor(
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
        category: category ?? _category,
      );
  num? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get phone => _phone;
  String? get imagePath => _imagePath;
  num? get country => _country;
  String? get city => _city;
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
  Category? get category => _category;

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
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    return map;
  }
}

class Category {
  Category({
    num? id,
    num? parentId,
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
  num? _id;
  num? _parentId;
  String? _name;
  String? _slug;
  dynamic _imagePath;
  dynamic _description;
  dynamic _createdAt;
  dynamic _updatedAt;
  Category copyWith({
    num? id,
    num? parentId,
    String? name,
    String? slug,
    dynamic imagePath,
    dynamic description,
    dynamic createdAt,
    dynamic updatedAt,
  }) =>
      Category(
        id: id ?? _id,
        parentId: parentId ?? _parentId,
        name: name ?? _name,
        slug: slug ?? _slug,
        imagePath: imagePath ?? _imagePath,
        description: description ?? _description,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  num? get parentId => _parentId;
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
