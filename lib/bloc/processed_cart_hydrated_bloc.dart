// ignore_for_file: unnecessary_this, prefer_const_constructors, prefer_const_literals_to_create_immutables, overridden_fields, annotate_overrides

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

import '../model/processed_cart.dart';

part 'processed_cart_hydrated_bloc.g.dart';

abstract class ProcessedCartEvent extends Equatable {
  const ProcessedCartEvent();

  @override
  List<Object> get props => [];
}

class ProcessedCartAddEvent extends ProcessedCartEvent {
  final List<ProcessedCart> processedCart;

  const ProcessedCartAddEvent(this.processedCart);

  @override
  List<Object> get props => [processedCart];
}

class ProcessedCartCheckEvent extends ProcessedCartEvent {
  @override
  List<Object> get props => [];
}

abstract class ProcessedCartState extends Equatable {
  final List<ProcessedCart> processedCart;

  const ProcessedCartState({required this.processedCart});

  @override
  List<Object> get props => [processedCart];
}

@JsonSerializable()
class ProcessedCartChangeState extends ProcessedCartState {
  final List<ProcessedCart> processedCart;

  const ProcessedCartChangeState({required this.processedCart})
      : super(processedCart: processedCart);

  @override
  List<Object> get props => [processedCart];

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory ProcessedCartChangeState.fromJson(Map<String, dynamic> json) =>
      _$ProcessedCartChangeStateFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson(ProcessedCartChangeState state) =>
      _$ProcessedCartChangeStateToJson(state);
}

@JsonSerializable()
class ProcessedCartLoadingState extends ProcessedCartState {
  ProcessedCartLoadingState() : super(processedCart: []);

  @override
  List<Object> get props => [];

  @override

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory ProcessedCartLoadingState.fromJson(Map<String, dynamic> json) =>
      _$ProcessedCartLoadingStateFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson(ProcessedCartLoadingState state) =>
      _$ProcessedCartLoadingStateToJson(state);
}

class ProcessedCartHydratedBloc
    extends HydratedBloc<ProcessedCartEvent, ProcessedCartState> {
  ProcessedCartHydratedBloc()
      : super(ProcessedCartChangeState(processedCart: [])) {
    on<ProcessedCartAddEvent>(_add);
    on<ProcessedCartCheckEvent>(_check);
  }

  void _add(ProcessedCartAddEvent event, Emitter<ProcessedCartState> emit) {
    var term = event.processedCart;
    emit(ProcessedCartLoadingState());
    emit(ProcessedCartChangeState(processedCart: term));
  }

  void _clear(ProcessedCartAddEvent event, Emitter<ProcessedCartState> emit) {
    emit(ProcessedCartLoadingState());
    emit(ProcessedCartChangeState(processedCart: []));
  }

  void _check(ProcessedCartCheckEvent event, Emitter<ProcessedCartState> emit) {
    var current = this.state.processedCart;
    if (current.isEmpty) {
      current = [];
    }
    log(current.length.toString());
    emit(ProcessedCartLoadingState());
    emit(ProcessedCartChangeState(processedCart: current));
  }

  @override
  ProcessedCartState fromJson(Map<String, dynamic> json) =>
      _$ProcessedCartChangeStateFromJson(json);

  @override
  Map<String, dynamic> toJson(ProcessedCartState state) {
    if (state is ProcessedCartLoadingState) {
      return _$ProcessedCartLoadingStateToJson(state);
    } else {
      return _$ProcessedCartChangeStateToJson(
          state as ProcessedCartChangeState);
    }
  }
}
