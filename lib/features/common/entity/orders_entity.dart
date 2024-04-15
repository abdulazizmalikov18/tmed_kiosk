import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/entity/creator_entity.dart';
import 'package:tmed_kiosk/features/common/entity/order_product_entity.dart';
import 'package:tmed_kiosk/features/common/entity/organization_entity.dart';
import 'package:tmed_kiosk/features/common/entity/user_order_entity.dart';
import 'package:tmed_kiosk/features/common/models/orders_model.dart';

class OrdersEntity extends Equatable {
  final String id;
  final int number;
  final String qrCode;
  @OrganizationConverter()
  final OrganizationEntity organization;
  final dynamic meetAddress;
  final String clientComment;
  @OrderUserConverter()
  final OrderUserEntity user;
  final int status;
  final dynamic rates;
  final int payment;
  final int paymentStatus;
  final double prepaidAmount;
  final double totalCost;
  final dynamic deviceId;
  final String specsComment;
  final int productNumber;
  final double insertedValue;
  @CreatorConverter()
  final CreatorEntity creator;
  final String createDate;
  final String finishDate;
  @OrderProductConverter()
  final List<OrderProductEntity> products;

  const OrdersEntity({
    this.id = '',
    this.number = 0,
    this.organization = const OrganizationEntity(),
    this.meetAddress,
    this.clientComment = '',
    this.user = const OrderUserEntity(),
    this.status = 0,
    this.rates = '',
    this.payment = 0,
    this.paymentStatus = 0,
    this.prepaidAmount = 0,
    this.totalCost = 0,
    this.deviceId = '',
    this.specsComment = '',
    this.productNumber = 0,
    this.insertedValue = 0,
    this.creator = const CreatorEntity(),
    this.createDate = '',
    this.finishDate = '',
    this.qrCode = '',
    this.products = const [],
  });

  @override
  List<Object?> get props => [
        id,
        number,
        qrCode,
        organization,
        meetAddress,
        clientComment,
        user,
        status,
        rates,
        payment,
        paymentStatus,
        prepaidAmount,
        totalCost,
        deviceId,
        specsComment,
        productNumber,
        insertedValue,
        creator,
        createDate,
        finishDate,
        products,
      ];
}

class OrdersConverter
    implements JsonConverter<OrdersEntity, Map<String, dynamic>?> {
  const OrdersConverter();

  @override
  OrdersEntity fromJson(Map<String, dynamic>? json) =>
      OrdersModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(OrdersEntity object) => {};
}
