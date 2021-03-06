part of 'habit_creator_bloc.dart';

abstract class HabitCreatorEvent extends Equatable {
  const HabitCreatorEvent();
}

class HabitCreatorNameChanged extends HabitCreatorEvent {
  final String name;

  const HabitCreatorNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class HabitCreatorCounterChanged extends HabitCreatorEvent {
  final int value;

  const HabitCreatorCounterChanged(this.value);

  @override
  List<Object> get props => [value];
}

class HabitCreatorTimerHoursChanged extends HabitCreatorEvent {
  final int hours;

  const HabitCreatorTimerHoursChanged(this.hours);

  @override
  List<Object> get props => [hours];
}

class HabitCreatorTimerMinutesChanged extends HabitCreatorEvent {
  final int minutes;

  const HabitCreatorTimerMinutesChanged(this.minutes);

  @override
  List<Object> get props => [minutes];
}

class HabitCreatorGoalChanged extends HabitCreatorEvent {
  final GoalType goalType;

  const HabitCreatorGoalChanged(this.goalType);

  @override
  List<Object> get props => [goalType];
}

class HabitCreatorDeadlineChanged extends HabitCreatorEvent {
  final Deadline deadline;

  const HabitCreatorDeadlineChanged(this.deadline);

  @override
  List<Object> get props => [deadline];
}

class HabitCreatorIconChanged extends HabitCreatorEvent {
  final IconAsset icon;

  const HabitCreatorIconChanged(this.icon);

  @override
  List<Object> get props => [icon];
}

class HabitCreatorSubmitted extends HabitCreatorEvent {
  @override
  List<Object> get props => [];
}
