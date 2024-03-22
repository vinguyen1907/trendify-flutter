import 'package:ecommerce_app/blocs/theme_bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ContextExt on BuildContext {
  bool get isDarkMode => read<ThemeBloc>().state.themeMode == ThemeMode.dark;
}
