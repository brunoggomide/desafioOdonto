import 'package:cloud_firestore/cloud_firestore.dart';

class StudentsDao {
  listar() {
    return FirebaseFirestore.instance
        .collection('usuarios')
        .where('codigo', isNotEqualTo: '000000');
  }
}
