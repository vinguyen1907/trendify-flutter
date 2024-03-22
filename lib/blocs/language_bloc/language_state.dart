part of 'language_bloc.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();
}

class LanguageInitial extends LanguageState {
  @override
  List<Object> get props => [];
}

class LanguageLoaded extends LanguageState {
  final String locale;

  const LanguageLoaded({required this.locale});
  @override
  List<Object> get props => [locale];
}

class LanguageLoading extends LanguageState {
  @override
  List<Object> get props => [];
}
