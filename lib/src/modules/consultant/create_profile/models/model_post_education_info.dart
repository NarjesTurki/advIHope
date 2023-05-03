class EducationInfoPostModel {
  EducationInfoPostModel({
    bool? status,
    int? success,
    EducationInfoPostModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  EducationInfoPostModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? EducationInfoPostModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  EducationInfoPostModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  EducationInfoPostModelData? get data => _data;
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

class EducationInfoPostModelData {
  EducationInfoPostModelData({
    Education? education,
  }) {
    _education = education;
  }

  EducationInfoPostModelData.fromJson(dynamic json) {
    _education = json['education'] != null
        ? Education.fromJson(json['education'])
        : null;
  }
  Education? _education;

  Education? get education => _education;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_education != null) {
      map['education'] = _education?.toJson();
    }
    return map;
  }
}

class Education {
  Education({
    String? mentorId,
    String? institute,
    String? degree,
    String? subject,
    String? period,
    String? imagePath,
    String? updatedAt,
    String? createdAt,
    int? id,
  }) {
    _mentorId = mentorId;
    _institute = institute;
    _degree = degree;
    _subject = subject;
    _period = period;
    _imagePath = imagePath;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  Education.fromJson(dynamic json) {
    _mentorId = json['mentor_id'].toString();
    _institute = json['institute'];
    _degree = json['degree'];
    _subject = json['subject'];
    _period = json['period'];
    _imagePath = json['image_path'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  String? _mentorId;
  String? _institute;
  String? _degree;
  String? _subject;
  String? _period;
  String? _imagePath;
  String? _updatedAt;
  String? _createdAt;
  int? _id;

  String? get mentorId => _mentorId;
  String? get institute => _institute;
  String? get degree => _degree;
  String? get subject => _subject;
  String? get period => _period;
  String? get imagePath => _imagePath;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mentor_id'] = _mentorId;
    map['institute'] = _institute;
    map['degree'] = _degree;
    map['subject'] = _subject;
    map['period'] = _period;
    map['image_path'] = _imagePath;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }
}
