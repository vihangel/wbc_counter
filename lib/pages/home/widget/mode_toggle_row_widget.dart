import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wbc_counter/bloc/cell%20count/cell_count_bloc.dart';
import 'package:wbc_counter/bloc/theme/theme_bloc.dart';
import 'package:wbc_counter/generated/l10n.dart';

class ModeToggleRowWidget extends StatelessWidget {
  final bool isAdicionarMode;

  const ModeToggleRowWidget({super.key, required this.isAdicionarMode});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '${S.of(context).mode}:',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: !isAdicionarMode ? Colors.white : null,
            ),
            onPressed: () => toggleMode(context, true),
            child: Text(S.of(context).add,
                style: TextStyle(
                    color: isAdicionarMode
                        ? context.read<ThemeAppBloc>().theme == ThemeMode.light
                            ? Colors.white
                            : const Color.fromARGB(255, 42, 42, 42)
                        : null)),
          ),
          const SizedBox(
            width: 16.0,
          ),

          ///Remove button

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isAdicionarMode ? Colors.white : null,
            ),
            onPressed: () => toggleMode(context, false),
            child: Text(S.of(context).remove,
                style: TextStyle(
                    color: !isAdicionarMode
                        ? context.read<ThemeAppBloc>().theme == ThemeMode.light
                            ? Colors.white
                            : const Color.fromARGB(255, 42, 42, 42)
                        : null)),
          ),
        ],
      ),
    ]);
  }

  void toggleMode(BuildContext context, bool toggleMode) {
    context
        .read<CellCountBloc>()
        .add(IsAddModeChangeEvent(isAddMode: toggleMode));
  }
}
