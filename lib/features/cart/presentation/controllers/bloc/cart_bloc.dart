import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/features/cart/data/models/recommendation/recommendation_model.dart';
import 'package:tmed_kiosk/features/common/entity/order_product_entity.dart';
import 'package:tmed_kiosk/features/common/entity/orders_entity.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
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
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_model.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/org_cart_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/post_product_filter.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/process_status_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/product_cart_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/coupon_id_usecase.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/order_create_usecase.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/process_status_usecase.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/update_order_usecase.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/list_count.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/org_product_entity.dart';
import 'package:tmed_kiosk/features/goods/domain/usecase/get_products_list_usecase.dart';
import 'package:tmed_kiosk/features/main/data/model/product_special.dart';

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
  // PatchPayUseCase patchPay = PatchPayUseCase();
  ProductsIdListUseCase productsIdList = ProductsIdListUseCase();
  UpdateOrderUseCase update = UpdateOrderUseCase();
  OrgProductIDUseUseCase productsId = OrgProductIDUseUseCase();
  CartBloc() : super(const CartState()) {
    on<StatusActive>((event, emit) async {
      List<int> list = List.from(state.statusID);
      final statusList = List<ProcessStatusEntity>.from(state.processStatus);
      if (list.contains(event.id)) {
        list.remove(event.id);
        statusList.removeWhere((element) => element.id == event.id);
      } else {
        list.insert(0, event.id);
        if (statusList.where((element) => element.id == event.id).isEmpty) {
          final status = state.processStatusAll
              .firstWhere((element) => element.id == event.id);
          statusList.insert(0, status);
        }
      }
      await StorageRepository.putList(
        StorageKeys.STATUS,
        List.generate(
          list.length,
          (index) => list[index].toString(),
        ),
      );
      emit(state.copyWith(
        selStatus: MyFunctions.checkStatus(statusList),
        statusID: list,
        processStatus: statusList,
        status: FormzSubmissionStatus.success,
      ));
    });

    on<GetProcessStatus>((event, emit) async {
      final list = StorageRepository.getList(StorageKeys.STATUS);
      final result = await processStatus.call(NoParams());
      if (result.isRight) {
        if (list.isEmpty) {
          await StorageRepository.putList(
            StorageKeys.STATUS,
            List.generate(
              result.right.results.length,
              (index) => result.right.results[index].id.toString(),
            ),
          );
        }
        final listCategory = StorageRepository.getList(StorageKeys.STATUS);
        List<int> statusID = [];
        List<ProcessStatusEntity> status = [];
        for (var element in listCategory) {
          statusID.add(int.parse(element));
          final st = result.right.results
              .firstWhere((stat) => stat.id == int.parse(element));
          status.add(st);
        }
        emit(state.copyWith(
          processStatus: status,
          processStatusAll: result.right.results,
          statusID: statusID,
          selStatus: MyFunctions.checkStatus(status),
        ));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });

    on<SelStatus>(
      (event, emit) => emit(state.copyWith(selStatus: event.selStatus)),
    );

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

    on<PayCloseOrder>((event, emit) {
      int dis = 0;
      for (var i = 0; i < event.orders.products.length; i++) {
        dis +=
            (event.orders.products[i].fullCost - event.orders.products[i].cost)
                .toInt();
      }
      emit(state.copyWith(
        allPrice: event.orders.totalCost.toInt(),
        discount: dis,
        avans: event.orders.insertedValue.toInt(),
        isOrder: event.orders.id,
        username: event.orders.user.username,
      ));
    });

    on<CartAddOrder>((event, emit) async {
      emit(state.copyWith(aStatus: FormzSubmissionStatus.inProgress));
      add(CartRemove(isOrder: true));
      emit(state.copyWith(
        isOrder: event.orders.id,
        orders: event.orders,
        username: event.orders.user.username,
        avans: event.orders.prepaidAmount.toInt() == 0
            ? event.orders.insertedValue.toInt()
            : event.orders.prepaidAmount.toInt(),
        aStatus: FormzSubmissionStatus.success,
      ));
      List<int> list = event.orders.products.map((e) => e.product).toList();
      if (list.isNotEmpty) {
        for (var i = 0; i < list.length; i++) {
          final result = await productsId.call(list[i]);
          if (result.isRight) {
            final nima = ((event.orders.products[i].fullCost -
                        event.orders.products[i].cost) /
                    event.orders.products[i].fullCost) *
                100;
            if (event.orders.products[i].coupon.id != 0) {
              final cupon =
                  await cuponIDUse.call(event.orders.products[i].coupon.id);
              if (cupon.isRight) {
                add(CuponSel(cupon: cupon.right));
              }
            }
            if (event.orders.products[i].responsible.id != 0) {
              final cupon =
                  await cuponIDUse.call(event.orders.products[i].coupon.id);
              if (cupon.isRight) {
                add(CuponSel(cupon: cupon.right));
              }
            }
            try {
              Map<int, OrderProductEntity> map = {};
              map.addAll(state.cartMapDel);
              Log.e(result.right.id);
              if (!map.containsKey(result.right.id)) {
                Log.e("${result.right.id} Bu ifdan");
                add(CartAddMap(
                  result.right,
                  0,
                  discountPrice: event.orders.products[i].coupon.discount != 0
                      ? (event.orders.products[i].coupon.discount * (-1))
                          .toInt()
                      : (nima * (-1)).toInt(),
                  count: event.orders.products[i].qty,
                ));
              }
            } catch (e) {
              Log.e("Bu Cart log error $e");
              Map<int, OrderProductEntity> map = {};
              map.addAll(state.cartMapDel);
              if (!map.containsKey(result.right.id)) {
                add(CartAddMap(
                  result.right,
                  0,
                  discountPrice: 0,
                  count: event.orders.products[i].qty,
                ));
              }
            }
          } else {
            Log.e("Bu Cart bosh log");
            Map<int, OrderProductEntity> map = {};
            map.addAll(state.cartMapDel);
            final product = event.orders.products[i];
            if (!map.containsKey(product.id)) {
              map[product.id] = product;
              emit(state.copyWith(cartMapDel: map));
            }
          }
        }
        emit(state.copyWith(aStatus: FormzSubmissionStatus.success));
        event.onSuccess();
      } else {
        event.onError("Malumot topilmadi");
        emit(state.copyWith(aStatus: FormzSubmissionStatus.failure));
      }
    });

    on<CartAddRecommendation>((event, emit) async {
      int intParse(String id) {
        try {
          return int.parse(id);
        } catch (e) {
          return 0;
        }
      }

      emit(state.copyWith(aStatus: FormzSubmissionStatus.inProgress));
      List<int> list =
          event.products.map((e) => intParse(e.orgProductId)).toList();
      if (list.isNotEmpty) {
        for (var i = 0; i < list.length; i++) {
          final result = await productsId.call(list[i]);
          if (result.isRight) {
            if (!state.cartMap.containsKey(list[i])) {
              add(CartAddMap(
                result.right,
                0,
                discountPrice: 0,
                count: event.products[i].qty,
              ));
            }
          } else {
            Map<int, OrderProductEntity> map = {};
            map.addAll(state.cartMapDel);
            final product = event.products[i];

            if (!map.containsKey(intParse(product.orgProductId))) {
              map[product.id] = OrderProductEntity(
                id: product.id,
                qty: product.qty,
                name: product.product.name,
              );
              emit(state.copyWith(cartMapDel: map));
            }
          }
        }
        emit(state.copyWith(aStatus: FormzSubmissionStatus.success));
        event.onSuccess();
      } else {
        event.onError("Malumot topilmadi");
        emit(state.copyWith(aStatus: FormzSubmissionStatus.failure));
      }
    });

    on<CuponSel>((event, emit) => emit(state.copyWith(cupon: event.cupon)));

    on<RemoveCupon>(
        (event, emit) => emit(state.copyWith(cupon: const CuponModel())));

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
        info: event.filter.info,
        payments: event.filter.paymentinorderSet ??
            [
              {"method": 1, "cost": state.cupon.id != 0 ? state.discount : 0}
            ],
        couponId: event.isCupon
            ? state.cupon.title.isNotEmpty
                ? state.cupon.id
                : null
            : null,
        clientUsername: event.username,
      );
      final result = await useCase.call(params);
      if (result.isRight) {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
        event.onSuccess(result.right);
        add(CartRemove());
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
        if (result.left is ServerFailure) {
          event.onError((result.left as ServerFailure).errorMessage);
        } else {
          event.onError((result.left as DioFailure).hashCode.toString());
        }
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
        isCupon = MyFunctions.isCupon(state.cupon, event.product.id);
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
            cartMapDel: {},
            counts: [],
            allPrice: 0,
            discount: 0,
            cupon: const CuponModel(),
          ));
        } else {
          emit(state.copyWith(
            cartMap: {},
            cartMapDel: {},
            counts: [],
            allPrice: 0,
            discount: 0,
            avans: 0,
            cupon: const CuponModel(),
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

    // on<PatchPay>((event, emit) async {
    //   emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    //   final result = await patchPay.call(event.param);
    //   if (result.isRight) {
    //     emit(state.copyWith(status: FormzSubmissionStatus.success));
    //     event.onSuccess();
    //   } else {
    //     event.onError((result.left as ServerFailure).errorMessage);
    //     emit(state.copyWith(status: FormzSubmissionStatus.failure));
    //   }
    // });
  }
}
