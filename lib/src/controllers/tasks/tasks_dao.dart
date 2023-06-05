import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/answers_model.dart';
import '../../views/utils/util.dart';

class TasksDao {
  Future<bool> adicionar(BuildContext context, AnswersModel a) async {
    try {
      await FirebaseFirestore.instance.collection('respostas').add(a.toJson());
      sucesso(context, 'Respostas enviadas com sucesso.');
      return true;
    } catch (e) {
      erro(context, 'Não foi possível responder a atividade');
      return false;
    }
  }

  listar() {
    return FirebaseFirestore.instance.collection('respostas');
  }
}
