import 'package:flutter/material.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/exercise/exercise_dao.dart';
import '../../models/exercise_model.dart';

class EditExercise extends StatefulWidget {
  const EditExercise({
    Key? key,
    required this.item,
  }) : super(key: key);

  final dynamic item;

  @override
  State<EditExercise> createState() => _EditExerciseState();
}

class _EditExerciseState extends State<EditExercise> {
  String? selectedCorrectAlternative;
  bool isActive = true;
  var txtEnunciado = TextEditingController();
  var txtAlternativa_a = TextEditingController();
  var txtAlternativa_b = TextEditingController();
  var txtAlternativa_c = TextEditingController();
  var txtAlternativa_d = TextEditingController();

  Widget buildAlternativeCheckbox(String alternative) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: alternative,
          groupValue: selectedCorrectAlternative,
          onChanged: (value) {
            setState(() {
              selectedCorrectAlternative = value;
            });
          },
        ),
        Text(alternative),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    txtEnunciado.text = widget.item['enunciado'];
    txtAlternativa_a.text = widget.item['alternativa_a'];
    txtAlternativa_b.text = widget.item['alternativa_b'];
    txtAlternativa_c.text = widget.item['alternativa_c'];
    txtAlternativa_d.text = widget.item['alternativa_d'];
    selectedCorrectAlternative = widget.item['alternativa_correta'];
    isActive = widget.item['status'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Editar exercício',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: txtEnunciado,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Enunciado',
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: txtAlternativa_a,
                        decoration: InputDecoration(
                          labelText: 'Alternativa A',
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: txtAlternativa_b,
                        decoration: InputDecoration(
                          labelText: 'Alternativa B',
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: txtAlternativa_c,
                        decoration: InputDecoration(
                          labelText: 'Alternativa C',
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: txtAlternativa_d,
                        decoration: InputDecoration(
                          labelText: 'Alternativa D',
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Text('Alternativa Correta: '),
                          buildAlternativeCheckbox('A'),
                          buildAlternativeCheckbox('B'),
                          buildAlternativeCheckbox('C'),
                          buildAlternativeCheckbox('D'),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SwitchListTile(
                        title: const Text('Ativo'),
                        value: isActive,
                        onChanged: (value) {
                          setState(() {
                            isActive = value;
                          });
                        },
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    side: const BorderSide(
                                        width: 2, color: Colors.red),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Cancelar',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.red),
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
                                    side: const BorderSide(
                                        width: 2, color: Colors.green),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      widget.item['enunciado'] =
                                          txtEnunciado.text;
                                      widget.item['alternativa_a'] =
                                          txtAlternativa_a.text;
                                      widget.item['alternativa_b'] =
                                          txtAlternativa_b.text;
                                      widget.item['alternativa_c'] =
                                          txtAlternativa_c.text;
                                      widget.item['alternativa_d'] =
                                          txtAlternativa_d.text;
                                      widget.item['alternativa_correta'] =
                                          selectedCorrectAlternative;
                                      widget.item['status'] = isActive;
                                    });
                                    if (txtEnunciado.text.isEmpty ||
                                        txtAlternativa_a.text.isEmpty ||
                                        txtAlternativa_b.text.isEmpty ||
                                        txtAlternativa_c.text.isEmpty ||
                                        txtAlternativa_d.text.isEmpty ||
                                        selectedCorrectAlternative == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red[300],
                                          content: const Text(
                                            'Preencha todos os campos',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          duration: const Duration(seconds: 3),
                                        ),
                                      );
                                    } else {
                                      var e = Exercicio(
                                        AuthController().idUsuario(),
                                        txtEnunciado.text,
                                        txtAlternativa_a.text,
                                        txtAlternativa_b.text,
                                        txtAlternativa_c.text,
                                        txtAlternativa_d.text,
                                        selectedCorrectAlternative.toString(),
                                        '',
                                        '',
                                        isActive,
                                      );
                                      txtEnunciado.clear();
                                      txtAlternativa_a.clear();
                                      txtAlternativa_b.clear();
                                      txtAlternativa_c.clear();
                                      txtAlternativa_d.clear();
                                      ExerciseDao().atualizar(context, e);
                                    }
                                  },
                                  child: const Text(
                                    'Salvar',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.green),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
