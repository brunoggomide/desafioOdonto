import 'package:flutter/material.dart';
import 'package:odonto/src/views/exercise/chartExercise.dart';
import 'package:odonto/src/views/exercise/editExercise.dart';

class ShowExercise extends StatefulWidget {
  const ShowExercise({
    Key? key,
    required this.item,
    required this.id,
  }) : super(key: key);

  final dynamic item;
  final String id;

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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              readOnly: true,
              maxLines: 3,
              initialValue: widget.item['enunciado'],
              decoration: InputDecoration(
                labelText: 'Enunciado',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              readOnly: true,
              initialValue: widget.item['alternativa_a'],
              decoration: InputDecoration(
                labelText: 'Alternativa A',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              readOnly: true,
              initialValue: widget.item['alternativa_b'],
              decoration: InputDecoration(
                labelText: 'Alternativa B',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              readOnly: true,
              initialValue: widget.item['alternativa_c'],
              decoration: InputDecoration(
                labelText: 'Alternativa C',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              readOnly: true,
              initialValue: widget.item['alternativa_d'],
              decoration: InputDecoration(
                labelText: 'Alternativa D',
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    readOnly: true,
                    initialValue: widget.item['alternativa_correta'],
                    decoration: InputDecoration(
                      labelText: 'Alternativa Correta',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    readOnly: true,
                    initialValue: widget.item['status']
                        ? 'Exercício Ativo'
                        : 'Exercício Inativo',
                    decoration: InputDecoration(
                      labelText: 'Status',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (c) {
                                return ChartExercise(
                                  id: widget.id,
                                );
                              },
                            ),
                          );
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
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: ((c) {
                                return EditExercise(
                                  item: widget.item,
                                  id: widget.id,
                                );
                              }),
                            ),
                          );
                        },
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
          ],
        ),
      ),
    );
  }
}
