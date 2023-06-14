import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../views/auth/sign_in.dart';
import '../../views/base/base_screen.dart';
import '../../views/utils/util.dart';

class AuthController {
  // CRIAR CONTA de um novo Usuário
  criarConta(context, nome, email, senha, cod) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((res) {
      //Enviar confirmação do e-mail
      // res.user!.sendEmailVerification();

      FirebaseFirestore.instance.collection('usuarios').add({
        'uid': res.user!.uid,
        'nome': nome,
        'email': email,
        'codigo': cod,
      });

      sucesso(context, 'Verifique seu e-mail para ativar seu cadastro');
      Navigator.of(context).pop();
    }).catchError((e) {
      switch (e.code) {
        case 'email-already-in-use':
          erro(context, 'O usuário já foi cadastrado.');
          break;
        case 'invalid-email':
          erro(context, 'O formato do e-mail é inválido.');
          break;
        default:
          erro(context, 'ERRO: ${e.code.toString()}');
      }
    });
  }

  //LOGIN do usuário
  login(context, email, senha) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((res) {
      // if (res.user!.emailVerified) {
      sucesso(context, 'Usuário autenticado com sucesso!');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: ((c) {
            return const BaseScreen();
          }),
        ),
      );
    })
        // } else {
        //   erro(context, 'O endereço de e-mail não foi confirmado.');
        // }
        // })
        .catchError((e) {
      switch (e.code) {
        case 'user-not-found':
          erro(context, 'Usuário não encontrado.');
          break;
        case 'wrong-password':
          erro(context, 'Senha incorreta.');
          break;
        default:
          erro(context, 'ERRO: ${e.code.toString()}');
      }
    });
  }

  //Recuperar senha
  esqueceuSenha(context, String email) {
    if (email.isNotEmpty) {
      FirebaseAuth.instance
          .sendPasswordResetEmail(
        email: email,
      )
          .then((res) {
        sucesso(context, 'E-mail enviado com sucesso.');
      }).catchError((e) {
        switch (e.code) {
          case 'invalid-email':
            erro(context, 'O formato do email é inválido.');
            break;
          case 'user-not-found':
            erro(context, 'Usuário não encontrado.');
            break;
          default:
            erro(context, e.code.toString());
        }
      });
    }
  }

  //Logout
  logout(context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (c) {
          return SignIn();
        },
      ),
    );
  }

  //ID DO USUARIO
  idUsuario() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  // NOME do Usuário Logado
  Future<String> getNome() async {
    var nome = '';
    await FirebaseFirestore.instance
        .collection('usuarios')
        .where('uid', isEqualTo: idUsuario())
        .get()
        .then(
      (resultado) {
        nome = resultado.docs[0].data()['nome'] ?? '';
      },
    );
    return nome;
  }

  // EMAIL do usuário logado
  Future<String> getEmail() async {
    var email = '';
    await FirebaseFirestore.instance
        .collection('usuarios')
        .where('uid', isEqualTo: idUsuario())
        .get()
        .then(
      (resultado) {
        email = resultado.docs[0].data()['email'] ?? '';
      },
    );
    return email;
  }

  Future<bool> isProfessor() async {
    final email = await getEmail();
    return email.endsWith('@unaerp.br');
  }
}
