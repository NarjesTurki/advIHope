import 'package:ista_app/src/modules/user/my_appointment/model_get_user_appointment.dart';

class GetUserAppointmentModelMore {
  GetUserAppointmentModelMore({
    bool? status,
    int? success,
    GetUserAppointmentModelMoreData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  GetUserAppointmentModelMore.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? GetUserAppointmentModelMoreData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  GetUserAppointmentModelMoreData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  GetUserAppointmentModelMoreData? get data => _data;
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

class GetUserAppointmentModelMoreData {
  GetUserAppointmentModelMoreData({
    AppointmentsPageData? appointments,
  }) {
    _appointments = appointments;
  }

  GetUserAppointmentModelMoreData.fromJson(dynamic json) {
    _appointments = json['appointments'] != null
        ? AppointmentsPageData.fromJson(json['appointments'])
        : null;
  }
  AppointmentsPageData? _appointments;

  AppointmentsPageData? get appointments => _appointments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_appointments != null) {
      map['appointments'] = _appointments?.toJson();
    }
    return map;
  }
}
