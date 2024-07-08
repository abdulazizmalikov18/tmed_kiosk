class CFilter {
  String? user;
  String? search;
  int? limit;
  int? offset;

  CFilter({
    this.user,
    this.search,
    this.limit = 50,
    this.offset,
  });

  CFilter.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    user = json['search'];
    limit = json['limit'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['search'] = search;
    data['offset'] = offset;
    data['limit'] = limit;
    return data;
  }
}
