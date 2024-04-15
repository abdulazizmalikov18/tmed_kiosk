class GoodsQueryParam {
  int? group;
  int? specialist;
  String? search;
  int? offset;
  int? limit;
  bool? isOffline;

  GoodsQueryParam({
    this.offset,
    this.group,
    this.search,
    this.specialist,
    this.limit = 150,
    this.isOffline = false,
  });

  GoodsQueryParam.fromJson(Map<String, dynamic> json) {
    group = json['group_id'];
    search = json['search'];
    specialist = json['specialist'];
    offset = json['offset'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group_id'] = group;
    data['search'] = search;
    data['specialist'] = specialist;
    data['offset'] = offset;
    data['limit'] = limit;
    return data;
  }
}
