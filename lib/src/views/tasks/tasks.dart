import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:odonto/src/views/tasks/answers.dart';
import 'package:odonto/src/views/tasks/chartTask.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/tasks/tasks_dao.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  bool isAvailable = true;
  DateTime? nextExerciseDate;

  void _updateIsAvailable() {
    setState(() {
      isAvailable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: TasksDao().listar().snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final dados = snapshot.requireData.docs;

          bool hasAnsweredExercise = false;
          DateTime? lastAnswerDate;

          for (var resposta in dados) {
            if (resposta['uid'] == AuthController().idUsuario()) {
              hasAnsweredExercise = true;
              lastAnswerDate = resposta['respondido_em']?.toDate();
              break;
            }
          }

          if (hasAnsweredExercise) {
            final currentDate = DateTime.now();
            final difference =
                currentDate.difference(lastAnswerDate ?? currentDate);
            final daysSinceLastAnswer = difference.inDays;

            if (daysSinceLastAnswer >= 7) {
              isAvailable = true;
              nextExerciseDate = lastAnswerDate?.add(const Duration(days: 7));
            } else {
              isAvailable = false;
              nextExerciseDate = lastAnswerDate?.add(const Duration(days: 7));
            }
          } else {
            isAvailable = true;
            nextExerciseDate = DateTime.now();
          }

          return Center(
            child: isAvailable
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Você possui exercícios disponíveis',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (c) {
                                  return Answers(
                                    onSubmit: _updateIsAvailable,
                                  );
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'Começar',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Nenhum exercício disponível',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Próximo exercício em ${nextExerciseDate?.day}/${nextExerciseDate?.month}/${nextExerciseDate?.year}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (c) {
                                return const ChartTask();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          'Relatório',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
