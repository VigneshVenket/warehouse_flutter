part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeLoadStarted extends ThemeEvent {}

class ThemeColorChanged extends ThemeEvent {
  final int selectedIndex;

  const ThemeColorChanged(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}

class ThemeModeChanged extends ThemeEvent {
  final bool isDark;

  const ThemeModeChanged(this.isDark);

  @override
  List<Object> get props => [isDark];
}
