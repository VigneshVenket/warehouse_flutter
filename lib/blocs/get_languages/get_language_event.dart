part of 'get_language_bloc.dart';

abstract class GetLanguageEvent extends Equatable {
  const GetLanguageEvent();
}

class GetLanguages extends GetLanguageEvent {
  const GetLanguages();

  @override
  List<Object> get props => [];
}
