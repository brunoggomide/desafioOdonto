import 'package:flutter/material.dart';

class Answers extends StatefulWidget {
  const Answers({Key? key}) : super(key: key);

  @override
  State<Answers> createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  String? answer1;
  String? answer2;

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
          'Exercícios',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '01 - Qual a fórmula da água?',
                style: TextStyle(fontSize: 18),
              ),
              RadioListTile(
                title: const Text('A) O2'),
                value: 'A',
                groupValue: answer1,
                onChanged: (value) {
                  setState(() {
                    answer1 = value as String?;
                  });
                },
              ),
              RadioListTile(
                title: const Text('B) H2O'),
                value: 'B',
                groupValue: answer1,
                onChanged: (value) {
                  setState(() {
                    answer1 = value as String?;
                  });
                },
              ),
              RadioListTile(
                title: const Text('C) H2'),
                value: 'C',
                groupValue: answer1,
                onChanged: (value) {
                  setState(() {
                    answer1 = value as String?;
                  });
                },
              ),
              RadioListTile(
                title: const Text('D) AU'),
                value: 'D',
                groupValue: answer1,
                onChanged: (value) {
                  setState(() {
                    answer1 = value as String?;
                  });
                },
              ),
              const Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              const SizedBox(height: 15),
              Text(
                '02 - Qual a capital do Chile?',
                style: TextStyle(fontSize: 18),
              ),
              RadioListTile(
                title: const Text('A) Rio de Janeiro'),
                value: 'A',
                groupValue: answer2,
                onChanged: (value) {
                  setState(() {
                    answer2 = value as String?;
                  });
                },
              ),
              RadioListTile(
                title: const Text('B) São Paulo'),
                value: 'B',
                groupValue: answer2,
                onChanged: (value) {
                  setState(() {
                    answer2 = value as String?;
                  });
                },
              ),
              RadioListTile(
                title: const Text('C) Buenos Aires'),
                value: 'C',
                groupValue: answer2,
                onChanged: (value) {
                  setState(() {
                    answer2 = value as String?;
                  });
                },
              ),
              RadioListTile(
                title: const Text('D) Santiago'),
                value: 'D',
                groupValue: answer2,
                onChanged: (value) {
                  setState(() {
                    answer2 = value as String?;
                  });
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Enviar',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
