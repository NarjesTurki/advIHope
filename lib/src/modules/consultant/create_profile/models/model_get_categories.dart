class GetCategoriesModel {
  GetCategoriesModel({
    bool? status,
    int? success,
    GetCategoriesModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  GetCategoriesModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? GetCategoriesModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  GetCategoriesModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  GetCategoriesModelData? get data => _data;
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

class GetCategoriesModelData {
  GetCategoriesModelData({
    List<MentorCategories>? mentorCategories,
  }) {
    _mentorCategories = mentorCategories;
  }

  GetCategoriesModelData.fromJson(dynamic json) {
    if (json['mentorCategories'] != null) {
      _mentorCategories = [];
      json['mentorCategories'].forEach((v) {
        _mentorCategories?.add(MentorCategories.fromJson(v));
      });
    }
  }
  List<MentorCategories>? _mentorCategories;

  List<MentorCategories>? get mentorCategories => _mentorCategories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_mentorCategories != null) {
      map['mentorCategories'] =
          _mentorCategories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class MentorCategories {
  MentorCategories({
    int? id,
    int? parentId,
    String? name,
    String? imagePath,
    dynamic description,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _parentId = parentId;
    _name = name;
    _imagePath = imagePath;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  MentorCategories.fromJson(dynamic json) {
    _id = json['id'];
    _parentId = json['parent_id'];
    _name = json['name'];
    _imagePath = json['image_path'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _parentId;
  String? _name;
  String? _imagePath;
  dynamic _description;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get parentId => _parentId;
  String? get name => _name;
  String? get imagePath => _imagePath;
  dynamic get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['parent_id'] = _parentId;
    map['name'] = _name;
    map['image_path'] = _imagePath;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
