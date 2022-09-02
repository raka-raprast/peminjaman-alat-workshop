// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_hydrated_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryChangeState _$HistoryChangeStateFromJson(Map<String, dynamic> json) =>
    HistoryChangeState(
      history: (json['history'] as List<dynamic>)
          .map((e) => History.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HistoryChangeStateToJson(HistoryChangeState instance) =>
    <String, dynamic>{
      'history': instance.history,
    };

HistoryLoadingState _$HistoryLoadingStateFromJson(Map<String, dynamic> json) =>
    HistoryLoadingState();

Map<String, dynamic> _$HistoryLoadingStateToJson(
        HistoryLoadingState instance) =>
    <String, dynamic>{};
