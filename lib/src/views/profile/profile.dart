import 'package:flutter/material.dart';
import 'package:odonto/src/controllers/auth/auth_controller.dart';
import 'package:odonto/src/views/infos/info.dart';

import '../auth/sign_in.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  String getEmailDescription(String email) {
    if (email.endsWith('@sou.unaerp.edu.br')) {
      return 'Aluno';
    } else if (email.endsWith('@unaerp.br')) {
      return 'Professor';
    } else {
      return 'Usuário';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Perfil',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            color: Colors.black,
            iconSize: 26,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (c) {
                    return const Info();
                  },
                ),
              );
            },
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: FutureBuilder<String>(
                future: AuthController().getNome(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final nome = snapshot.data ?? '';
                    return Text(
                      nome,
                      style: const TextStyle(color: Colors.black, fontSize: 30),
                    );
                  }
                },
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: FutureBuilder<String>(
                future: AuthController().getEmail(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final email = snapshot.data ?? '';
                    final emailDescription = getEmailDescription(email);
                    return Text(
                      emailDescription,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    );
                  }
                },
              ),
            ),
          ),
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
                          side: const BorderSide(width: 2, color: Colors.blue),
                        ),
                        onPressed: () async {
                          String email = await AuthController().getEmail();
                          AuthController().esqueceuSenha(context, email);
                        },
                        child: const Text(
                          'Alterar senha',
                          style: TextStyle(fontSize: 18, color: Colors.blue),
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
                          side: const BorderSide(width: 2, color: Colors.red),
                        ),
                        onPressed: () {
                          AuthController().logout(context);
                        },
                        child: const Text(
                          'Sair',
                          style: TextStyle(fontSize: 18, color: Colors.red),
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
