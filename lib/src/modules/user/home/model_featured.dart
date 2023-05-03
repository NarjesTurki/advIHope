import 'package:ista_app/src/modules/user/home/model_top_rated.dart';

class FeaturedConsultantModel {
  FeaturedConsultantModel({
    bool? status,
    int? success,
    FeaturedConsultantModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  FeaturedConsultantModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? FeaturedConsultantModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }

  bool? _status;
  int? _success;
  FeaturedConsultantModelData? _data;
  String? _msg;

  bool? get status => _status;

  int? get success => _success;

  FeaturedConsultantModelData? get data => _data;

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

class FeaturedConsultantModelData {
  FeaturedConsultantModelData({
    List<MentorBasicModel>? mentors,
  }) {
    _mentors = mentors;
  }

  FeaturedConsultantModelData.fromJson(dynamic json) {
    if (json['mentors'] != null) {
      _mentors = [];
      json['mentors'].forEach((v) {
        _mentors?.add(MentorBasicModel.fromJson(v));
      });
    }
  }

  List<MentorBasicModel>? _mentors;

  List<MentorBasicModel>? get mentors => _mentors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_mentors != null) {
      map['mentors'] = _mentors?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
