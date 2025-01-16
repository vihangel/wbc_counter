import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wbc_counter/bloc/cell%20count/cell_count_bloc.dart';
import 'package:wbc_counter/generated/l10n.dart';

class TotalCountRowWidget extends StatelessWidget {
  final int totalWbcCount;
  const TotalCountRowWidget(this.totalWbcCount, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${S.of(context).total}: $totalWbcCount',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
            onPressed: () => _clearAllValues(context, totalWbcCount),
            child: Text(
              S.of(context).clearAll,
            )),
      ],
    );
  }

  void _clearAllValues(BuildContext context, int wbcQuantities) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).clearValues),
          content: Text(S.of(context).msg_confirmClearAllValues),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).cancel),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CellCountBloc>().add(CellCountResetEvent());
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).confirm,
                  style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
