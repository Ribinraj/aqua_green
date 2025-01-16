part of 'bottom_navigation_bloc.dart';

@immutable
sealed class BottomNavigationState {
  final int currentPageIndex;
   final bool isLocked;
  const BottomNavigationState({required this.currentPageIndex,required this.isLocked});
}

final class BottomNavigationInitial extends BottomNavigationState {
  const BottomNavigationInitial() : super(currentPageIndex: 0,isLocked: false);
}
class NavigationState extends BottomNavigationState {
  const NavigationState({required super.currentPageIndex,required super.isLocked});
}