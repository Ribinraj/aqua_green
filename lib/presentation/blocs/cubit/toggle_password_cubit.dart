import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'toggle_password_state.dart';

class TogglePasswordCubit extends Cubit<TogglePasswordState> {
  TogglePasswordCubit() : super(TogglePasswordInitial());
  void togglepassword() {
    if (state.isPasswordVisible) {
      emit(TogglePasswordInvisible());
    } else {
      emit(TogglePasswordVisible());
    }
  }
}
