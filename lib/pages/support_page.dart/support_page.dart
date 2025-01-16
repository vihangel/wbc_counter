import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wbc_counter/generated/l10n.dart';

class SupportPage extends StatelessWidget {
  SupportPage({
    super.key,
  });
  final S s = S();
  Future<void> _launchUrl(Uri uri) async {
    final urlLink = uri;

    ///await requestPermissions();
    if (await canLaunchUrl(urlLink)) {
      await launchUrl(urlLink);
    } else {
      throw '${s.couldNotLaunch} $urlLink';
    }
  }

  ///REVIEW: This method is not used because was getting an exception and maybe is not required to open url links
  Future<void> requestPermissions() async {
    ///verify if the user has permission to send sms and make calls

    final status = await Permission.sms.request();
    final callStatus = await Permission.phone.request();

    if (status.isGranted && callStatus.isGranted) {
    } else {
      throw s.couldNotLaunch;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).support),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              S.of(context).supportOurProject,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),

            ///Check if is IOS because store block the donation options
            if (!Platform.isIOS) ...[
              Text(
                S.of(context).optionsToSupport,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // List donation options with links
              ListTile(
                leading: const Icon(Icons.coffee),
                title: Text(S.of(context).buyMeACoffe),
                onTap: () => _launchUrl(
                  Uri(
                      scheme: 'https',
                      host: 'www.buymeacoffee.com',
                      path: 'vihangel'),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.qr_code),
                title: Text('${S.of(context).pixKey}: 5565992328339'),
              ),

              const SizedBox(height: 32),
              Text(
                S.of(context).whySupport,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],

            // Explain why support matters
            Text(
              S.of(context).explainWhySupport,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 32),
            Text(
              S.of(context).contactUs,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Provide contact information
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              onTap: () => _launchUrl(Uri(
                scheme: 'mailto',
                path: 'vitoria.angel2002@gmail.com',
              )),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Instagram'),
              onTap: () => _launchUrl(
                Uri(
                    scheme: 'https',
                    host: 'www.instagram.com',
                    path: 'vih.angel/'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('LinkedIn'),
              onTap: () => _launchUrl(
                Uri(
                    scheme: 'https',
                    host: 'www.linkedin.com',
                    path:
                        'in/vitoria-angel-silva-%F0%9F%8F%B3%EF%B8%8F%E2%80%8D%F0%9F%8C%88%F0%9F%8F%B3%EF%B8%8F%E2%80%8D%E2%9A%A7%EF%B8%8F-130003196/'),
              ),
            ),

            const SizedBox(height: 32),
            Text(
              S.of(context).thanks,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              S.of(context).thanksMessage,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
