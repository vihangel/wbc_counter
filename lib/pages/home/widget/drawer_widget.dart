import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:wbc_counter/config/config_page.dart';
import 'package:wbc_counter/generated/l10n.dart';
import 'package:wbc_counter/local_reports/local_reports_page.dart';
import 'package:wbc_counter/pages/support_page.dart/support_page.dart';

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
            title: Text(S.of(context).savedReports),
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
            title: Text(S.of(context).about),
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
            title: Text(S.of(context).rateUs),
            onTap: () {
              Navigator.pop(context);
              _showAppStoreAlert(context);
            },
          ),
          const Spacer(),
          SafeArea(
            child: ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: Text(S.of(context).settings),
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
          title: Text(S.of(context).appEvaluation),
          content: Text(
            '${S.of(context).likeTheApp}\n ${S.of(context).leaveAReview}\n\n ${S.of(context).itHelpsALot}',
            // textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).later),
            ),
            ElevatedButton(
              onPressed: () {
                final InAppReview inAppReview = InAppReview.instance;
                // TODO: implement openStoreListing
                inAppReview.openStoreListing(
                  appStoreId: '...',
                );
              },
              child: Text(S.of(context).openStore),
            ),
          ],
        );
      },
    );
  }
}
