import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homo_habitus/domain/model/habit.dart';
import 'package:homo_habitus/domain/repository/habit_repository.dart';
import 'package:homo_habitus/domain/repository/progress_repository.dart';

part 'habit_preview_event.dart';

part 'habit_preview_state.dart';

class HabitPreviewBloc extends Bloc<HabitPreviewEvent, HabitPreviewState> {
  final ProgressRepository _progressRepository;

  HabitPreviewBloc(HabitRepository habitRepository, this._progressRepository,
      {required Habit initialHabit})
      : super(HabitPreviewState(initialHabit)) {
    habitRepository.watchHabit(initialHabit.id).listen((habit) {
      add(HabitChanged(habit));
    });
  }

  @override
  Stream<HabitPreviewState> mapEventToState(
    HabitPreviewEvent event,
  ) async* {
    final state = this.state;
    if (event is HabitPreviewCounterIncremented) {
      await _progressRepository.addProgress(state.habit.id, 1);
    } else if (event is HabitChanged) {
      yield HabitPreviewState(event.newHabit);
    }
  }
}
