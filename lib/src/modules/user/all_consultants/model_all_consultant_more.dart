import 'package:ista_app/src/modules/user/all_consultants/model_all_consultant.dart';

class AllCategoriesWithConsultantMoreModel {
  AllCategoriesWithConsultantMoreModel({
    bool? status,
    int? success,
    AllCategoriesWithConsultantMoreModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  AllCategoriesWithConsultantMoreModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? AllCategoriesWithConsultantMoreModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  AllCategoriesWithConsultantMoreModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  AllCategoriesWithConsultantMoreModelData? get data => _data;
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

class AllCategoriesWithConsultantMoreModelData {
  AllCategoriesWithConsultantMoreModelData({
    CategoriesMore? categories,
  }) {
    _categories = categories;
  }

  AllCategoriesWithConsultantMoreModelData.fromJson(dynamic json) {
    _categories = json['categories'] != null
        ? CategoriesMore.fromJson(json['categories'])
        : null;
  }
  CategoriesMore? _categories;

  CategoriesMore? get categories => _categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_categories != null) {
      map['categories'] = _categories?.toJson();
    }
    return map;
  }
}

class CategoriesMore {
  CategoriesMore({
    Mentors? mentors,
  }) {
    _mentors = mentors;
  }

  CategoriesMore.fromJson(dynamic json) {
    _mentors =
        json['mentors'] != null ? Mentors.fromJson(json['mentors']) : null;
  }
  Mentors? _mentors;

  Mentors? get mentors => _mentors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_mentors != null) {
      map['mentors'] = _mentors?.toJson();
    }
    return map;
  }
}
