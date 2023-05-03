class TopRatedModel {
  TopRatedModel({
    bool? status,
    int? success,
    TopRatedModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  TopRatedModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data =
        json['data'] != null ? TopRatedModelData.fromJson(json['data']) : null;
    _msg = json['msg'];
  }

  bool? _status;
  int? _success;
  TopRatedModelData? _data;
  String? _msg;

  bool? get status => _status;

  int? get success => _success;

  TopRatedModelData? get data => _data;

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

class TopRatedModelData {
  TopRatedModelData({
    TopRatedMentors? topRatedMentors,
  }) {
    _topRatedMentors = topRatedMentors;
  }

  TopRatedModelData.fromJson(dynamic json) {
    _topRatedMentors = json['topRatedMentors'] != null
        ? TopRatedMentors.fromJson(json['topRatedMentors'])
        : null;
  }

  TopRatedMentors? _topRatedMentors;

  TopRatedMentors? get topRatedMentors => _topRatedMentors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_topRatedMentors != null) {
      map['topRatedMentors'] = _topRatedMentors?.toJson();
    }
    return map;
  }
}

class TopRatedMentors {
  TopRatedMentors({
    int? currentPage,
    List<MentorBasicModel>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Links>? links,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) {
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _links = links;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
  }

  TopRatedMentors.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MentorBasicModel.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }

  int? _currentPage;
  List<MentorBasicModel>? _data;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  List<Links>? _links;
  dynamic _nextPageUrl;
  String? _path;
  int? _perPage;
  dynamic _prevPageUrl;
  int? _to;
  int? _total;

  int? get currentPage => _currentPage;

  List<MentorBasicModel>? get data => _data;

  String? get firstPageUrl => _firstPageUrl;

  int? get from => _from;

  int? get lastPage => _lastPage;

  String? get lastPageUrl => _lastPageUrl;

  List<Links>? get links => _links;

  dynamic get nextPageUrl => _nextPageUrl;

  String? get path => _path;

  int? get perPage => _perPage;

  dynamic get prevPageUrl => _prevPageUrl;

  int? get to => _to;

  int? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }
}

class Links {
  Links({
    dynamic url,
    String? label,
    bool? active,
  }) {
    _url = url;
    _label = label;
    _active = active;
  }

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }

  dynamic _url;
  String? _label;
  bool? _active;

  dynamic get url => _url;

  String? get label => _label;

  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }
}

class MentorBasicModel {
  MentorBasicModel({
    String? firstName,
    String? lastName,
    String? imagePath,
    int? userId,
    int? topRating,
    CategoryBasicModel? category,
    int? ratingCount,
    int? ratingAvg,
    String? gender,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _imagePath = imagePath;
    _userId = userId;
    _topRating = topRating;
    _category = category;
    _ratingCount = ratingCount;
    _ratingAvg = ratingAvg;
    _gender = gender;
  }

  MentorBasicModel.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _imagePath = json['image_path'];
    _userId = json['user_id'];
    _topRating = json['topRating'];
    _category = json['category'] != null
        ? CategoryBasicModel.fromJson(json['category'])
        : null;
    _ratingCount = json['ratingCount'];
    _ratingAvg = json['ratingAvg'];
    _gender = json['gender'];
  }

  String? _firstName;
  String? _lastName;
  String? _imagePath;
  int? _userId;
  int? _topRating;
  CategoryBasicModel? _category;
  int? _ratingCount;
  int? _ratingAvg;
  String? _gender;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get imagePath => _imagePath;

  int? get userId => _userId;

  int? get topRating => _topRating;

  CategoryBasicModel? get category => _category;

  int? get ratingCount => _ratingCount;

  int? get ratingAvg => _ratingAvg;
  String? get gender => _gender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['image_path'] = _imagePath;
    map['user_id'] = _userId;
    map['topRating'] = _topRating;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    map['ratingCount'] = _ratingCount;
    map['ratingAvg'] = _ratingAvg;
    map['gender'] = _gender;
    return map;
  }
}

class CategoryBasicModel {
  CategoryBasicModel({
    int? id,
    int? parentId,
    String? name,
    String? slug,
    dynamic imagePath,
    dynamic description,
    dynamic createdAt,
    dynamic updatedAt,
  }) {
    _id = id;
    _parentId = parentId;
    _name = name;
    _slug = slug;
    _imagePath = imagePath;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  CategoryBasicModel.fromJson(dynamic json) {
    _id = json['id'];
    _parentId = json['parent_id'];
    _name = json['name'];
    _slug = json['slug'];
    _imagePath = json['image_path'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  int? _parentId;
  String? _name;
  String? _slug;
  dynamic _imagePath;
  dynamic _description;
  dynamic _createdAt;
  dynamic _updatedAt;

  int? get id => _id;

  int? get parentId => _parentId;

  String? get name => _name;

  String? get slug => _slug;

  dynamic get imagePath => _imagePath;

  dynamic get description => _description;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

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
    return map;
  }
}
