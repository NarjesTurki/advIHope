class ExperienceInfoPostModel {
  ExperienceInfoPostModel({
    bool? status,
    int? success,
    ExperienceInfoPostModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  ExperienceInfoPostModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? ExperienceInfoPostModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  ExperienceInfoPostModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  ExperienceInfoPostModelData? get data => _data;
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

class ExperienceInfoPostModelData {
  ExperienceInfoPostModelData({
    Experience? experience,
  }) {
    _experience = experience;
  }

  ExperienceInfoPostModelData.fromJson(dynamic json) {
    _experience = json['experience'] != null
        ? Experience.fromJson(json['experience'])
        : null;
  }
  Experience? _experience;

  Experience? get experience => _experience;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_experience != null) {
      map['experience'] = _experience?.toJson();
    }
    return map;
  }
}

class Experience {
  Experience({
    String? mentorId,
    String? company,
    String? from,
    String? to,
    String? imagePath,
    String? updatedAt,
    String? createdAt,
    int? id,
  }) {
    _mentorId = mentorId;
    _company = company;
    _from = from;
    _to = to;
    _imagePath = imagePath;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  Experience.fromJson(dynamic json) {
    _mentorId = json['mentor_id'].toString();
    _company = json['company'];
    _from = json['from'];
    _to = json['to'];
    _imagePath = json['image_path'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  String? _mentorId;
  String? _company;
  String? _from;
  String? _to;
  String? _imagePath;
  String? _updatedAt;
  String? _createdAt;
  int? _id;

  String? get mentorId => _mentorId;
  String? get company => _company;
  String? get from => _from;
  String? get to => _to;
  String? get imagePath => _imagePath;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mentor_id'] = _mentorId;
    map['company'] = _company;
    map['from'] = _from;
    map['to'] = _to;
    map['image_path'] = _imagePath;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }
}
