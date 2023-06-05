import 'package:cloud_firestore/cloud_firestore.dart';

class AnswersModel {
  final String uid;
  final String eid;
  final String alternativa_selecionada;
  final String alternativa_correta;
  final String respondido_em;

  AnswersModel(this.uid, this.eid, this.alternativa_selecionada,
      this.alternativa_correta, this.respondido_em);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'eid': eid,
      'alternativa_selecionada': alternativa_selecionada,
      'alternativa_correta': alternativa_correta,
      'respondido_em': FieldValue.serverTimestamp(),
    };
  }

  factory AnswersModel.fromJson(Map<String, dynamic> json) {
    return AnswersModel(
      json['uid'],
      json['eid'],
      json['alternativa_selecionada'],
      json['alternativa_correta'],
      json['respondido_em'],
    );
  }
}
