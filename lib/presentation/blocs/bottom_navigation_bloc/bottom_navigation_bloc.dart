import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(BottomNavigationInitial()) {
    on<BottomNavigationEvent>((event, emit) {});
    on<NavigateToPageEvent>(navigatetoPage);
       on<LockNavigationEvent>(lockNavigation);
  }

  FutureOr<void> navigatetoPage(NavigateToPageEvent event, Emitter<BottomNavigationState> emit) {
    if (!state.isLocked) {
      emit(NavigationState(currentPageIndex: event.pageIndex,isLocked: state.isLocked));
    }
    
  }
    FutureOr<void> lockNavigation(
    LockNavigationEvent event, 
    Emitter<BottomNavigationState> emit
  ) {
    emit(NavigationState(
      currentPageIndex: state.currentPageIndex,
      isLocked: event.isLocked,
    ));
  }
}
