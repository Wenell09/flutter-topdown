part of 'navigation_bloc.dart';

sealed class NavigationEvent extends Equatable {}

class ChangeNavigation extends NavigationEvent {
  final int index;
  ChangeNavigation({required this.index});
  @override
  List<Object?> get props => [index];
}
