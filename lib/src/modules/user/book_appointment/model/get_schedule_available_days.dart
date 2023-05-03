class GetScheduleAvailableDays {
  GetScheduleAvailableDays({
    bool? status,
    int? success,
    GetScheduleAvailableDaysData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  GetScheduleAvailableDays.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? GetScheduleAvailableDaysData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  GetScheduleAvailableDaysData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  GetScheduleAvailableDaysData? get data => _data;
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

class GetScheduleAvailableDaysData {
  GetScheduleAvailableDaysData({
    List<MentorSchedules>? mentorSchedules,
  }) {
    _mentorSchedules = mentorSchedules;
  }

  GetScheduleAvailableDaysData.fromJson(dynamic json) {
    if (json['mentorSchedules'] != null) {
      _mentorSchedules = [];
      json['mentorSchedules'].forEach((v) {
        _mentorSchedules?.add(MentorSchedules.fromJson(v));
      });
    }
  }
  List<MentorSchedules>? _mentorSchedules;

  List<MentorSchedules>? get mentorSchedules => _mentorSchedules;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_mentorSchedules != null) {
      map['mentorSchedules'] =
          _mentorSchedules?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class MentorSchedules {
  MentorSchedules({
    String? day,
    int? isHoliday,
  }) {
    _day = day;
    _isHoliday = isHoliday;
  }

  MentorSchedules.fromJson(dynamic json) {
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
