
import 'package:ista_app/src/modules/consultant/consultant_appointment/model_get_consultant_appointment.dart';

class GetTodayAppointmentModel {
  GetTodayAppointmentModel({
    bool? status,
    int? success,
    GetTodayAppointmentModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  GetTodayAppointmentModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? GetTodayAppointmentModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  GetTodayAppointmentModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  GetTodayAppointmentModelData? get data => _data;
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

class GetTodayAppointmentModelData {
  GetTodayAppointmentModelData({
    List<ConsultantAppointmentsData>? results,
  }) {
    _results = results;
  }

  GetTodayAppointmentModelData.fromJson(dynamic json) {
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(ConsultantAppointmentsData.fromJson(v));
      });
    }
  }
  List<ConsultantAppointmentsData>? _results;

  List<ConsultantAppointmentsData>? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
