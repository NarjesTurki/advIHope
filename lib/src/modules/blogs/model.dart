class GetAllBlogModel {
  GetAllBlogModel({
    bool? status,
    int? success,
    GetAllBlogModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  GetAllBlogModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? GetAllBlogModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }

  bool? _status;
  int? _success;
  GetAllBlogModelData? _data;
  String? _msg;

  bool? get status => _status;

  int? get success => _success;

  GetAllBlogModelData? get data => _data;

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

class GetAllBlogModelData {
  GetAllBlogModelData({
    List<CategoryBlogs>? categoryBlogs,
    List<BlogModel>? featuredBlogs,
  }) {
    _categoryBlogs = categoryBlogs;
    _featuredBlogs = featuredBlogs;
  }

  GetAllBlogModelData.fromJson(dynamic json) {
    if (json['categoryBlogs'] != null) {
      _categoryBlogs = [];
      json['categoryBlogs'].forEach((v) {
        _categoryBlogs?.add(CategoryBlogs.fromJson(v));
      });
    }
    if (json['featured_blogs'] != null) {
      _featuredBlogs = [];
      json['featured_blogs'].forEach((v) {
        _featuredBlogs?.add(BlogModel.fromJson(v));
      });
    }
  }

  List<CategoryBlogs>? _categoryBlogs;
  List<BlogModel>? _featuredBlogs;

  List<CategoryBlogs>? get categoryBlogs => _categoryBlogs;

  List<BlogModel>? get featuredBlogs => _featuredBlogs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_categoryBlogs != null) {
      map['categoryBlogs'] = _categoryBlogs?.map((v) => v.toJson()).toList();
    }
    if (_featuredBlogs != null) {
      map['featured_blogs'] = _featuredBlogs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class CategoryBlogs {
  CategoryBlogs({
    BlogCategoryModel? category,
    List<BlogModel>? blogs,
  }) {
    _category = category;
    _blogs = blogs;
  }

  CategoryBlogs.fromJson(dynamic json) {
    _category = json['category'] != null
        ? BlogCategoryModel.fromJson(json['category'])
        : null;
    if (json['blogs'] != null) {
      _blogs = [];
      json['blogs'].forEach((v) {
        _blogs?.add(BlogModel.fromJson(v));
      });
    }
  }

  BlogCategoryModel? _category;
  List<BlogModel>? _blogs;

  BlogCategoryModel? get category => _category;

  List<BlogModel>? get blogs => _blogs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    if (_blogs != null) {
      map['blogs'] = _blogs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class BlogModel {
  BlogModel({
    int? id,
    int? categoryId,
    String? title,
    String? description,
    String? imagePath,
    int? featured,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _categoryId = categoryId;
    _title = title;
    _description = description;
    _imagePath = imagePath;
    _featured = featured;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  BlogModel.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _title = json['title'];
    _description = json['description'];
    _imagePath = json['image_path'];
    _featured = json['featured'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  int? _categoryId;
  String? _title;
  String? _description;
  String? _imagePath;
  int? _featured;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;

  int? get categoryId => _categoryId;

  String? get title => _title;

  String? get description => _description;

  String? get imagePath => _imagePath;

  int? get featured => _featured;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['title'] = _title;
    map['description'] = _description;
    map['image_path'] = _imagePath;
    map['featured'] = _featured;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class BlogCategoryModel {
  BlogCategoryModel({
    int? id,
    String? name,
    String? imagePath,
    dynamic description,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _imagePath = imagePath;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  BlogCategoryModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _imagePath = json['image_path'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  String? _name;
  String? _imagePath;
  dynamic _description;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;

  String? get name => _name;

  String? get imagePath => _imagePath;

  dynamic get description => _description;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image_path'] = _imagePath;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
