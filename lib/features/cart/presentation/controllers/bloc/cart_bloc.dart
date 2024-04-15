import 'package:tmed_kiosk/features/common/entity/orders_entity.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:tmed_kiosk/features/goods/domain/usecase/org_product_id_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/core/usecases/usecase.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/cart/data/models/orders_creat_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/update_orders_model.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/cupon_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/org_cart_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/post_product_filter.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/process_status_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/product_cart_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/recommendation/rec_product_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/coupon_id_usecase.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/order_create_usecase.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/process_status_usecase.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/update_order_usecase.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/list_count.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/domain/usecase/get_products_list_usecase.dart';
import 'package:tmed_kiosk/features/main/domain/entity/product_specia.dart';

part 'cart_event.dart';
part 'cart_state.dart';

enum ProductType {
  product,
  task,
  offering,
}

class CartBloc extends Bloc<CartEvent, CartState> {
  CreatOrderUseCase useCase = CreatOrderUseCase();
  ProcessStatusUseCase processStatus = ProcessStatusUseCase();
  CuponIdUseCase cuponIDUse = CuponIdUseCase();
  ProductsIdListUseCase productsIdList = ProductsIdListUseCase();
  UpdateOrderUseCase update = UpdateOrderUseCase();
  OrgProductIDUseUseCase productsId = OrgProductIDUseUseCase();
  CartBloc() : super(const CartState()) {
    on<SelStatus>(
        (event, emit) => emit(state.copyWith(selStatus: event.selStatus)));

    on<UpdateOrder>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final result = await update.call(event.model);
      if (result.isRight) {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
        event.onSuccess();
      } else {
        event.onError("Server Error");
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });

    on<CartAddRecommendation>((event, emit) async {
      emit(state.copyWith(aStatus: FormzSubmissionStatus.inProgress));
      add(CartRemove());
      List<int> list = event.products.map((e) => e.product).toList();
      final result = await productsIdList.call(list);
      if (result.isRight) {
        if (result.right.isEmpty) {
          event.onError("Mahsulot topilmadi");
          emit(state.copyWith(aStatus: FormzSubmissionStatus.failure));
        } else {
          for (var i = 0; i < result.right.length; i++) {
            add(CartAddMap(result.right[i], 0));
          }
          event.onSuccess();
          emit(state.copyWith(aStatus: FormzSubmissionStatus.success));
        }
      } else {
        event.onError((result.left as ServerFailure).errorMessage);
        emit(state.copyWith(aStatus: FormzSubmissionStatus.failure));
      }
    });

    on<CuponSel>((event, emit) => emit(state.copyWith(cupon: event.cupon)));

    on<RemoveCupon>(
        (event, emit) => emit(state.copyWith(cupon: const CuponEntity())));

    on<CreatOrder>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final carts = List.generate(
        state.counts.length,
        (index) => state.counts[index].dateTime == null
            ? {
                "product": state.counts[index].id,
                "qty": state.counts[index].count,
                "date": "2023-08-09T15:22:41.612853+05:00",
                "surcharge_ids": state.counts[index].surchargeIds ?? [],
                "supply": state.counts[index].supplies,
                "add_charge": state.counts[index].pricePercent
              }
            : {
                "product": state.counts[index].id,
                "responsible": state.counts[index].psp?.specialist.id,
                "qty": state.counts[index].count,
                "surcharge_ids": state.counts[index].surchargeIds ?? [],
                "add_charge": state.counts[index].pricePercent,
                "meet_date":
                    "${state.counts[index].dateTime!.year}-${state.counts[index].dateTime!.month}-${state.counts[index].dateTime!.day}T${state.counts[index].dateTime!.hour}:${state.counts[index].dateTime!.minute}+05:00"
              },
      );
      OrdersCreatModel params = OrdersCreatModel(
        action: event.filter.method ? "pay" : "in_advance",
        clientComment: event.filter.clientComment,
        specsComment: event.filter.specsComment,
        processStatus: state.selStatus.id,
        cartProducts: carts,
        payments: event.filter.paymentinorderSet ??
            [
              {"method": 1, "cost": 0}
            ],
        couponId: state.cupon.title.isNotEmpty ? state.cupon.id : null,
        clientUsername: event.username,
      );
      final result = await useCase.call(params);
      if (result.isRight) {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
        event.onSuccess(result.right);
        add(CartRemove());
      } else {
        event.onError((result.left as ServerFailure).errorMessage);
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });

    on<GetProcessStatus>((event, emit) async {
      final result = await processStatus.call(NoParams());
      if (result.isRight) {
        emit(state.copyWith(
            processStatus: result.right.results,
            selStatus: result.right.results[0]));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });

    on<CartAddMap>((event, emit) {
      Map<int, OrgProductEntity> map = {};
      List<ListCount> count = List.from(state.counts);
      int discountE = 0;
      int allPrice = state.allPrice;
      int discount = state.discount;
      int iscount = event.count ?? 1;
      map.addAll(state.cartMap);
      bool isCupon = false;
      if (state.cupon.title.isNotEmpty) {
        isCupon = state.cupon.extra.products.contains(event.product.id);
      }
      double discoun = state.cupon.productDiscount / 100;
      if (discoun == 1) {
        discoun = 0;
      }
      double disDiscount = 1 - discoun;
      if (!map.containsKey(event.product.id)) {
        if (MyFunctions.getProductType(event.product.product.type.name) !=
            ProductType.task) {
          if (isCupon) {
            discount +=
                iscount * (event.product.prices[0].value * disDiscount).toInt();
            allPrice +=
                iscount * (event.product.prices[0].value * discoun).toInt();
          } else {
            if (event.discountPrice != null && event.discountPrice! != 0) {
              discountE = MyFunctions.discountPrice(
                event.discountPrice == 0
                    ? event.product.prices.first.discount.toInt()
                    : event.discountPrice!,
                event.product.prices.first.value.toInt(),
              );
              // Log.w("Biz Ikkinchidamiz $discountE");
              // discountE = ((event.discountPrice! / 100) *
              //         event.product.prices.first.value)
              //     .toInt();

              // Log.w("Biz Da endi $discountE");
              discount += iscount * discountE;
              allPrice += iscount *
                  (event.product.prices.first.value.toInt() - discountE);
              Log.w("Biz Ikkinchidamiz: $allPrice");
            } else {
              Log.w("Biz uchunchidamiz");
              if (event.product.prices.isNotEmpty) {
                allPrice +=
                    iscount * event.product.prices.first.discountPrice.toInt();
                discount += iscount *
                    (event.product.prices.first.value -
                            event.product.prices.first.discountPrice)
                        .toInt();
              }
              Log.w("Biz Ikkinchidamiz: $allPrice");
            }
          }
          map[event.product.id] = event.product;
          int priceCal = 0;
          if (event.product.prices.isNotEmpty) {
            Log.e(discountE);
            if (event.discountPrice == null || event.discountPrice == 0) {
              Log.w("Birinchi muammo");
              priceCal = event.product.prices.first.discountPrice.toInt();
              Log.w("Birinchi muammo: $priceCal");
            } else {
              priceCal = event.product.prices.first.value.toInt() - discountE;
              Log.w("Ikkinchi muammo: $priceCal");
            }
            Log.e(priceCal);
          }
          count.add(ListCount(
            id: event.product.id,
            count: event.count ?? 1,
            cuponPrice: isCupon ? state.cupon.productDiscount.toInt() : 0,
            price: isCupon ? (priceCal * discoun).toInt() : priceCal,
            discount: isCupon
                ? iscount * (priceCal * disDiscount).toInt()
                : event.discountPrice == null
                    ? iscount *
                        (event.product.prices[0].value -
                                event.product.prices[0].discountPrice)
                            .toInt()
                    : iscount * discountE,
            psp: event.psp,
            allPrice: isCupon
                ? iscount * (priceCal * discoun).toInt()
                : iscount * priceCal,
            dateTime: event.dateTime,
            discountPrice: isCupon
                ? state.cupon.productDiscount.toInt() * (-1)
                : event.discountPrice ?? 0,
            surchargeIds: event.surchargeIds,
            supplies: event.supplies,
            selectIndex: event.selectIndex,
            dataIndex: event.dataIndex,
            pricePercent: event.pricePercent,
          ));
        } else {
          map[event.product.id] = event.product;
          count.add(ListCount(
            id: event.product.id,
            count: event.count ?? 1,
            psp: event.psp,
            dateTime: event.dateTime,
            surchargeIds: event.surchargeIds,
            supplies: event.supplies,
            selectIndex: event.selectIndex,
            dataIndex: event.dataIndex,
          ));
        }
      } else {
        final index =
            count.indexWhere((element) => element.id == event.product.id);
        if (event.isCart) {
          if (event.product.remains > count[index].count &&
              MyFunctions.getProductType(event.product.product.type.name) !=
                  ProductType.task) {
            if (count[index].discountPrice != 0) {
              allPrice += count[index].price;
              discount += count[index].discount;
            } else {
              allPrice += event.product.prices[0].discountPrice.toInt();
              discount += (event.product.prices[0].value -
                      event.product.prices[0].discountPrice)
                  .toInt();
            }
            count[index].count += 1;
            count[index].allPrice = count[index].count * count[index].price;
          }
        } else {
          map.remove(event.product.id);
          if (MyFunctions.getProductType(event.product.product.type.name) !=
              ProductType.task) {
            if (count[index].discountPrice != 0) {
              allPrice -= count[index].price;
              discount -= count[index].discount;
            } else {
              allPrice -= event.product.prices[0].discountPrice.toInt();
              discount -= (event.product.prices[0].value -
                      event.product.prices[0].discountPrice)
                  .toInt();
            }
          }
          count.removeWhere((element) => element.id == event.product.id);
        }
      }
      emit(state.copyWith(
        cartMap: map,
        counts: count,
        allPrice: allPrice,
        discount: discount,
      ));
    });

    on<CartEdit>((event, emit) {
      List<ListCount> count = List.from(state.counts);
      int allPrice = state.allPrice;
      int discount = state.discount;
      int discountE = 0;
      count[event.index];
      allPrice -= count[event.index].price * count[event.index].count;
      discount -= count[event.index].discount * count[event.index].count;
      if (event.discountPrice != null) {
        discountE += MyFunctions.discountPrice(
          event.discountPrice == 0
              ? event.orgProductCart.prices.first.discount.toInt()
              : event.discountPrice!,
          event.orgProductCart.prices.first.value.toInt(),
        );
        Log.e(event.orgProductCart.prices.first.discountPrice.toInt());
        Log.d(event.discountPrice);
        Log.wtf(discountE);
        discount += discountE * count[event.index].count;
        allPrice +=
            (event.orgProductCart.prices.first.value.toInt() - discountE) *
                count[event.index].count;
      } else {
        allPrice += event.orgProductCart.prices.first.discountPrice.toInt() *
            count[event.index].count;
        discount += (event.orgProductCart.prices.first.value -
                    event.orgProductCart.prices.first.discountPrice)
                .toInt() *
            count[event.index].count;
      }
      count[event.index].allPrice = event.discountPrice == null
          ? event.orgProductCart.prices.first.discountPrice.toInt()
          : event.orgProductCart.prices.first.value.toInt() - discountE;
      count[event.index].price = event.discountPrice == null
          ? event.orgProductCart.prices.first.discountPrice.toInt()
          : event.orgProductCart.prices.first.value.toInt() - discountE;
      count[event.index].discount = event.discountPrice == null
          ? (event.orgProductCart.prices.first.value -
                  event.orgProductCart.prices.first.discountPrice)
              .toInt()
          : discountE;
      count[event.index].psp = event.psp;
      count[event.index].dateTime = event.dateTime;
      count[event.index].discountPrice = event.discountPrice ?? 0;
      count[event.index].surchargeIds = event.surchargeIds;
      count[event.index].supplies = event.supplies;
      count[event.index].selectIndex = event.selectIndex;
      count[event.index].dataIndex = event.dataIndex;
      count[event.index].pricePercent = event.pricePercent;
      emit(state.copyWith(
        counts: count,
        allPrice: allPrice,
        discount: discount,
      ));
    });

    on<CartRemove>(
      (event, emit) {
        if (event.isOrder) {
          emit(state.copyWith(
            cartMap: {},
            counts: [],
            allPrice: 0,
            discount: 0,
            cupon: const CuponEntity(),
          ));
        } else {
          emit(state.copyWith(
            cartMap: {},
            counts: [],
            allPrice: 0,
            discount: 0,
            avans: 0,
            cupon: const CuponEntity(),
            isOrder: '',
            username: '',
          ));
        }
      },
    );

    on<CountEdit>((event, emit) {
      List<ListCount> counts = List.from(event.counts);
      emit(state.copyWith(
        counts: counts,
        allPrice: event.allPrice,
        discount: event.discount,
      ));
    });
  }
}
