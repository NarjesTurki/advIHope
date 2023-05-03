class GetAppointmentTypesModel {
  GetAppointmentTypesModel({
    bool? status,
    int? success,
    GetAppointmentTypesModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  GetAppointmentTypesModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? GetAppointmentTypesModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  GetAppointmentTypesModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  GetAppointmentTypesModelData? get data => _data;
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

class GetAppointmentTypesModelData {
  GetAppointmentTypesModelData({
    List<Appointmenttype>? appointmenttype,
  }) {
    _appointmenttype = appointmenttype;
  }

  GetAppointmentTypesModelData.fromJson(dynamic json) {
    if (json['appointmenttype'] != null) {
      _appointmenttype = [];
      json['appointmenttype'].forEach((v) {
        _appointmenttype?.add(Appointmenttype.fromJson(v));
      });
    }
  }
  List<Appointmenttype>? _appointmenttype;

  List<Appointmenttype>? get appointmenttype => _appointmenttype;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_appointmenttype != null) {
      map['appointmenttype'] =
          _appointmenttype?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Appointmenttype {
  Appointmenttype({
    int? id,
    String? name,
    int? isScheduleRequired,
  }) {
    _id = id;
    _name = name;
    _isScheduleRequired = isScheduleRequired;
  }

  Appointmenttype.fromJson(dynamic json) {
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
