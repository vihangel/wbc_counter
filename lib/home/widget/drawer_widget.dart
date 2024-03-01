import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:wbc_counter/config/config_page.dart';
import 'package:wbc_counter/local_reports/local_reports_page.dart';
import 'package:wbc_counter/support_page.dart/support_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/logo.svg',
                height: 50,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.save_alt_outlined),
            title: const Text('Relatórios Salvos'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LocalReportPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.monetization_on_outlined),
            title: const Text('Sobre'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SupportPage(),
                ),
              );
              // Handle Apoie
            },
          ),
          ListTile(
            leading: const Icon(Icons.star_border_outlined),
            title: const Text('Avalie'),
            onTap: () {
              Navigator.pop(context);
              _showAppStoreAlert(context);
            },
          ),
          const Spacer(),
          SafeArea(
            child: ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ConfigPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAppStoreAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Avalie o App'),
          content: const Text(
            'Está gostando do app?\nDeixe uma avaliação na loja!\n\nIsso ajuda muito!',
            // textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Depois'),
            ),
            ElevatedButton(
              onPressed: () {
                final InAppReview inAppReview = InAppReview.instance;
                // TODO: implement openStoreListing
                inAppReview.openStoreListing(
                  appStoreId: '...',
                );
              },
              child: const Text('Abrir Loja'),
            ),
          ],
        );
      },
    );
  }
}
