import 'package:flutter/material.dart';
import 'package:odonto/src/controllers/auth/auth_controller.dart';
import 'package:odonto/src/controllers/exercise/exercise_dao.dart';
import '../../models/exercise_model.dart';

class NewExercise extends StatefulWidget {
  const NewExercise({Key? key}) : super(key: key);

  @override
  State<NewExercise> createState() => _NewExerciseState();
}

class _NewExerciseState extends State<NewExercise> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Novo Exercício',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
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
                        maxLines: 3,
                        controller: txtEnunciado,
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
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: () {
                                if (txtEnunciado.text.isEmpty ||
                                    txtAlternativa_a.text.isEmpty ||
                                    txtAlternativa_b.text.isEmpty ||
                                    txtAlternativa_c.text.isEmpty ||
                                    txtAlternativa_d.text.isEmpty ||
                                    selectedCorrectAlternative == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red[300],
                                      content: const Text(
                                        'Preencha todos os campos',
                                        style: TextStyle(color: Colors.white),
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
                                  ExerciseDao().adicionar(context, e);
                                }
                              },
                              child: const Text(
                                "Salvar Exercício",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
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
