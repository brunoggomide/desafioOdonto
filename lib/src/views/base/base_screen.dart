import 'package:flutter/material.dart';
import 'package:odonto/src/views/exercise/exercise.dart';
import 'package:odonto/src/views/infos/info.dart';
import 'package:odonto/src/views/profile/profile.dart';
import 'package:odonto/src/views/students/students.dart';

import '../../controllers/auth/auth_controller.dart';
import '../home/home.dart';
import '../tasks/tasks.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int currentIndex = 0;

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: AuthController().isProfessor(),
      builder: (context, snapshot) {
        final isProfessor = snapshot.data ?? false;

        return Scaffold(
          body: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: isProfessor
                ? const [
                    Home(),
                    Exercise(),
                    Students(),
                    Info(),
                    Profile(),
                  ]
                : const [
                    Home(),
                    Tasks(),
                    Info(),
                    Profile(),
                  ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
                pageController.jumpToPage(index);
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.blue,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withAlpha(100),
            items: isProfessor
                ? const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.task), label: 'Exercícios'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person_search), label: 'Alunos'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.info_outline), label: 'Sobre'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person_outline), label: 'Perfil'),
                  ]
                : const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.task), label: 'Tarefas'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.info_outline), label: 'Sobre'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person_outline), label: 'Perfil'),
                  ],
          ),
        );
      },
    );
  }
}
