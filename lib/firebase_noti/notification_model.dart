/// id : 0
/// title : "noti title"
/// description : "des"
/// date : "date"
/// isView : 0
///
/// { "id" : 0,
//  "title" : "noti title",
//  "description" : "des",
//  "date" : "date",
// "isView":0
// }

class NotificationModel {
  NotificationModel({
    num? id,
    String? title,
    String? description,
    String? date,
    num? isView,
  }) {
    _id = id;
    _title = title;
    _description = description;
    _date = date;
    _isView = isView;
  }

  NotificationModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _date = json['date'];
    _isView = json['isView'];
  }
  num? _id;
  String? _title;
  String? _description;
  String? _date;
  num? _isView;
  NotificationModel copyWith({
    num? id,
    String? title,
    String? description,
    String? date,
    num? isView,
  }) =>
      NotificationModel(
        id: id ?? _id,
        title: title ?? _title,
        description: description ?? _description,
        date: date ?? _date,
        isView: isView ?? _isView,
      );
  num? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get date => _date;
  num? get isView => _isView;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;
    map['isView'] = _isView;
    return map;
  }



  // Create an Item object from a Map
  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
      isView: map['isView'],
    );
  }
}
