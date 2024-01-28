/// name : "nyl"
/// password : "123456"

class ChildAppModel {
  ChildAppModel({
      String? name, 
      String? password,}){
    _name = name;
    _password = password;
}

  ChildAppModel.fromJson(dynamic json) {
    _name = json['name'];
    _password = json['password'];
  }
  String? _name;
  String? _password;
ChildAppModel copyWith({  String? name,
  String? password,
}) => ChildAppModel(  name: name ?? _name,
  password: password ?? _password,
);
  String? get name => _name;
  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['password'] = _password;
    return map;
  }

}