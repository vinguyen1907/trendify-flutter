import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    on<LoadLanguage>(_onLoadLanguage);
    on<ChangeLanguage>(_onChangeLanguage);
  }

  FutureOr<void> _onLoadLanguage(
      LoadLanguage event, Emitter<LanguageState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String locate = prefs.getString('locate') ?? 'en';
    emit(LanguageLoaded(locale: locate));
  }

  FutureOr<void> _onChangeLanguage(
      ChangeLanguage event, Emitter<LanguageState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('locate', event.locate);
    emit(LanguageLoaded(locale: event.locate));
  }
}
