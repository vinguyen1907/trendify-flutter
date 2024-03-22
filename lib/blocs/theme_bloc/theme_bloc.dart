import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(themeMode: ThemeMode.light)) {
    on<LoadTheme>(_onLoadTheme);
    on<ChangeTheme>(_onChangeTheme);
  }

  _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    try {
      final bool isDark = await Utils().getDarkMode();
      final ThemeMode themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      emit(ThemeState(themeMode: themeMode));
    } catch (e) {
      emit(const ThemeState(themeMode: ThemeMode.light));
    }
  }

  _onChangeTheme(ChangeTheme event, Emitter<ThemeState> emit) {
    emit(ThemeState(themeMode: event.themeMode));
    Utils().changeDarkMode();
  }
}
