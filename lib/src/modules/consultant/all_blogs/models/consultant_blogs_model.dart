class ConsultantBlogsModel {
  ConsultantBlogsModel({
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

  ConsultantBlogsModel.fromJson(dynamic json) {
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
    List<Blogs>? blogs,
  }) {
    _blogs = blogs;
  }

  Data.fromJson(dynamic json) {
    if (json['blogs'] != null) {
      _blogs = [];
      json['blogs'].forEach((v) {
        _blogs?.add(Blogs.fromJson(v));
      });
    }
  }
  List<Blogs>? _blogs;

  List<Blogs>? get blogs => _blogs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_blogs != null) {
      map['blogs'] = _blogs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Blogs {
  Blogs({
    int? id,
    int? categoryId,
    int? userId,
    String? title,
    String? slug,
    String? description,
    String? imagePath,
    int? featured,
    int? isApproved,
    String? createdAt,
    String? updatedAt,
    List<Category>? category,
  }) {
    _id = id;
    _categoryId = categoryId;
    _userId = userId;
    _title = title;
    _slug = slug;
    _description = description;
    _imagePath = imagePath;
    _featured = featured;
    _isApproved = isApproved;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _category = category;
  }

  Blogs.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _userId = json['user_id'];
    _title = json['title'];
    _slug = json['slug'];
    _description = json['description'];
    _imagePath = json['image_path'];
    _featured = json['featured'];
    _isApproved = json['is_approved'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['category'] != null) {
      _category = [];
      json['category'].forEach((v) {
        _category?.add(Category.fromJson(v));
      });
    }
  }
  int? _id;
  int? _categoryId;
  int? _userId;
  String? _title;
  String? _slug;
  String? _description;
  String? _imagePath;
  int? _featured;
  int? _isApproved;
  String? _createdAt;
  String? _updatedAt;
  List<Category>? _category;

  int? get id => _id;
  int? get categoryId => _categoryId;
  int? get userId => _userId;
  String? get title => _title;
  String? get slug => _slug;
  String? get description => _description;
  String? get imagePath => _imagePath;
  int? get featured => _featured;
  int? get isApproved => _isApproved;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<Category>? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['user_id'] = _userId;
    map['title'] = _title;
    map['slug'] = _slug;
    map['description'] = _description;
    map['image_path'] = _imagePath;
    map['featured'] = _featured;
    map['is_approved'] = _isApproved;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_category != null) {
      map['category'] = _category?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Category {
  Category({
    int? id,
    String? name,
    String? slug,
    dynamic imagePath,
    dynamic description,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _slug = slug;
    _imagePath = imagePath;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _imagePath = json['image_path'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _slug;
  dynamic _imagePath;
  dynamic _description;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  dynamic get imagePath => _imagePath;
  dynamic get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['image_path'] = _imagePath;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
