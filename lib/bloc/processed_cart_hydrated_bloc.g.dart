// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'processed_cart_hydrated_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessedCartChangeState _$ProcessedCartChangeStateFromJson(
        Map<String, dynamic> json) =>
    ProcessedCartChangeState(
      processedCart: (json['processedCart'] as List<dynamic>)
          .map((e) => ProcessedCart.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProcessedCartChangeStateToJson(
        ProcessedCartChangeState instance) =>
    <String, dynamic>{
      'processedCart': instance.processedCart,
    };

ProcessedCartLoadingState _$ProcessedCartLoadingStateFromJson(
        Map<String, dynamic> json) =>
    ProcessedCartLoadingState();

Map<String, dynamic> _$ProcessedCartLoadingStateToJson(
        ProcessedCartLoadingState instance) =>
    <String, dynamic>{};
