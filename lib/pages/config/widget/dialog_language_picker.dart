import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wbc_counter/generated/l10n.dart';

class DialogPicker extends StatelessWidget {
  final List<LanguageOption> languageOptions;
  final Function(String) onSelectLanguage;

  const DialogPicker(
      {super.key,
      required this.languageOptions,
      required this.onSelectLanguage});

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).selectLanguage),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: languageOptions.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: SvgPicture.asset(languageOptions[index].flagAsset,
                      width: 30, height: 20),
                  title: Text(languageOptions[index].languageName),
                  onTap: () {
                    onSelectLanguage(languageOptions[index].languageCode);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDialog(context),
      child: Container(),
    );
  }
}

class LanguageOption {
  final String languageCode;
  final String languageName;
  final String flagAsset;

  LanguageOption(this.languageCode, this.languageName, this.flagAsset);
}
