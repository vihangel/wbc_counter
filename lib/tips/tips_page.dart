import 'package:flutter/material.dart';
import 'package:wbc_counter/models/tip_blood_cell_model.dart';

class TipsPage extends StatelessWidget {
  TipsPage({Key? key}) : super(key: key);
  final List<TipBloodCellModel> tipBloodCells = [
    TipBloodCellModel(
      name: 'Neutrófilos',
      description:
          'Os neutrófilos são células de defesa imunológica que geralmente têm núcleos segmentados, com 2 a 5 segmentos conectados por filamentos finos. A cor do citoplasma é levemente rosada a incolor. São as células brancas mais abundantes, com tamanho médio e forma arredondada a ligeiramente lobulada. Podem conter grânulos finos e pálidos, mas geralmente não são muito visíveis. Os neutrófilos são altamente móveis e fagocitam bactérias.',
      cover: 'neutrofilo',
      identifyTopics: [
        'Núcleo: Os neutrófilos geralmente têm núcleos segmentados, com 2 a 5 segmentos conectados por filamentos finos.',
        'Cor do Citoplasma: O citoplasma é levemente rosado a incolor.',
        'Tamanho e Forma Geral: São as células brancas mais abundantes, com tamanho médio e forma arredondada a ligeiramente lobulada.',
        'Grânulos Citoplasmáticos: Podem conter grânulos finos e pálidos, mas geralmente não são muito visíveis.',
        'Mobilidade e Atividade: Neutrófilos são altamente móveis e fagocitam bactérias.',
      ],
      exampleImage: 'neutrofilo',
    ),
    TipBloodCellModel(
      name: 'Linfócitos',
      description:
          'Os linfócitos são células do sistema imunológico. Eles têm núcleos densos, redondos e uniformes. A cor do citoplasma é azul claro a incolor. São menores que os neutrófilos e têm forma geralmente esférica. Geralmente não contêm grânulos visíveis. Menos móveis do que os neutrófilos, estão envolvidos na resposta imunológica adaptativa.',
      cover: 'linfocito',
      identifyTopics: [
        'Núcleo: Linfócitos têm núcleos densos, redondos e uniformes.',
        'Cor do Citoplasma: O citoplasma é azul claro a incolor.',
        'Tamanho e Forma Geral: São menores que os neutrófilos e têm forma geralmente esférica.',
        'Grânulos Citoplasmáticos: Geralmente não contêm grânulos visíveis.',
        'Mobilidade e Atividade: Menos móveis do que os neutrófilos, estão envolvidos na resposta imunológica adaptativa.',
      ],
      exampleImage: 'linfocito',
    ),
    TipBloodCellModel(
      name: 'Eosinófilos',
      description:
          'Os eosinófilos têm um núcleo bilobado, parecendo um par de óculos. O citoplasma é rosa-alaranjado devido à presença de grânulos eosinofílicos. São ligeiramente maiores que os neutrófilos e têm forma irregular. Os grânulos são grandes e corados, geralmente rosados. Estão envolvidos na resposta alérgica e na defesa contra parasitas.',
      cover: 'eosinofilo',
      identifyTopics: [
        'Núcleo: O núcleo dos eosinófilos é bilobado, parecendo um par de óculos.',
        'Cor do Citoplasma: O citoplasma é rosa-alaranjado devido à presença de grânulos eosinofílicos.',
        'Tamanho e Forma Geral: São ligeiramente maiores que os neutrófilos e têm forma irregular.',
        'Grânulos Citoplasmáticos: Os grânulos são grandes e corados, geralmente rosados.',
        'Mobilidade e Atividade: Estão envolvidos na resposta alérgica e na defesa contra parasitas.',
      ],
      exampleImage: 'eosinofilo',
    ),
    TipBloodCellModel(
      name: 'Basófilos',
      description:
          'Os basófilos têm um núcleo bilobado, mas pode ser difícil de discernir devido aos grânulos densos. O citoplasma é azul-escuro a preto devido aos grânulos basofílicos. São semelhantes em tamanho aos neutrófilos e eosinófilos. Possuem grânulos densos, que obscurecem a visão do núcleo. São envolvidos em reações alérgicas graves e resposta imunológica.',
      cover: 'basofilo',
      identifyTopics: [
        'Núcleo: O núcleo dos basófilos é bilobado, mas pode ser difícil de discernir devido aos grânulos densos.',
        'Cor do Citoplasma: O citoplasma é azul-escuro a preto devido aos grânulos basofílicos.',
        'Tamanho e Forma Geral: São semelhantes em tamanho aos neutrófilos e eosinófilos.',
        'Grânulos Citoplasmáticos: Possuem grânulos densos, que obscurecem a visão do núcleo.',
        'Mobilidade e Atividade: São envolvidos em reações alérgicas graves e resposta imunológica.',
      ],
      exampleImage: 'basofilo',
    ),
    TipBloodCellModel(
      name: 'Monócitos',
      description:
          'Os monócitos têm um núcleo grande, com forma irregular e frequentemente em forma de rim. O citoplasma é cinza-azulado. São as maiores células brancas do sangue e têm uma forma irregular. Geralmente não possuem grânulos visíveis. São móveis e se diferenciam em macrófagos quando se deslocam para os tecidos.',
      cover: 'monocito',
      identifyTopics: [
        'Núcleo: O núcleo dos monócitos é grande, com forma irregular e frequentemente em forma de rim.',
        'Cor do Citoplasma: O citoplasma é cinza-azulado.',
        'Tamanho e Forma Geral: São as maiores células brancas do sangue e têm uma forma irregular.',
        'Grânulos Citoplasmáticos: Geralmente não possuem grânulos visíveis.',
        'Mobilidade e Atividade: São móveis e se diferenciam em macrófagos quando se deslocam para os tecidos.',
      ],
      exampleImage: 'monocito',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dicas de identificaçâo'),
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
                  const Text(
                    'Como Identificar:',
                    style: TextStyle(
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
                  }).toList(),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Mais exemplos',
                    style: TextStyle(
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
