class FetchMessagesModel {
  FetchMessagesModel({
    bool? status,
    int? success,
    MessageData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  FetchMessagesModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null ? MessageData.fromJson(json['data']) : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  MessageData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  MessageData? get data => _data;
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

class MessageData {
  MessageData({
    List<Messages>? messages,
  }) {
    _messages = messages;
  }

  MessageData.fromJson(dynamic json) {
    if (json['messages'] != null) {
      _messages = [];
      json['messages'].forEach((v) {
        _messages?.add(Messages.fromJson(v));
      });
    }
  }
  List<Messages>? _messages;

  List<Messages>? get messages => _messages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_messages != null) {
      map['messages'] = _messages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Messages {
  Messages({
    int? id,
    String? message,
    int? senderId,
    String? senderName,
    int? receiverId,
    String? receiverName,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _message = message;
    _senderId = senderId;
    _senderName = senderName;
    _receiverId = receiverId;
    _receiverName = receiverName;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Messages.fromJson(dynamic json) {
    _id = int.parse(json['id'].toString());
    _message = json['message'];
    _senderId = json['sender_id'];
    _senderName = json['sender_name'];
    _receiverId = json['receiver_id'];
    _receiverName = json['receiver_name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _message;
  int? _senderId;
  String? _senderName;
  int? _receiverId;
  String? _receiverName;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get message => _message;
  int? get senderId => _senderId;
  String? get senderName => _senderName;
  int? get receiverId => _receiverId;
  String? get receiverName => _receiverName;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['message'] = _message;
    map['sender_id'] = _senderId;
    map['sender_name'] = _senderName;
    map['receiver_id'] = _receiverId;
    map['receiver_name'] = _receiverName;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
