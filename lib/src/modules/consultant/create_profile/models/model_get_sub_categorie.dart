class SubCategoriesModel {
  SubCategoriesModel({
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

  SubCategoriesModel.fromJson(dynamic json) {
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
    List<MentorCategories>? mentorCategories,
  }) {
    _mentorCategories = mentorCategories;
  }

  Data.fromJson(dynamic json) {
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
    String? slug,
    String? imagePath,
    String? description,
    String? createdAt,
    String? updatedAt,
    List<SubCategories>? subCategories,
  }) {
    _id = id;
    _parentId = parentId;
    _name = name;
    _slug = slug;
    _imagePath = imagePath;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _subCategories = subCategories;
  }

  MentorCategories.fromJson(dynamic json) {
    _id = json['id'];
    _parentId = json['parent_id'];
    _name = json['name'];
    _slug = json['slug'];
    _imagePath = json['image_path'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['sub_categories'] != null) {
      _subCategories = [];
      json['sub_categories'].forEach((v) {
        _subCategories?.add(SubCategories.fromJson(v));
      });
    }
  }
  int? _id;
  int? _parentId;
  String? _name;
  String? _slug;
  String? _imagePath;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
  List<SubCategories>? _subCategories;

  int? get id => _id;
  int? get parentId => _parentId;
  String? get name => _name;
  String? get slug => _slug;
  String? get imagePath => _imagePath;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<SubCategories>? get subCategories => _subCategories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['parent_id'] = _parentId;
    map['name'] = _name;
    map['slug'] = _slug;
    map['image_path'] = _imagePath;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_subCategories != null) {
      map['sub_categories'] = _subCategories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class SubCategories {
  SubCategories({
    int? id,
    int? parentId,
    String? name,
    String? slug,
    String? imagePath,
    String? description,
    String? createdAt,
    String? updatedAt,
    List<SubCategories>? subCategories,
  }) {
    _id = id;
    _parentId = parentId;
    _name = name;
    _slug = slug;
    _imagePath = imagePath;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _subCategories = subCategories;
  }

  SubCategories.fromJson(dynamic json) {
    _id = json['id'];
    _parentId = json['parent_id'];
    _name = json['name'];
    _slug = json['slug'];
    _imagePath = json['image_path'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['sub_categories'] != null) {
      _subCategories = [];
      json['sub_categories'].forEach((v) {
        _subCategories?.add(SubCategories.fromJson(v));
      });
    }
  }
  int? _id;
  int? _parentId;
  String? _name;
  String? _slug;
  String? _imagePath;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
  List<SubCategories>? _subCategories;

  int? get id => _id;
  int? get parentId => _parentId;
  String? get name => _name;
  String? get slug => _slug;
  String? get imagePath => _imagePath;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<SubCategories>? get subCategories => _subCategories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['parent_id'] = _parentId;
    map['name'] = _name;
    map['slug'] = _slug;
    map['image_path'] = _imagePath;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_subCategories != null) {
      map['sub_categories'] = _subCategories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
