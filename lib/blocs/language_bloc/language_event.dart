part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();
}

class LoadLanguage extends LanguageEvent {
  const LoadLanguage();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChangeLanguage extends LanguageEvent {
  const ChangeLanguage({required this.locate});
  final String locate;
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
