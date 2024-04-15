import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/features/common/user_type/user_type.dart';

part 'price_event.dart';

part 'price_state.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  PriceBloc() : super(const PriceState()) {
    on<InitPrice>((event, emit) => emit(state.copyWith(
          isPrice: UserType.getStorage != UserType.administration,
          userType: UserType.getStorage,
        )));
    on<ChangePrise>((event, emit) async {
      bool isPrice = !state.isPrice;
      emit(state.copyWith(isPrice: isPrice));
      await StorageRepository.putBool(StorageKeys.ISPRICE, isPrice);
    });
    on<ChangeUserType>((event, emit) {
      event.userType.putStorage();
      emit(state.copyWith(
        userType: event.userType,
        isPrice: event.userType != UserType.administration,
      ));
    });
  }
}
