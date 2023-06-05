import 'dart:math';
import 'package:flutter/material.dart';
import 'package:odonto/src/controllers/auth/auth_controller.dart';
import 'package:odonto/src/controllers/exercise/exercise_dao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:odonto/src/controllers/tasks/tasks_dao.dart';
import 'package:odonto/src/models/answers_model.dart';

class Answers extends StatefulWidget {
  const Answers({Key? key, this.onSubmit}) : super(key: key);

  final VoidCallback? onSubmit;

  @override
  State<Answers> createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  String? answer1;
  String? answer2;
  int randomIndex1 = 0;
  int randomIndex2 = 0;

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
      body: StreamBuilder<QuerySnapshot>(
        stream: ExerciseDao().listar().snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var exercicios = snapshot.data!.docs;
          int totalExercicios = exercicios.length;

          // Filtrar exercícios com status verdadeiro
          var exerciciosComStatusVerdadeiro = exercicios
              .where((exercicio) => exercicio['status'] == true)
              .toList();

          if (exerciciosComStatusVerdadeiro.isEmpty) {
            return const Center(
              child: Text('Nenhum exercício disponível no momento.'),
            );
          }

          if (randomIndex1 == 0 && randomIndex2 == 0) {
            randomIndex1 =
                Random().nextInt(exerciciosComStatusVerdadeiro.length);
            do {
              randomIndex2 =
                  Random().nextInt(exerciciosComStatusVerdadeiro.length);
            } while (randomIndex2 == randomIndex1);
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '01 - ${exerciciosComStatusVerdadeiro[randomIndex1]['enunciado']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  RadioListTile(
                    title: Text(
                        'A) ${exerciciosComStatusVerdadeiro[randomIndex1]['alternativa_a']}'),
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
                        'B) ${exerciciosComStatusVerdadeiro[randomIndex1]['alternativa_b']}'),
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
                        'C) ${exerciciosComStatusVerdadeiro[randomIndex1]['alternativa_c']}'),
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
                        'D) ${exerciciosComStatusVerdadeiro[randomIndex1]['alternativa_d']}'),
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
                  Text(
                    '02 - ${exerciciosComStatusVerdadeiro[randomIndex2]['enunciado']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  RadioListTile(
                    title: Text(
                        'A) ${exerciciosComStatusVerdadeiro[randomIndex2]['alternativa_a']}'),
                    value: 'A',
                    groupValue: answer2,
                    onChanged: (value) {
                      setState(() {
                        answer2 = value as String?;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(
                        'B) ${exerciciosComStatusVerdadeiro[randomIndex2]['alternativa_b']}'),
                    value: 'B',
                    groupValue: answer2,
                    onChanged: (value) {
                      setState(() {
                        answer2 = value as String?;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(
                        'C) ${exerciciosComStatusVerdadeiro[randomIndex2]['alternativa_c']}'),
                    value: 'C',
                    groupValue: answer2,
                    onChanged: (value) {
                      setState(() {
                        answer2 = value as String?;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(
                        'D) ${exerciciosComStatusVerdadeiro[randomIndex2]['alternativa_d']}'),
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
                            exerciciosComStatusVerdadeiro[randomIndex1].id,
                            answer1!,
                            exerciciosComStatusVerdadeiro[randomIndex1]
                                ['alternativa_correta'],
                            '',
                          );

                          var answer2Data = AnswersModel(
                            AuthController().idUsuario(),
                            exerciciosComStatusVerdadeiro[randomIndex2].id,
                            answer2!,
                            exerciciosComStatusVerdadeiro[randomIndex2]
                                ['alternativa_correta'],
                            '',
                          );

                          bool success1 =
                              await TasksDao().adicionar(context, answer1Data);
                          bool success2 =
                              await TasksDao().adicionar(context, answer2Data);

                          if (success1 && success2) {
                            Navigator.of(context).pop();
                            widget.onSubmit?.call();
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
