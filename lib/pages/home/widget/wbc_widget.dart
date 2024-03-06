import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wbc_counter/bloc/theme/theme_bloc.dart';

class WBCQuantityWidget extends StatelessWidget {
  final String name;
  final int quantity;
  final String imagePath;
  final bool isAdicionarMode;
  final ValueChanged<int> onUpdateQuantity;

  const WBCQuantityWidget({
    super.key,
    required this.name,
    required this.quantity,
    required this.isAdicionarMode,
    required this.onUpdateQuantity,
    required this.imagePath,
  });

  Future<void> _onTap() async {
    final prefs = await SharedPreferences.getInstance();
    if (isAdicionarMode) {
      onUpdateQuantity(quantity + 1);
    } else {
      if (quantity > 0) {
        onUpdateQuantity(quantity - 1);
      }
    }
    if (prefs.getBool('isVibrationEnabled') ?? true) {
      HapticFeedback.vibrate();
    }
    if (prefs.getBool('isSoundEnabled') ?? true) {
      // Permission.audio.request();
      await SystemSound.play(SystemSoundType.click);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Container(
        width: _horizontalSize(context),
        decoration: BoxDecoration(
          color: context.read<ThemeAppBloc>().theme == ThemeMode.light
              ? Colors.white
              : const Color.fromARGB(255, 42, 42, 42),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding:
            const EdgeInsets.only(top: 0, bottom: 8.0, left: 8.0, right: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(8.0),
              ),
              width: double.infinity,
              child: Text(
                '$quantity',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                width: 90,
                height: 90,
                child: Image.asset(
                  'assets/cells/$imagePath',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              name,
              maxLines: 1,
              style: const TextStyle(),
            ),
          ],
        ),
      ),
    );
  }

  double _horizontalSize(BuildContext context) {
    /// 16.0 is the padding of the container
    /// I want 3 in a line and can be divided by 3
    /// size cant be less than 90
    final size = (MediaQuery.of(context).size.width - 16.0 * 4) / 3;
    return size < 90 ? 90 : size;
  }
}
