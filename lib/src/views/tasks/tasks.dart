import 'package:flutter/material.dart';
import 'dart:math';

import 'package:odonto/src/views/tasks/answers.dart';
import 'package:odonto/src/views/tasks/chartTask.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  bool isAvailable = true;

  void _updateIsAvailable() {
    setState(() {
      isAvailable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
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
                              borderRadius: BorderRadius.circular(18))),
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
                  const Text(
                    'Próximo exercício dia xx/xx/xxxx',
                    style: TextStyle(fontSize: 16),
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
      ),
    );
  }
}
