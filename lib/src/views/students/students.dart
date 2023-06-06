import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:odonto/src/controllers/students/students_dao.dart';

import 'chartStudent.dart';

class Students extends StatefulWidget {
  const Students({Key? key}) : super(key: key);

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Lista de alunos',
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
                hintText: 'Pesquisar aluno...',
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
              stream: StudentsDao().listar().snapshots(),
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
                    // Ordenar a lista por ordem alfabética de A-Z
                    List<QueryDocumentSnapshot> sortedData = dados.docs;
                    sortedData.sort((a, b) => a['nome'].compareTo(b['nome']));

                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      physics: const BouncingScrollPhysics(),
                      itemCount: sortedData.length,
                      itemBuilder: (context, index) {
                        dynamic item = sortedData[index].data();
                        String nome = item['nome'];
                        String codigo = item['codigo'];

                        // Filtrar os resultados com base no valor de _searchText
                        if (nome
                                .toLowerCase()
                                .contains(_searchText.toLowerCase()) ||
                            codigo
                                .toLowerCase()
                                .contains(_searchText.toLowerCase())) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (c) {
                                    return ChartStudent(
                                      item: item,
                                    );
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
                                title: Text(nome),
                                subtitle: Text(codigo),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
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
    );
  }
}
