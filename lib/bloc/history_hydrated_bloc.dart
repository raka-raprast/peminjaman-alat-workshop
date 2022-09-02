// ignore_for_file: unnecessary_this, prefer_const_constructors, prefer_const_literals_to_create_immutables, overridden_fields, annotate_overrides

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

import '../model/history.dart';

part 'history_hydrated_bloc.g.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class HistoryAddEvent extends HistoryEvent {
  final List<History> history;

  const HistoryAddEvent(this.history);

  @override
  List<Object> get props => [history];
}

class HistoryUpdateEvent extends HistoryEvent {
  final History history;

  const HistoryUpdateEvent(this.history);

  @override
  List<Object> get props => [history];
}

class HistoryCheckEvent extends HistoryEvent {
  @override
  List<Object> get props => [];
}

abstract class HistoryState extends Equatable {
  final List<History> history;

  const HistoryState({required this.history});

  @override
  List<Object> get props => [history];
}

@JsonSerializable()
class HistoryChangeState extends HistoryState {
  final List<History> history;

  const HistoryChangeState({required this.history}) : super(history: history);

  @override
  List<Object> get props => [history];

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory HistoryChangeState.fromJson(Map<String, dynamic> json) =>
      _$HistoryChangeStateFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson(HistoryChangeState state) =>
      _$HistoryChangeStateToJson(state);
}

@JsonSerializable()
class HistoryLoadingState extends HistoryState {
  HistoryLoadingState() : super(history: []);

  @override
  List<Object> get props => [];

  @override

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory HistoryLoadingState.fromJson(Map<String, dynamic> json) =>
      _$HistoryLoadingStateFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson(HistoryLoadingState state) =>
      _$HistoryLoadingStateToJson(state);
}

class HistoryHydratedBloc extends HydratedBloc<HistoryEvent, HistoryState> {
  HistoryHydratedBloc() : super(HistoryChangeState(history: [])) {
    on<HistoryAddEvent>(_add);
    on<HistoryCheckEvent>(_check);
    on<HistoryUpdateEvent>(_update);
  }

  void _add(HistoryAddEvent event, Emitter<HistoryState> emit) {
    var term = event.history;
    log("length = ${state.history.length}");
    emit(HistoryLoadingState());
    emit(HistoryChangeState(history: term));
  }

  void _update(HistoryUpdateEvent event, Emitter<HistoryState> emit) {
    var term = event.history;
    var current = state.history;
    DateTime time = DateTime.now();
    // current.removeWhere((e) => e.id == term.id);
    // current.add(History(
    //     borrowTime: term.borrowTime,
    //     returnTime: time.toString(),
    //     borrowedItemQty: term.borrowedItemQty,
    //     status: "Returned",
    //     id: term.id));
    emit(HistoryLoadingState());
    emit(HistoryChangeState(history: current));
  }

  void _check(HistoryCheckEvent event, Emitter<HistoryState> emit) {
    var current = this.state.history;
    if (current.isEmpty) {
      current = [];
    }
    log("history length = ${current.length}");
    log(current.length.toString());
    emit(HistoryLoadingState());
    emit(HistoryChangeState(history: current));
  }

  @override
  HistoryState fromJson(Map<String, dynamic> json) =>
      _$HistoryChangeStateFromJson(json);

  @override
  Map<String, dynamic> toJson(HistoryState state) {
    if (state is HistoryLoadingState) {
      return _$HistoryLoadingStateToJson(state);
    } else {
      return _$HistoryChangeStateToJson(state as HistoryChangeState);
    }
  }
}
