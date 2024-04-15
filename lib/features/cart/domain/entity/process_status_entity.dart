import 'package:equatable/equatable.dart';

class ProcessStatusEntity extends Equatable {
  final int id;
  final String name;
  final int flow;
  final String key;
  final int order;
  final bool isVisible;

  final bool isDefault;
  final int productCount;

  const ProcessStatusEntity({
    this.id = 0,
    this.name = '',
    this.flow = 0,
    this.key = '',
    this.order = 0,
    this.isVisible = false,
    this.isDefault = false,
    this.productCount = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        flow,
        key,
        order,
        isVisible,
        isDefault,
        productCount,
      ];
}
