import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:odonto/src/controllers/tasks/tasks_dao.dart';

class ChartExercise extends StatefulWidget {
  const ChartExercise({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<ChartExercise> createState() => _ChartExerciseState();
}

class _ChartExerciseState extends State<ChartExercise> {
  int respostasCertas = 0;
  int respostasErradas = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Relatório do Exercício',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: TasksDao().listar().snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final dados = snapshot.requireData.docs;
            verificarRespostas(dados);

            if (respostasCertas == 0 && respostasErradas == 0) {
              // Não há dados para mostrar
              return const Center(
                child: Text('Não há dados para mostrar'),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          if (respostasCertas > 0)
                            PieChartSectionData(
                              value: respostasCertas.toDouble(),
                              color: Colors.green,
                              title: '',
                              radius: 80,
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              showTitle: false,
                              badgeWidget:
                                  _buildBadgeWidget(respostasCertas.toString()),
                            ),
                          if (respostasErradas > 0)
                            PieChartSectionData(
                              value: respostasErradas.toDouble(),
                              color: Colors.red,
                              title: '',
                              radius: 80,
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              showTitle: false,
                              badgeWidget: _buildBadgeWidget(
                                  respostasErradas.toString()),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomCenter, // Legenda no rodapé
                    child: Column(
                      children: [
                        if (respostasCertas > 0 || respostasErradas > 0)
                          _buildLegend(
                              const Color(0xFF00FF00), 'Respostas Certas'),
                        const SizedBox(height: 6),
                        if (respostasErradas > 0 || respostasCertas > 0)
                          _buildLegend(
                              const Color(0xFFFF0000), 'Respostas Erradas'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Carregando dados...'),
            );
          }
        },
      ),
    );
  }

  void verificarRespostas(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> dados) {
    respostasCertas = 0;
    respostasErradas = 0;

    for (var resposta in dados) {
      if (resposta['eid'] == widget.id) {
        if (resposta['alternativa_correta'] ==
            resposta['alternativa_selecionada']) {
          respostasCertas++;
        } else {
          respostasErradas++;
        }
      }
    }
  }

  Widget _buildBadgeWidget(String value) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildLegend(Color color, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 6),
        Container(
          width: 14,
          height: 14,
          color: color,
        ),
      ],
    );
  }
}
