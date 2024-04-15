class UpdateOrdersModel {
  List<Map<String, dynamic>>? producttoorderSet;
  String? clientUsername;
  String? clientComment;
  String? id;

  UpdateOrdersModel({
    this.id,
    this.producttoorderSet,
    this.clientComment = '',
    this.clientUsername,
  });

  UpdateOrdersModel.fromJson(Map<String, dynamic> json) {
    producttoorderSet = json['producttoorder_set'];
    clientComment = json['client_comment'];
    clientUsername = json['client_username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['producttoorder_set'] = producttoorderSet;
    data['client_comment'] = clientComment;
    data['client_username'] = clientUsername;
    return data;
  }
}
