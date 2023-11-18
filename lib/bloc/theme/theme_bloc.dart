import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeAppBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeAppBloc() : super(const ThemeChangedState(ThemeMode.light)) {
    on<ToggleThemeEvent>((event, emit) => _mapToggleThemeToState(event, emit));
  }

  ThemeMode theme = ThemeMode.light;

  void _mapToggleThemeToState(event, emit) async {
    if (theme == ThemeMode.light) {
      theme = ThemeMode.dark;
    } else {
      theme = ThemeMode.light;
    }
    emit(ThemeChangedState(theme));
  }
}
