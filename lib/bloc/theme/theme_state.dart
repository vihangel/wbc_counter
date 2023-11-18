part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object?> get props => [];
}

class ThemeChangedState extends ThemeState {
  final ThemeMode themeData;

  const ThemeChangedState(this.themeData);

  @override
  List<Object> get props => [themeData];
}
