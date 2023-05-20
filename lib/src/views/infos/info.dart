import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Informações do App',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
          ),
        ),
      ),

      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Text(
              'O Glossário de Oclusão é um aplicativo desenvolvido para os alunos e professores do curso de Odontologia da instituição UNAERP. O desenvolvimento do aplicativo é parte do Desafio da 6° etapa do curso de Engenharia de Software.',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: const Text(
                  'Desenvolvido por: Bruno Gomide\nApoio de: Rodrigo Plotze, Carlos Alves e Fabiano\nE-mail para contato: bruno.gomide@sou.unaerp.edu.br',
                  textAlign: TextAlign.left,
                  style: TextStyle(height: 1.5, fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
