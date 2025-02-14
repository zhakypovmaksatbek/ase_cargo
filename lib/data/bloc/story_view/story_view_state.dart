part of 'story_view_cubit.dart';

sealed class StoryViewState extends Equatable {
  const StoryViewState();

  @override
  List<Object> get props => [];
}

final class StoryViewInitial extends StoryViewState {}

final class StoryViewLoading extends StoryViewState {}

final class StoryViewSuccess extends StoryViewState {
  final int storyId;
  final String response;
  const StoryViewSuccess({required this.storyId, required this.response});
}

final class StoryViewError extends StoryViewState {
  final String message;
  const StoryViewError({required this.message});
}
