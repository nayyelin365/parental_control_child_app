/// appName : "nam"
/// version : "vv"
/// appIcon : "icon"
/// packageName : "name"
/// enable : true
/// {	"appName":"nam",
// 	"version":"vv",
// 	"appIcon":"icon",
// 	"packageName":"name",
// 	"enable":"1"
// }

class ChildAppModel {
  ChildAppModel({
    String? appName,
    String? version,
    String? appIcon,
    String? packageName,
    String? enable,
  }) {
    _appName = appName;
    _version = version;
    _appIcon = appIcon;
    _packageName = packageName;
    _enable = enable;
  }

  ChildAppModel.fromJson(dynamic json) {
    _appName = json['appName'];
    _version = json['version'];
    _appIcon = json['appIcon'];
    _packageName = json['packageName'];
    _enable = json['enable'];
  }
  String? _appName;
  String? _version;
  String? _appIcon;
  String? _packageName;
  String? _enable;
  ChildAppModel copyWith({
    String? appName,
    String? version,
    String? appIcon,
    String? packageName,
    String? enable,
  }) =>
      ChildAppModel(
        appName: appName ?? _appName,
        version: version ?? _version,
        appIcon: appIcon ?? _appIcon,
        packageName: packageName ?? _packageName,
        enable: enable ?? _enable,
      );
  String? get appName => _appName;
  String? get version => _version;
  String? get appIcon => _appIcon;
  String? get packageName => _packageName;
  String? get enable => _enable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appName'] = _appName;
    map['version'] = _version;
    map['appIcon'] = _appIcon;
    map['packageName'] = _packageName;
    map['enable'] = _enable;
    return map;
  }
}
