class AccountsFilter {
  String? search;
  int? limit;
  int? offset;

  AccountsFilter({
    this.search,
    this.limit = 100,
    this.offset,
  });

  AccountsFilter.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    search = json['search'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search'] = search;
    data['offset'] = offset;
    data['limit'] = limit;
    return data;
  }
}
