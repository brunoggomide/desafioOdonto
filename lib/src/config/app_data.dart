import 'package:odonto/src/models/item_model.dart';

ItemModel rc = ItemModel(
  name: 'Relação Cêntrica (RC)',
  description:
      'relacionamento maxilomandibular independente do contato dentário, no qual os côndilos se articulam na posição anterossuperior contra as inclinações posteriores das eminências articulares. Nesta posição, a mandíbula realiza apenas um movimento de rotação. A partir desta posição fisiológica, de relação maxilomandibular, o paciente pode realizar movimentos laterais, verticais ou protrusivos. Clinicamente é uma posição de referência útil e repetível. Portanto, a RC é uma posição condilar que independe dos contatos dentários.',
);

ItemModel efl = ItemModel(
  name: 'Espaço Funcional Livre (EFL)',
  description:
      'é a distância entre os dentes antagonistas quando a mandíbula está em posição de repouso postural. É a diferença entre a dimensão vertical de repouso e a de oclusão e apresenta valores médios de 3 mm. O Glossário de termos protéticos, em sua 9ª edição (GPT-9, 2017) conceitua esse espaço como Espaço de Repouso Interoclusal (IORS – interoclusal rest space).',
);

ItemModel mih = ItemModel(
  name: 'Máxima Intercuspidação Habitual (MIH)',
  description:
      'posição de intercuspidação completa dos dentes opostos, independentemente da posição condilar. Às vezes referida como o melhor ajuste dos dentes, independentemente da posição condilar.',
);

ItemModel spee = ItemModel(
  name: 'Curva de Spee',
  description:
      'curva anteroposterior que se estende da ponta do canino até as cúspides do último dente, em formato ascendente.',
);

ItemModel wilson = ItemModel(
  name: 'Curva de Wilson',
  description:
      'curva mediolateral. Em teoria, a oclusão deve ser esférica, a curvatura das cúspides, tal como previsto no plano frontal expresso em ambos os arcos; a curvatura no arco mandibular sendo côncava e o no arco maxilar sendo convexa.',
);

ItemModel christenses = ItemModel(
  name: 'Fenômeno de Christensen',
  description:
      'o espaço que ocorre entre as superfícies oclusais dos dentes posteriores antagonistas durante a protrusão mandibular.',
);

ItemModel anterior = ItemModel(
  name: 'Guia anterior',
  description:
      'relação dos dentes anteriores que evita o contato dos dentes posteriores em todos os movimentos mandibulares excêntricos.',
);

ItemModel canina = ItemModel(
  name: 'Guia Canina',
  description:
      'uma forma de proteção articular mútua, na qual o overlap horizontal e vertical dos caninos desocluem os dentes posteriores nos movimentos excursivos da mandíbula.',
);

ItemModel iOclusal = ItemModel(
  name: 'Interferência Oclusal',
  description:
      'qualquer contato dentário que impeça as demais superfícies oclusais de realizarem contatos oclusais estáveis e harmônicos.',
);

ItemModel tOclusal = ItemModel(
  name: 'Trauma Oclusal',
  description:
      'trauma nos tecidos periodontais a partir de forças funcionais ou parafuncionais, causando prejuízos que excedem as capacidades adaptativas e reparadoras, pode ser autolimitado ou progressivo.',
);

ItemModel dvo = ItemModel(
  name: 'Dimensão Vertical de Oclusão (DVO)',
  description:
      'distância entre dois pontos anatômicos ou selecionados/marcados (geralmente um na ponta do nariz e outro no queixo) na posição de máxima intercuspidação habitual (MIH).',
);

ItemModel dvr = ItemModel(
  name: 'Dimensão Vertical de Repouso (DVR) / Relação de Repouso Mandibular',
  description:
      'quando o paciente está em posição de repouso confortável, com os côndilos em posição neutra, não forçada, e os músculos encontram-se em estado de mínima atividade de contração.',
);

ItemModel plOclusal = ItemModel(
  name: 'Plano Oclusal',
  description:
      'plano estabelecido pelas superfícies incisais e oclusais dos dentes.',
);

ItemModel poOclusal = ItemModel(
  name: 'Posição Oclusal',
  description:
      'relação entre a maxila e mandíbula quando a mandíbula está fechada e os destes estão na posição de máxima intercuspidação, esta posição pode ou não ser coincidente com a oclusão cêntrica.',
);

ItemModel centrica = ItemModel(
  name: 'Oclusão cêntrica',
  description:
      'posição de contatos dentários na qual a mandíbula está em relação cêntrica, pode ou não coincidir com a máxima intercuspidação habitual.',
);

List<ItemModel> items = [
  rc,
  efl,
  mih,
  spee,
  wilson,
  christenses,
  anterior,
  canina,
  iOclusal,
  tOclusal,
  dvo,
  dvr,
  plOclusal,
  poOclusal,
  centrica,
];
