import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigator_event.dart';
part 'navigator_state.dart';

class MyNavigatorBloc extends Bloc<MyNavigatorEvent, MyNavigatorState> {
  MyNavigatorBloc() : super(const MyNavigatorState()) {
    on<NavId>((event, emit) => emit(state.copyWith(navid: event.index)));
    on<OpenCart>(
      (event, emit) => emit(state.copyWith(openCart: event.openCart)),
    );
    on<IsImage>(
      (event, emit) => emit(state.copyWith(isImage: event.isImage)),
    );
    on<IsImageC>(
      (event, emit) => emit(state.copyWith(isImageC: event.isImage)),
    );
  }
}
