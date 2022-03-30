import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(InitialCounter()) {

    //event -> bloc
    on<IncrementCounter>((event, emit) {
      emit(CounterChanged(newNumber: state.number + 1));
    });

    on<DecrementCounter>((event, emit) {
      emit(CounterChanged(newNumber: state.number - 1));
    });

  }
}
