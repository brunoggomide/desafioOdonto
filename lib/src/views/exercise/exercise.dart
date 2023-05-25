import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:odonto/src/controllers/exercise/exercise_dao.dart';
import 'package:odonto/src/views/exercise/newExercise.dart';
import 'package:odonto/src/views/exercise/showExercise.dart';

class Exercise extends StatefulWidget {
  const Exercise({Key? key}) : super(key: key);

  @override
  State<Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Lista de exercícios',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                hintText: 'Pesquisar exercício...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: ExerciseDao().listar().snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Center(
                    child: Text('Não foi possível conectar.'),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final dados = snapshot.requireData;
                  if (dados.size > 0) {
                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      physics: const BouncingScrollPhysics(),
                      itemCount: dados.size,
                      itemBuilder: (context, index) {
                        dynamic item = dados.docs[index].data();
                        String enunciado = item['enunciado'];
                        if (enunciado
                            .toLowerCase()
                            .contains(_searchText.toLowerCase())) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (c) {
                                    return ShowExercise();
                                  },
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white70,
                              ),
                              child: ListTile(
                                title: Text(enunciado),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Sem dados.'),
                    );
                  }
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (c) {
                return const NewExercise();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
