part of 'story_cubit.dart';

sealed class StoryState extends Equatable {
  const StoryState();

  @override
  List<Object> get props => [];
}

final class StoryInitial extends StoryState {}

class StoryLoaded extends StoryState {
  final List<StoryModel> stories;
  const StoryLoaded({required this.stories});
}

class StoryError extends StoryState {
  final String message;
  const StoryError({required this.message});
}

class StoryLoading extends StoryState {}
