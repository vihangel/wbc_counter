import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wbc_counter/generated/l10n.dart';
import 'package:wbc_counter/models/tip_blood_cell_model.dart';

class TipsPage extends StatelessWidget {
  final S s = S();
  TipsPage({super.key});
  final List<TipBloodCellModel> tipBloodCells = [];

  void initialize() {
    tipBloodCells.addAll(
      [
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
        TipBloodCellModel(
          name: s.subtypesAndVariations,
          description: '',
          cover: 'linfocito',
          identifyTopics: [],
          subtypes: [
            TipBloodCellModel(
              name: s.largeGranularLymphocytesLGL,
              description: s.largeGranularLymphocytesLGLDescription,
              cover: 'granular',
              identifyTopics: [],
              exampleImage: 'granular',
            ),
            TipBloodCellModel(
              name: s.reactiveOrActivatedLymphocytes,
              description: s.reactiveOrActivatedLymphocytesDescription,
              cover: 'reativo',
              identifyTopics: [],
              exampleImage: 'reativo',
            ),
            TipBloodCellModel(
              name: s.neoplasticClonalLymphocytes,
              description: s.neoplasticClonalLymphocytesDescription,
              cover: 'llctipica',
              identifyTopics: [],
              exampleImage: 'llctipica',
            ),
            TipBloodCellModel(
              name: s.atypicalLymphocytes,
              description: s.atypicalLymphocytesDescription,
              cover: 'pleomorficos',
              identifyTopics: [],
              exampleImage: 'pleomorficos',
            ),
            TipBloodCellModel(
              name: s.plasmaCells,
              description: s.plasmaCellsDescription,
              cover: 'plasmocito',
              identifyTopics: [],
              exampleImage: 'plasmocito',
            ),
            TipBloodCellModel(
              name: s.lymphocytesWithCleavedNucleus,
              description: s.lymphocytesWithCleavedNucleusDescription,
              cover: 'clivado',
              identifyTopics: [],
              exampleImage: 'clivado',
            ),
            TipBloodCellModel(
              name: s.villousLymphocytes,
              description: s.villousLymphocytesDescription,
              cover: 'vilosos',
              identifyTopics: [],
              exampleImage: 'vilosos',
            ),
            TipBloodCellModel(
              name: s.mottCells,
              description: s.mottCellsDescription,
              cover: 'mott',
              identifyTopics: [],
              exampleImage: 'mott',
            ),
            TipBloodCellModel(
              name: s.flowerCells,
              description: s.flowerCellsDescription,
              cover: 'flower',
              identifyTopics: [],
              exampleImage: 'flower',
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    initialize();
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).tipsToIdentify),
      ),
      body: ListView(
        children: [
          ...List.generate(
            tipBloodCells.length,
            (index) => _buildCellCard(tipBloodCells[index]),
          ),
          const SizedBox(height: 32.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                const SizedBox(height: 16.0),
                // const Text(
                //   'Referências',
                //   style: TextStyle(
                //     fontSize: 18.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // const SizedBox(height: 8.0),
                InkWell(
                  onTap: () async {
                    final uri = Uri.parse(
                      'https://www.biomedicinapadrao.com.br/2020/01/como-identificar-linfocitos-reativos-e.html',
                    );
                    if (!await launchUrl(uri)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Could not open link')),
                      );
                    }
                  },
                  child: Text(
                    'https://www.biomedicinapadrao.com.br/2020/01/como-identificar-linfocitos-reativos-e.html',
                    style: TextStyle(
                      fontSize: 16.0,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () async {
                    final uri = Uri.parse(
                      'https://www.google.com/search?q=Bain+BJ+Blood+Cells+Blackwell+4th+ed',
                    );
                    if (!await launchUrl(uri)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Could not open link')),
                      );
                    }
                  },
                  child: Text(
                    'Bain BJ. Blood Cells - A practical guide. Blackwell, 4ª ed.',
                    style: TextStyle(
                      fontSize: 16.0,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () async {
                    final uri = Uri.parse(
                      'https://imagebank.hematology.org/image/63363/neutrophil-and-lymphocytes?type=atlas',
                    );
                    if (!await launchUrl(uri)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Could not open link')),
                      );
                    }
                  },
                  child: Text(
                    'https://imagebank.hematology.org/image/63363/neutrophil-and-lymphocytes?type=atlas',
                    style: TextStyle(
                      fontSize: 16.0,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCellCard(TipBloodCellModel model) {
    final imagePath = 'assets/cells/${model.cover}.png';
    final exampleImage1 = 'assets/cells/${model.cover}_example1.png';
    final exampleImage2 = 'assets/cells/${model.exampleImage}_example2.png';

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
            if (model.subtypes.isNotEmpty)
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
                    ...model.subtypes.map((subtype) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subtype.name,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Image.asset(
                              'assets/cells/${subtype.cover}.png',
                              fit: BoxFit.fitWidth,
                              errorBuilder: (context, error, stackTrace) {
                                return const SizedBox.shrink();
                              },
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              subtype.description,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              )
            else
              Column(
                children: [
                  Image.asset(
                    exampleImage1,
                    fit: BoxFit.fitWidth,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        imagePath,
                        fit: BoxFit.fitWidth,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox.shrink();
                        },
                      );
                    },
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
                        if (model.identifyTopics.isNotEmpty)
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
                        if (model.identifyTopics.isNotEmpty)
                          const SizedBox(height: 16.0),
                        if (model.identifyTopics.isNotEmpty)
                          Text(
                            s.moreExamples,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        const SizedBox(height: 8.0),
                        if (model.identifyTopics.isNotEmpty)
                          Image.asset(
                            exampleImage2,
                            fit: BoxFit.fitWidth,
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox.shrink();
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
