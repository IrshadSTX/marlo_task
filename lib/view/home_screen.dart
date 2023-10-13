import 'package:flutter/material.dart';
import 'package:marlo_task/constants/constants.dart';
import 'package:marlo_task/view/all_transcations_screen.dart';
import 'package:marlo_task/view/widgets/gradient_card_widget.dart';
import 'package:marlo_task/view/widgets/main_widgets.dart';
import 'package:marlo_task/view/widgets/navbar_widget.dart';
import 'package:marlo_task/view/widgets/transaction_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 241, 242),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 240, 241, 242),
        leading: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 253, 164, 48),
                borderRadius: BorderRadius.circular(14),
                border:
                    Border.all(color: const Color.fromARGB(255, 175, 95, 4))),
            child: const Center(
                child: Text(
              "JB",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            )),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_sharp,
                color: Colors.blue,
                size: 30,
              ))
        ],
      ),
      bottomNavigationBar: const NavbarWidget(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            SizedBox(
              height: 140,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return mainCard("assets/images/british-flag.png",
                        "15,256,486.00", "British pound");
                  } else if (index == 1) {
                    return mainCard("assets/images/us-flag.png",
                        "20,443,776.00", "Us dollar");
                  } else {
                    return mainCard("assets/images/canada-flag.png",
                        "18,543,990.00", "Canada");
                  }
                },
                itemCount: 3,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "To do 4",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  )),
            ),
            const SizedBox(
              height: 140,
              child: GradiantCard(),
            ),
            kHeight10,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    const Text(
                      "All transactions",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AllTransactionScreen(),
                        ));
                      },
                      child: const Text(
                        "See all",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const TransactionListWidget()
          ],
        ),
      )),
    );
  }
}

Widget mainGradiant(
    Color color1, Color color2, Color iconcolor, IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)),
      height: 100,
      width: 150,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: color2,
              child: Center(
                  child: Icon(
                icon,
                color: iconcolor,
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13),
              ),
            )
          ]),
    ),
  );
}
