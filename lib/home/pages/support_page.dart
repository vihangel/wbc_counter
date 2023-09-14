import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({
    super.key,
  });

  Future<void> _launchUrl(Uri uri) async {
    final urlLink = uri;
    requestPermissions();
    if (await canLaunchUrl(urlLink)) {
      await launchUrl(urlLink);
    } else {
      throw 'Could not launch $urlLink';
    }
  }

  Future<void> requestPermissions() async {
    ///verify if the user has permission to send sms and make calls

    final status = await Permission.sms.request();
    final callStatus = await Permission.phone.request();

    if (status.isGranted && callStatus.isGranted) {
    } else {
      throw 'Could not launch';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apoie'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Apoie o Nosso Projeto!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Opções de Apoio',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            // List donation options with links
            ListTile(
              leading: const Icon(Icons.coffee),
              title: const Text('Compre um Café'),
              onTap: () => _launchUrl(
                Uri(
                    scheme: 'https',
                    host: 'www.buymeacoffee.com',
                    path: 'vihangel'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('Doação via PIX'),
              onTap: () {
                // Add code to display PIX instructions or information
              },
            ),
            // Include more donation options as needed

            const SizedBox(height: 32),
            const Text(
              'Por que Apoiar?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Explain why support matters
            const Text(
              'O seu apoio nos ajuda a continuar desenvolvendo e melhorando nosso aplicativo. Com sua ajuda, podemos oferecer atualizações regulares, novos recursos e garantir que o aplicativo continue gratuito para todos os usuários. Obrigado por apoiar nossa missão!',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 32),
            const Text(
              'Entre em Contato',
              style: TextStyle(
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
                path:
                    'vitoria.angel2002@gmail.com', // Replace with your email address
              )),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Instagram'),
              onTap: () => _launchUrl(
                Uri(
                    scheme: 'https',
                    host:
                        'www.instagram.com', // Replace with your Instagram url
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
            const Text(
              'Mensagem de Agradecimento',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Agradecemos por usar nosso aplicativo e por considerar apoiar nosso trabalho. Sua contribuição é fundamental para nosso sucesso contínuo. Se você tiver alguma dúvida ou sugestão, não hesite em entrar em contato conosco. Juntos, podemos fazer a diferença!',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
            // Add more sections as needed
          ],
        ),
      ),
    );
  }
}
