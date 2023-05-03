class GetAvailableDaysModel {
  GetAvailableDaysModel({
    bool? status,
    int? success,
    GetAvailableDaysModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  GetAvailableDaysModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? GetAvailableDaysModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  GetAvailableDaysModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  GetAvailableDaysModelData? get data => _data;
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

class GetAvailableDaysModelData {
  GetAvailableDaysModelData({
    List<MentorScheduleDays>? mentorSchedules,
  }) {
    _mentorSchedules = mentorSchedules;
  }

  GetAvailableDaysModelData.fromJson(dynamic json) {
    if (json['mentorSchedules'] != null) {
      _mentorSchedules = [];
      json['mentorSchedules'].forEach((v) {
        _mentorSchedules?.add(MentorScheduleDays.fromJson(v));
      });
    }
  }
  List<MentorScheduleDays>? _mentorSchedules;

  List<MentorScheduleDays>? get mentorSchedules => _mentorSchedules;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_mentorSchedules != null) {
      map['mentorSchedules'] =
          _mentorSchedules?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class MentorScheduleDays {
  MentorScheduleDays({
    String? day,
    int? isHoliday,
  }) {
    _day = day;
    _isHoliday = isHoliday;
  }

  MentorScheduleDays.fromJson(dynamic json) {
    _day = json['day'];
    _isHoliday = json['is_holiday'];
  }
  String? _day;
  int? _isHoliday;

  String? get day => _day;
  int? get isHoliday => _isHoliday;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = _day;
    map['is_holiday'] = _isHoliday;
    return map;
  }
}
