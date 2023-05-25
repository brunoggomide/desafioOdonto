import 'package:flutter/material.dart';
import 'package:odonto/src/models/exercise_model.dart';

class ShowExercise extends StatefulWidget {
  const ShowExercise({
    Key? key,
    // required this.item,
  }) : super(key: key);

  // final Exercicio item;

  @override
  State<ShowExercise> createState() => _ShowExerciseState();
}

class _ShowExerciseState extends State<ShowExercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Exercício',
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
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          side: const BorderSide(width: 2, color: Colors.green),
                        ),
                        onPressed: () {
                          // Adicione a ação para alterar a senha aqui
                        },
                        child: const Text(
                          'Relatório',
                          style: TextStyle(fontSize: 18, color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          side: const BorderSide(width: 2, color: Colors.blue),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Editar',
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
