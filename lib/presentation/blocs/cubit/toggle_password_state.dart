part of 'toggle_password_cubit.dart';

@immutable
sealed class TogglePasswordState {
  final bool isPasswordVisible;

 const TogglePasswordState({required this.isPasswordVisible});
}

final class TogglePasswordInitial extends TogglePasswordState {
  const TogglePasswordInitial():super(isPasswordVisible:false);
}
final class TogglePasswordVisible extends TogglePasswordState {
  const TogglePasswordVisible():super(isPasswordVisible:true);
}
final class TogglePasswordInvisible extends TogglePasswordState {
  const TogglePasswordInvisible():super(isPasswordVisible:false);
}