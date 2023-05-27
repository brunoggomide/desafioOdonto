import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartExercise extends StatefulWidget {
  const ChartExercise({Key? key}) : super(key: key);

  @override
  State<ChartExercise> createState() => _ChartExerciseState();
}

class _ChartExerciseState extends State<ChartExercise> {
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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 0.8,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 8,
                      color: Colors.green,
                      title: '',
                      radius: 80,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      showTitle: false,
                      badgeWidget: _buildBadgeWidget('8'),
                    ),
                    PieChartSectionData(
                      value: 3,
                      color: Colors.red,
                      title: '',
                      radius: 80,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      showTitle: false,
                      badgeWidget: _buildBadgeWidget('3'),
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
                  _buildLegend(const Color(0xFFFF0000), 'Respostas Erradas'),
                ],
              ),
            ),
          ],
        ),
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
