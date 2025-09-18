import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeAppBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeAppBloc() : super(const ThemeChangedState(ThemeMode.light)) {
    on<ToggleThemeEvent>((event, emit) => _mapToggleThemeToState(event, emit));
  }

  ThemeMode theme = ThemeMode.light;

  Future<void> _mapToggleThemeToState(
      ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    theme = theme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(ThemeChangedState(theme));
  }
}
