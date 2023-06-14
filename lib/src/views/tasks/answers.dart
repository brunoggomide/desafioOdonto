import 'dart:math';
import 'package:flutter/material.dart';
import 'package:odonto/src/controllers/auth/auth_controller.dart';
import 'package:odonto/src/controllers/exercise/exercise_dao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:odonto/src/controllers/tasks/tasks_dao.dart';
import 'package:odonto/src/models/answers_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Answers extends StatefulWidget {
  const Answers({Key? key, this.onSubmit}) : super(key: key);

  final VoidCallback? onSubmit;

  @override
  State<Answers> createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  String? answer1;
  String? answer2;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> availableExercises = [];
  int currentIndex = 0;
  int x = 0;
  late SharedPreferences _prefs;
  late String _prefsKey = 'x';

  @override
  void initState() {
    super.initState();
    _initPreferences();
  }

  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      x = _prefs.getInt(_prefsKey) ?? 0;
    });
  }

  Future<void> _saveX() async {
    await _prefs.setInt(_prefsKey, x);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Exercícios',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: ExerciseDao().listar().snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final exercises = snapshot.requireData.docs;

          availableExercises = exercises
              .where((exercicio) => exercicio['status'] == true)
              .toList();

          if (availableExercises.isEmpty) {
            return const Center(
              child: Text('Nenhum exercício disponível no momento.'),
            );
          }

          final currentUserAnsweredExercises = exercises
              .where((exercicio) =>
                  exercicio['uid'] == AuthController().idUsuario())
              .toList();

          if (currentUserAnsweredExercises.isNotEmpty) {
            final lastAnswerDate =
                currentUserAnsweredExercises.last['respondido_em'].toDate();
            final currentDate = DateTime.now();
            final difference = currentDate.difference(lastAnswerDate);
            final daysSinceLastAnswer = difference.inMinutes;

            if (daysSinceLastAnswer < 2) {
              return const Center(
                child: Text('Nenhum exercício disponível no momento.'),
              );
            }
          }

          if (x >= availableExercises.length) {
            x = 0;
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '01 - ${availableExercises[currentIndex + x]['enunciado']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  RadioListTile(
                    title: Text(
                        'A) ${availableExercises[currentIndex + x]['alternativa_a']}'),
                    value: 'A',
                    groupValue: answer1,
                    onChanged: (value) {
                      setState(() {
                        answer1 = value as String?;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(
                        'B) ${availableExercises[currentIndex + x]['alternativa_b']}'),
                    value: 'B',
                    groupValue: answer1,
                    onChanged: (value) {
                      setState(() {
                        answer1 = value as String?;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(
                        'C) ${availableExercises[currentIndex + x]['alternativa_c']}'),
                    value: 'C',
                    groupValue: answer1,
                    onChanged: (value) {
                      setState(() {
                        answer1 = value as String?;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(
                        'D) ${availableExercises[currentIndex + x]['alternativa_d']}'),
                    value: 'D',
                    groupValue: answer1,
                    onChanged: (value) {
                      setState(() {
                        answer1 = value as String?;
                      });
                    },
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 2,
                  ),
                  const SizedBox(height: 15),
                  if (currentIndex + x + 1 < availableExercises.length)
                    Text(
                      '02 - ${availableExercises[currentIndex + x + 1]['enunciado']}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  if (currentIndex + x + 1 < availableExercises.length)
                    RadioListTile(
                      title: Text(
                          'A) ${availableExercises[currentIndex + x + 1]['alternativa_a']}'),
                      value: 'A',
                      groupValue: answer2,
                      onChanged: (value) {
                        setState(() {
                          answer2 = value as String?;
                        });
                      },
                    ),
                  if (currentIndex + x + 1 < availableExercises.length)
                    RadioListTile(
                      title: Text(
                          'B) ${availableExercises[currentIndex + x + 1]['alternativa_b']}'),
                      value: 'B',
                      groupValue: answer2,
                      onChanged: (value) {
                        setState(() {
                          answer2 = value as String?;
                        });
                      },
                    ),
                  if (currentIndex + x + 1 < availableExercises.length)
                    RadioListTile(
                      title: Text(
                          'C) ${availableExercises[currentIndex + x + 1]['alternativa_c']}'),
                      value: 'C',
                      groupValue: answer2,
                      onChanged: (value) {
                        setState(() {
                          answer2 = value as String?;
                        });
                      },
                    ),
                  if (currentIndex + x + 1 < availableExercises.length)
                    RadioListTile(
                      title: Text(
                          'D) ${availableExercises[currentIndex + x + 1]['alternativa_d']}'),
                      value: 'D',
                      groupValue: answer2,
                      onChanged: (value) {
                        setState(() {
                          answer2 = value as String?;
                        });
                      },
                    ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () async {
                        if (answer1 == null || answer2 == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red[300],
                              content: const Text(
                                'Responda todas as alternativas',
                                style: TextStyle(color: Colors.white),
                              ),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        } else {
                          var answer1Data = AnswersModel(
                            AuthController().idUsuario(),
                            availableExercises[currentIndex + x]
                                .id, // Utilize o campo 'id' para obter o ID
                            answer1!,
                            availableExercises[currentIndex + x]
                                ['alternativa_correta'],
                            '',
                          );

                          var answer2Data = AnswersModel(
                            AuthController().idUsuario(),
                            availableExercises[currentIndex + x + 1]
                                .id, // Utilize o campo 'id' para obter o ID
                            answer2!,
                            availableExercises[currentIndex + x + 1]
                                ['alternativa_correta'],
                            '',
                          );

                          bool success1 =
                              await TasksDao().adicionar(context, answer1Data);
                          bool success2 =
                              await TasksDao().adicionar(context, answer2Data);

                          if (success1 && success2) {
                            setState(() {
                              x += 2;
                            });
                            await _saveX();
                            widget.onSubmit?.call();
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red[300],
                                content: const Text(
                                  'Erro ao adicionar as respostas',
                                  style: TextStyle(color: Colors.white),
                                ),
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text(
                        'Enviar',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
