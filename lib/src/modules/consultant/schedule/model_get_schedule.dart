class GetMentorScheduleModel {
  GetMentorScheduleModel({
    bool? status,
    int? success,
    GetMentorScheduleModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  GetMentorScheduleModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? GetMentorScheduleModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  GetMentorScheduleModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  GetMentorScheduleModelData? get data => _data;
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

class GetMentorScheduleModelData {
  GetMentorScheduleModelData({
    List<MentorSchedulesFullModel>? mentorSchedules,
    List<MentorWithoutScheduleFullModel>? mentorWithoutSchedule,
  }) {
    _mentorSchedules = mentorSchedules;
    _mentorWithoutSchedule = mentorWithoutSchedule;
  }

  GetMentorScheduleModelData.fromJson(dynamic json) {
    if (json['mentorSchedules'] != null) {
      _mentorSchedules = [];
      json['mentorSchedules'].forEach((v) {
        _mentorSchedules?.add(MentorSchedulesFullModel.fromJson(v));
      });
    }
    if (json['mentorWithoutSchedule'] != null) {
      _mentorWithoutSchedule = [];
      json['mentorWithoutSchedule'].forEach((v) {
        _mentorWithoutSchedule?.add(MentorWithoutScheduleFullModel.fromJson(v));
      });
    }
  }
  List<MentorSchedulesFullModel>? _mentorSchedules;
  List<MentorWithoutScheduleFullModel>? _mentorWithoutSchedule;

  List<MentorSchedulesFullModel>? get mentorSchedules => _mentorSchedules;
  List<MentorWithoutScheduleFullModel>? get mentorWithoutSchedule =>
      _mentorWithoutSchedule;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_mentorSchedules != null) {
      map['mentorSchedules'] =
          _mentorSchedules?.map((v) => v.toJson()).toList();
    }
    if (_mentorWithoutSchedule != null) {
      map['mentorWithoutSchedule'] =
          _mentorWithoutSchedule?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class MentorSchedulesFullModel {
  MentorSchedulesFullModel({
    int? id,
    int? mentorId,
    int? appointmentTypeId,
    int? fee,
    String? day,
    int? isHoliday,
    int? isActive,
    String? createdAt,
    String? updatedAt,
    List<ScheduleSlots>? scheduleSlots,
  }) {
    _id = id;
    _mentorId = mentorId;
    _appointmentTypeId = appointmentTypeId;
    _fee = fee;
    _day = day;
    _isHoliday = isHoliday;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _scheduleSlots = scheduleSlots;
  }

  MentorSchedulesFullModel.fromJson(dynamic json) {
    _id = json['id'];
    _mentorId = json['mentor_id'];
    _appointmentTypeId = json['appointment_type_id'];
    _fee = json['fee'];
    _day = json['day'];
    _isHoliday = json['is_holiday'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['schedule_slots'] != null) {
      _scheduleSlots = [];
      json['schedule_slots'].forEach((v) {
        _scheduleSlots?.add(ScheduleSlots.fromJson(v));
      });
    }
  }
  int? _id;
  int? _mentorId;
  int? _appointmentTypeId;
  int? _fee;
  String? _day;
  int? _isHoliday;
  int? _isActive;
  String? _createdAt;
  String? _updatedAt;
  List<ScheduleSlots>? _scheduleSlots;

  int? get id => _id;
  int? get mentorId => _mentorId;
  int? get appointmentTypeId => _appointmentTypeId;
  int? get fee => _fee;
  String? get day => _day;
  int? get isHoliday => _isHoliday;
  int? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<ScheduleSlots>? get scheduleSlots => _scheduleSlots;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['mentor_id'] = _mentorId;
    map['appointment_type_id'] = _appointmentTypeId;
    map['fee'] = _fee;
    map['day'] = _day;
    map['is_holiday'] = _isHoliday;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_scheduleSlots != null) {
      map['schedule_slots'] = _scheduleSlots?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ScheduleSlots {
  ScheduleSlots({
    int? id,
    int? scheduleId,
    String? startTime,
    String? endTime,
    String? slotDuration,
    int? isActive,
    int? shiftId,
  }) {
    _id = id;
    _scheduleId = scheduleId;
    _startTime = startTime;
    _endTime = endTime;
    _slotDuration = slotDuration;
    _isActive = isActive;
    _shiftId = shiftId;
  }

  ScheduleSlots.fromJson(dynamic json) {
    _id = json['id'];
    _scheduleId = json['schedule_id'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _slotDuration = json['slot_duration'];
    _isActive = json['is_active'];
    _shiftId = json['shift_id'];
  }
  int? _id;
  int? _scheduleId;
  String? _startTime;
  String? _endTime;
  String? _slotDuration;
  int? _isActive;
  int? _shiftId;

  int? get id => _id;
  int? get scheduleId => _scheduleId;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get slotDuration => _slotDuration;
  int? get isActive => _isActive;
  int? get shiftId => _shiftId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['schedule_id'] = _scheduleId;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['slot_duration'] = _slotDuration;
    map['is_active'] = _isActive;
    map['shift_id'] = _shiftId;
    return map;
  }
}

class MentorWithoutScheduleFullModel {
  MentorWithoutScheduleFullModel({
    int? id,
    int? mentorId,
    int? appointmentTypeId,
    int? fee,
    String? day,
    int? isHoliday,
    int? isActive,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _mentorId = mentorId;
    _appointmentTypeId = appointmentTypeId;
    _fee = fee;
    _day = day;
    _isHoliday = isHoliday;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  MentorWithoutScheduleFullModel.fromJson(dynamic json) {
    _id = json['id'];
    _mentorId = json['mentor_id'];
    _appointmentTypeId = json['appointment_type_id'];
    _fee = json['fee'];
    _day = json['day'];
    _isHoliday = json['is_holiday'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _mentorId;
  int? _appointmentTypeId;
  int? _fee;
  String? _day;
  int? _isHoliday;
  int? _isActive;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get mentorId => _mentorId;
  int? get appointmentTypeId => _appointmentTypeId;
  int? get fee => _fee;
  String? get day => _day;
  int? get isHoliday => _isHoliday;
  int? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['mentor_id'] = _mentorId;
    map['appointment_type_id'] = _appointmentTypeId;
    map['fee'] = _fee;
    map['day'] = _day;
    map['is_holiday'] = _isHoliday;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
