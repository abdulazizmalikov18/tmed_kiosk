class CFilter {
  String? user;
  String? search;
  int? limit;

  CFilter({
    this.user,
    this.search,
    this.limit = 50,
  });

  CFilter.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    user = json['search'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['search'] = search;
    data['limit'] = limit;
    return data;
  }
}
