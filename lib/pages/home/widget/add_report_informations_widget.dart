import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wbc_counter/bloc/theme/theme_bloc.dart';
import 'package:wbc_counter/generated/l10n.dart';
import 'package:wbc_counter/pages/home/model/report_image_model.dart';

class AddReportInformations extends StatelessWidget {
  final List<ReportImageModel> images;
  final bool onlyShow;
  final Function(ReportImageModel)? onAddImage;
  final Function(int)? onRemoveImage;
  final Function(int, String, String)? onUpdateImageData;

  const AddReportInformations({
    super.key,
    required this.images,
    this.onAddImage,
    this.onRemoveImage,
    this.onUpdateImageData,
    this.onlyShow = false,
  });

  Future<void> _pickImage(BuildContext context) async {
    if (onlyShow) return;

    final picker = ImagePicker();
    final translations = S.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      useSafeArea: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: Text(translations.takePhoto),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                      onAddImage!(
                        ReportImageModel(imagePath: File(pickedFile.path).path),
                      );
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: Text(translations.chooseFromGallery),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      onAddImage!(
                        ReportImageModel(imagePath: File(pickedFile.path).path),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final translations = S.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            translations.findingsForReport,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            runAlignment: WrapAlignment.start,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              if (!onlyShow)
                GestureDetector(
                  onTap: () => _pickImage(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          context.read<ThemeAppBloc>().theme == ThemeMode.light
                              ? Colors.white
                              : const Color.fromARGB(255, 42, 42, 42),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    height: 200,
                    width: 110,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: 40,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          translations.addImages,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (images.isNotEmpty)
                ...List.generate(
                  images.length,
                  (index) {
                    final data = images[index];
                    return GestureDetector(
                      onTap: () => onlyShow
                          ? _showExpanded(context, data)
                          : _showEditDialog(context, index, data),
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.read<ThemeAppBloc>().theme ==
                                  ThemeMode.light
                              ? Colors.white
                              : const Color.fromARGB(255, 42, 42, 42),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        height: 200,
                        width: 110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                data.imageFile,
                                width: 110,
                                height: 110,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (data.name.isNotEmpty) ...[
                              Text(
                                data.name,
                                style: const TextStyle(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                            if (data.coordinates.isNotEmpty) ...[
                              Text(
                                data.coordinates,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showExpanded(context, ReportImageModel data) {
    final translations = S.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(data.name),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.file(data.imageFile),
              const SizedBox(height: 8),
              if (data.coordinates.isNotEmpty)
                Text("${translations.coordinate}: ${data.coordinates}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(translations.close),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, int index, ReportImageModel data) {
    if (onlyShow) return;

    TextEditingController nameController =
        TextEditingController(text: data.name);
    TextEditingController coordinateController =
        TextEditingController(text: data.coordinates);

    final translations = S.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(translations.editInformation),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.file(images[0].imageFile),
              const SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: translations.cellName),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: coordinateController,
                decoration: InputDecoration(labelText: translations.coordinate),
              ),
              TextButton(
                onPressed: () {
                  onRemoveImage!(index);
                  Navigator.pop(context);
                },
                child: Text(translations.remove),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(translations.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                onUpdateImageData!(index, 'name', nameController.text);
                onUpdateImageData!(
                    index, 'coordinates', coordinateController.text);
                Navigator.pop(context);
              },
              child: Text(translations.save,
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
