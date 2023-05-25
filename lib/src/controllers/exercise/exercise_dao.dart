import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:odonto/src/models/exercise_model.dart';

import '../../views/utils/util.dart';

class ExerciseDao {
  adicionar(context, Exercicio ex) {
    FirebaseFirestore.instance
        .collection('exercicios')
        .add(ex.toJson())
        .then((value) => sucesso(context, 'Exercício adicionado com sucesso.'))
        .catchError(
            (e) => erro(context, 'Não foi possível adicionar o exercício'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  void atualizar(context, id, Exercicio ex) {
    FirebaseFirestore.instance
        .collection('tarefas')
        .doc(id)
        .update(ex.toJson())
        .then((value) => sucesso(context, 'Tarefa atualizada com sucesso'))
        .catchError(
            (e) => erro(context, 'Não foi possível atualizar a tarefa.'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  listar() {
    return FirebaseFirestore.instance.collection('exercicios');
  }
}
