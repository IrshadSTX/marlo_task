import 'package:flutter/material.dart';
import 'package:marlo_task/view/home_screen.dart';

class GradiantCard extends StatelessWidget {
  const GradiantCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          return mainGradiant(
              const Color.fromARGB(255, 245, 245, 245),
              const Color.fromARGB(255, 210, 186, 238),
              const Color.fromARGB(255, 145, 85, 212),
              Icons.document_scanner_outlined,
              'Verify your business documents');
        } else if (index == 1) {
          return mainGradiant(
              const Color.fromARGB(255, 245, 245, 245),
              const Color.fromARGB(255, 255, 206, 161),
              const Color.fromARGB(255, 182, 121, 52),
              Icons.person_pin_outlined,
              'Verify your identity');
        } else if (index == 2) {
          return mainGradiant(
              const Color.fromARGB(255, 231, 238, 237),
              const Color.fromARGB(255, 99, 201, 241),
              const Color.fromARGB(255, 35, 65, 104),
              Icons.person_pin_outlined,
              'Open a Morlo business account');
        } else if (index == 3) {
          return mainGradiant(
              const Color.fromARGB(255, 236, 253, 242),
              const Color.fromARGB(255, 97, 230, 104),
              const Color.fromARGB(255, 35, 121, 49),
              Icons.quora_outlined,
              'Get prequalified');
        }
        return null;
      },
      itemCount: 4,
      scrollDirection: Axis.horizontal,
    );
  }
}
