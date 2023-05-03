class GetAppointmentCountMentorModel {
  GetAppointmentCountMentorModel({
    bool? status,
    int? success,
    GetAppointmentCountMentorModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  GetAppointmentCountMentorModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? GetAppointmentCountMentorModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  GetAppointmentCountMentorModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  GetAppointmentCountMentorModelData? get data => _data;
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

class GetAppointmentCountMentorModelData {
  GetAppointmentCountMentorModelData({
    int? allAppointmentsCount,
    int? cancelAppointments,
  }) {
    _allAppointmentsCount = allAppointmentsCount;
    _cancelAppointments = cancelAppointments;
  }

  GetAppointmentCountMentorModelData.fromJson(dynamic json) {
    _allAppointmentsCount = json['allAppointmentsCount'];
    _cancelAppointments = json['cancelAppointments'];
  }
  int? _allAppointmentsCount;
  int? _cancelAppointments;

  int? get allAppointmentsCount => _allAppointmentsCount;
  int? get cancelAppointments => _cancelAppointments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['allAppointmentsCount'] = _allAppointmentsCount;
    map['cancelAppointments'] = _cancelAppointments;
    return map;
  }
}
