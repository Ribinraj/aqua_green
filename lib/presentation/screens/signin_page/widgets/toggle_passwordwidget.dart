import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/presentation/blocs/cubit/toggle_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget togglePassword() {
  return BlocBuilder<TogglePasswordCubit, TogglePasswordState>(
    builder: (context, state) {
      return InkWell(
        onTap: () {
          context.read<TogglePasswordCubit>().togglepassword();
        },
        child: Icon(
          state.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          color: Appcolors.kprimarycolor,
        ),
      );
    },
  );
}
