part of 'get_language_bloc.dart';

abstract class GetLanguageState extends Equatable {
  const GetLanguageState();
}

class GetLanguageInitial extends GetLanguageState {
  const GetLanguageInitial();

  @override
  List<Object> get props => [];
}

class GetLanguageLoading extends GetLanguageState {
  const GetLanguageLoading();

  @override
  List<Object> get props => [];
}

class GetLanguageLoaded extends GetLanguageState {
  final LanguagesResponse languageResponse;

  const GetLanguageLoaded(this.languageResponse);

  @override
  List<Object> get props => [languageResponse];
}

class GetLanguageError extends GetLanguageState {
  final String error;

  const GetLanguageError(this.error);

  @override
  List<Object> get props => [error];
}
