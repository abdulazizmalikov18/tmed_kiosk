class CuSel {
  String? user;
  int? id;

  CuSel({
    this.user,
    this.id = 0,
  });

  CuSel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['id'] = id;
    return data;
  }
}
