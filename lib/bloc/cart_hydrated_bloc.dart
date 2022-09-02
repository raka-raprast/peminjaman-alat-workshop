// ignore_for_file: unnecessary_this, prefer_const_constructors, prefer_const_literals_to_create_immutables, overridden_fields, annotate_overrides

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

import '../model/cart.dart';

part 'cart_hydrated_bloc.g.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartAddEvent extends CartEvent {
  final List<Cart> cart;

  const CartAddEvent(this.cart);

  @override
  List<Object> get props => [cart];
}

class CartClearEvent extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartCheckEvent extends CartEvent {
  @override
  List<Object> get props => [];
}

abstract class CartState extends Equatable {
  final List<Cart> cart;

  const CartState({required this.cart});

  @override
  List<Object> get props => [cart];
}

@JsonSerializable()
class CartChangeState extends CartState {
  final List<Cart> cart;

  const CartChangeState({required this.cart}) : super(cart: cart);

  @override
  List<Object> get props => [cart];

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory CartChangeState.fromJson(Map<String, dynamic> json) =>
      _$CartChangeStateFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson(CartChangeState state) =>
      _$CartChangeStateToJson(state);
}

@JsonSerializable()
class CartLoadingState extends CartState {
  CartLoadingState() : super(cart: []);

  @override
  List<Object> get props => [];

  @override

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory CartLoadingState.fromJson(Map<String, dynamic> json) =>
      _$CartLoadingStateFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson(CartLoadingState state) =>
      _$CartLoadingStateToJson(state);
}

class CartHydratedBloc extends HydratedBloc<CartEvent, CartState> {
  CartHydratedBloc() : super(CartChangeState(cart: [])) {
    on<CartAddEvent>(_add);
    on<CartCheckEvent>(_check);
    on<CartClearEvent>(_clear);
  }

  void _add(CartAddEvent event, Emitter<CartState> emit) {
    var term = event.cart;
    emit(CartLoadingState());
    emit(CartChangeState(cart: term));
  }

  void _clear(CartClearEvent event, Emitter<CartState> emit) {
    emit(CartLoadingState());
    emit(CartChangeState(cart: []));
  }

  void _check(CartCheckEvent event, Emitter<CartState> emit) {
    var current = this.state.cart;
    if (current.isEmpty) {
      current = [];
    }
    log(current.length.toString());
    emit(CartLoadingState());
    emit(CartChangeState(cart: current));
  }

  @override
  CartState fromJson(Map<String, dynamic> json) =>
      _$CartChangeStateFromJson(json);

  @override
  Map<String, dynamic> toJson(CartState state) {
    if (state is CartLoadingState) {
      return _$CartLoadingStateToJson(state);
    } else {
      return _$CartChangeStateToJson(state as CartChangeState);
    }
  }
}
