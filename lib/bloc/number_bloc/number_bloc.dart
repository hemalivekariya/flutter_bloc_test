import 'package:flutter_bloc/flutter_bloc.dart';

import 'number.dart';

class NumberBloc extends Bloc<NumberEvent, NumberState> {
  NumberBloc() : super(InitialNumber()) {
    on<IncrementNumber>((event, emit) {
      emit(NumberChanged(newNumber: state.number + 1));
    });
    on<DecrementNumber>((event, emit) {
      emit(NumberChanged(newNumber: state.number - 1));
    });
  }
}
