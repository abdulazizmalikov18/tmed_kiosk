class AccountCreateModel {
  String? param;
  Map<String, String>? mydata;

  AccountCreateModel({
    this.param,
    this.mydata = const {},
  });

  AccountCreateModel.fromJson(Map<String, dynamic> json) {
    param = json['param'];
    mydata = json['mydata'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mydata'] = mydata;
    data['param'] = param;
    return data;
  }
}
