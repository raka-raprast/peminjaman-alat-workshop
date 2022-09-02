// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_hydrated_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartChangeState _$CartChangeStateFromJson(Map<String, dynamic> json) =>
    CartChangeState(
      cart: (json['cart'] as List<dynamic>)
          .map((e) => Cart.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartChangeStateToJson(CartChangeState instance) =>
    <String, dynamic>{
      'cart': instance.cart,
    };

CartLoadingState _$CartLoadingStateFromJson(Map<String, dynamic> json) =>
    CartLoadingState();

Map<String, dynamic> _$CartLoadingStateToJson(CartLoadingState instance) =>
    <String, dynamic>{};
