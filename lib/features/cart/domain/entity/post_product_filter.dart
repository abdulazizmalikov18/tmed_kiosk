class PostProductFilter {
  final bool method;
  final int processStatus;
  final List<Map<String, dynamic>>? paymentinorderSet;
  final String? clientComment;
   final String? specsComment;
  const PostProductFilter({
    this.method = false,
    this.processStatus = 1,
    this.paymentinorderSet,
    this.clientComment,
    this.specsComment,
  });
}
