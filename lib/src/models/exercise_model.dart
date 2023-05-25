import 'package:cloud_firestore/cloud_firestore.dart';

class Exercicio {
  final String uid;
  final String enunciado;
  final String alternativa_a;
  final String alternativa_b;
  final String alternativa_c;
  final String alternativa_d;
  final String alternativa_correta;
  final String criado_em;
  final String atualizado_em;
  final bool status;

  Exercicio(
      this.uid,
      this.enunciado,
      this.alternativa_a,
      this.alternativa_b,
      this.alternativa_c,
      this.alternativa_d,
      this.alternativa_correta,
      this.criado_em,
      this.atualizado_em,
      this.status);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'enunciado': enunciado,
      'alternativa_a': alternativa_a,
      'alternativa_b': alternativa_b,
      'alternativa_c': alternativa_c,
      'alternativa_d': alternativa_d,
      'alternativa_correta': alternativa_correta,
      'criado_em': FieldValue.serverTimestamp(),
      'atualizado_em': FieldValue.serverTimestamp(),
      'status': status,
    };
  }

  factory Exercicio.fromJson(Map<String, dynamic> json) {
    return Exercicio(
      json['uid'],
      json['enunciado'],
      json['alternativa_a'],
      json['alternativa_b'],
      json['alternativa_c'],
      json['alternativa_d'],
      json['alternativa_correta'],
      json['criado_em'],
      json['atualizado_em'],
      json['status'],
    );
  }
}
