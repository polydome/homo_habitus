import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homo_habitus/model/habit.dart';
import 'package:homo_habitus/model/habit_progress.dart';
import 'package:homo_habitus/model/habit_status.dart';
import 'package:homo_habitus/repository/habit_repository.dart';

part 'habit_preview_event.dart';

part 'habit_preview_state.dart';

class HabitPreviewBloc extends Bloc<HabitPreviewEvent, HabitPreviewState> {
  final HabitRepository habitRepository;

  HabitPreviewBloc(HabitStatus status, this.habitRepository)
      : super(HabitPreviewInitial.fromStatus(status)) {
    add(HabitPreviewInitialized());
  }

  @override
  Stream<HabitPreviewState> mapEventToState(
    HabitPreviewEvent event,
  ) async* {
    if (event is HabitPreviewInitialized) {
      final progress = habitRepository.getProgressByHabitId(state.habit.id);
      if (progress is TimerGoalProgress) {
        yield HabitPreviewTimerStopped(
            habit: state.habit,
            millisecondsPassed: progress.millisecondsPassed,
            targetMilliseconds: progress.targetMilliseconds);
      }
    }
  }
}