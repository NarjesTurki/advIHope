class MentorApprovalCheckModel {
  MentorApprovalCheckModel({
    bool? status,
    int? success,
    MentorApprovalCheckModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  MentorApprovalCheckModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? MentorApprovalCheckModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  MentorApprovalCheckModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  MentorApprovalCheckModelData? get data => _data;
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

class MentorApprovalCheckModelData {
  MentorApprovalCheckModelData({
    String? accessToken,
    Mentor? mentor,
  }) {
    _accessToken = accessToken;
    _mentor = mentor;
  }

  MentorApprovalCheckModelData.fromJson(dynamic json) {
    _accessToken = json['AccessToken'];
    _mentor = json['mentor'] != null ? Mentor.fromJson(json['mentor']) : null;
  }
  String? _accessToken;
  Mentor? _mentor;

  String? get accessToken => _accessToken;
  Mentor? get mentor => _mentor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AccessToken'] = _accessToken;
    if (_mentor != null) {
      map['mentor'] = _mentor?.toJson();
    }
    return map;
  }
}

class Mentor {
  Mentor({
    int? status,
    int? isProfileCompleted,
  }) {
    _status = status;
    _isProfileCompleted = isProfileCompleted;
  }

  Mentor.fromJson(dynamic json) {
    _status = json['status'];
    _isProfileCompleted = json['is_profile_completed'];
  }
  int? _status;
  int? _isProfileCompleted;

  int? get status => _status;
  int? get isProfileCompleted => _isProfileCompleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['is_profile_completed'] = _isProfileCompleted;
    return map;
  }
}
