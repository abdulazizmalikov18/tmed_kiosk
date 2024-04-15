// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
// import 'package:tmed_kiosk/features/specialists/data/model/spec_cat_model.dart';

// class ProductTypeEntity extends Equatable {
//   final int id;
//   final ProductType name;
//   final int specialistCount;

//   const ProductTypeEntity({
//     this.id = 0,
//     this.name = ProductType.task,
//     this.specialistCount = 0,
//   });

//   @override
//   List<Object?> get props => [
//         id,
//         name,
//         specialistCount,
//       ];
// }

// class SpecCatConverter implements JsonConverter<ProductTypeEntity, Map<String, dynamic>?> {
//   const SpecCatConverter();
//   @override
//   ProductTypeEntity fromJson(Map<String, dynamic>? json) => SpecCatModel.fromJson(json ?? {});

//   @override
//   Map<String, dynamic>? toJson(ProductTypeEntity object) => {};
// }
