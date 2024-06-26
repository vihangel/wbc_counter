import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wbc_counter/pages/ia_help/ia_help_page.dart';
import 'package:wbc_counter/pages/tips/tips_page.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const AppBarWidget({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
      ),
      title: SvgPicture.asset(
        'assets/logo.svg',
        colorFilter: const ColorFilter.mode(Colors.deepPurple, BlendMode.srcIn),
        height: 32,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.help_outline),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TipsPage(),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.camera_alt_outlined),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AiHelpPage(),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
