import 'package:flutter/material.dart';
import 'package:wbc_counter/generated/l10n.dart';
import 'package:wbc_counter/models/tip_blood_cell_model.dart';

class TipsPage extends StatelessWidget {
  final S s = S();
  TipsPage({super.key});
  final List<TipBloodCellModel> tipBloodCells = [];

  void initialize() {
    tipBloodCells.addAll([
      TipBloodCellModel(
        name: s.neutrophilsTitle,
        description: s.neutrophilsDescription,
        cover: 'neutrofilo',
        identifyTopics: [
          s.neutrophilsTopic1,
          s.neutrophilsTopic2,
          s.neutrophilsTopic3,
          s.neutrophilsTopic4,
          s.neutrophilsTopic5,
        ],
        exampleImage: 'neutrofilo',
      ),
      TipBloodCellModel(
        name: s.lymphocytesTitle,
        description: s.lymphocytesDescription,
        cover: 'linfocito',
        identifyTopics: [
          s.lymphocytesTopic1,
          s.lymphocytesTopic2,
          s.lymphocytesTopic3,
          s.lymphocytesTopic4,
          s.lymphocytesTopic5,
        ],
        exampleImage: 'linfocito',
      ),
      TipBloodCellModel(
        name: s.eosinophilsTitle,
        description: s.eosinophilsDescription,
        cover: 'eosinofilo',
        identifyTopics: [
          s.eosinophilsTopic1,
          s.eosinophilsTopic2,
          s.eosinophilsTopic3,
          s.eosinophilsTopic4,
          s.eosinophilsTopic5,
        ],
        exampleImage: 'eosinofilo',
      ),
      TipBloodCellModel(
        name: s.basophilsTitle,
        description: s.basophilsDescription,
        cover: 'basofilo',
        identifyTopics: [
          s.basophilsTopic1,
          s.basophilsTopic2,
          s.basophilsTopic3,
          s.basophilsTopic4,
          s.basophilsTopic5,
        ],
        exampleImage: 'basofilo',
      ),
      TipBloodCellModel(
        name: s.monocytesTitle,
        description: s.monocytesDescription,
        cover: 'monocito',
        identifyTopics: [
          s.monocytesTopic1,
          s.monocytesTopic2,
          s.monocytesTopic3,
          s.monocytesTopic4,
          s.monocytesTopic5,
        ],
        exampleImage: 'monocito',
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).tipsToIdentify),
      ),
      body: ListView.builder(
        itemCount: tipBloodCells.length,
        itemBuilder: (context, index) {
          return _buildCellCard(tipBloodCells[index]);
        },
      ),
    );
  }

  Widget _buildCellCard(TipBloodCellModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/cells/${model.cover}_example1.png',
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    model.description,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    s.howIdentify,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  ...model.identifyTopics.map((topic) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        topic,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    );
                  }),
                  const SizedBox(height: 16.0),
                  Text(
                    s.moreExamples,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Image.asset(
                    'assets/cells/${model.exampleImage}_example2.png',
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
