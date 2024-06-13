part of 'language_bloc.dart';

class LanguageState extends Equatable {
  final LanguageData languageData;
  const LanguageState(this.languageData) : assert(languageData != null);

  @override
  List<Object> get props => [languageData];
}