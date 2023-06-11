import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/tasks/tasks_dao.dart';

class ChartTask extends StatefulWidget {
  const ChartTask({Key? key}) : super(key: key);

  @override
  State<ChartTask> createState() => _ChartTaskState();
}

class _ChartTaskState extends State<ChartTask> {
  int respostasCorretas = 0;
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
          'Desempenho',
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
      body: StreamBuilder<QuerySnapshot>(
        stream: TasksDao().listar().snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final dados = snapshot.requireData.docs;

            // Ordenar os documentos por data de resposta (respondido_em)
            dados.sort((a, b) {
              final dataA = a['respondido_em'] as Timestamp;
              final dataB = b['respondido_em'] as Timestamp;
              return dataB.compareTo(dataA); // Ordem decrescente
            });

            // Obter as duas últimas respostas do usuário
            final ultimasRespostas = dados.take(2).toList();

            // Limpar os contadores
            respostasCorretas = 0;
            respostasErradas = 0;

            // Contar as respostas corretas e erradas
            for (var resposta in ultimasRespostas) {
              final uid = resposta['uid'];
              final alternativaSelecionada =
                  resposta['alternativa_selecionada'];
              final alternativaCorreta = resposta['alternativa_correta'];
              final id = AuthController().idUsuario();

              if (id == uid && alternativaSelecionada == alternativaCorreta) {
                respostasCorretas++;
              } else if (id == uid &&
                  alternativaSelecionada != alternativaCorreta) {
                respostasErradas++;
              }
            }
          }

          // Verificar se há seções com valores zero
          final bool hasZeroValues =
              respostasCorretas == 0 || respostasErradas == 0;

          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 0.8,
                  child: PieChart(
                    PieChartData(
                      sections: hasZeroValues
                          ? [
                              if (respostasCorretas > 0)
                                PieChartSectionData(
                                  value: respostasCorretas.toDouble(),
                                  color: Colors.green,
                                  title: '',
                                  radius: 80,
                                  titleStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  showTitle: false,
                                  badgeWidget: _buildBadgeWidget(
                                      respostasCorretas.toString()),
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
                            ]
                          : [
                              PieChartSectionData(
                                value: respostasCorretas.toDouble(),
                                color: Colors.green,
                                title: '',
                                radius: 80,
                                titleStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                showTitle: false,
                                badgeWidget: _buildBadgeWidget(
                                    respostasCorretas.toString()),
                              ),
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
                      _buildLegend(const Color(0xFF00FF00), 'Respostas Certas'),
                      const SizedBox(height: 6),
                      _buildLegend(
                          const Color(0xFFFF0000), 'Respostas Erradas'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
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
