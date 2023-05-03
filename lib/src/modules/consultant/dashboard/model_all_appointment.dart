class MenteeIdentityHiddenModel {
  MenteeIdentityHiddenModel({
    int? identityHidden,
    int? userId,
  }) {
    _identityHidden = identityHidden;
    _userId = userId;
  }

  MenteeIdentityHiddenModel.fromJson(dynamic json) {
    _identityHidden = json['identity_hidden'];
    _userId = json['user_id'];
  }
  int? _identityHidden;
  int? _userId;

  int? get identityHidden => _identityHidden;
  int? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['identity_hidden'] = _identityHidden;
    map['user_id'] = _userId;
    return map;
  }
}
