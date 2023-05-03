class BookAppointmentModel {
  BookAppointmentModel({
    bool? status,
    int? success,
    Data? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  BookAppointmentModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  Data? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  Data? get data => _data;
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

class Data {
  Data({
    int? appointmentNo,
  }) {
    _appointmentNo = appointmentNo;
  }

  Data.fromJson(dynamic json) {
    _appointmentNo = json['appointmentNo'];
  }
  int? _appointmentNo;

  int? get appointmentNo => _appointmentNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appointmentNo'] = _appointmentNo;
    return map;
  }
}
