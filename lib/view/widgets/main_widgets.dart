import 'package:flutter/material.dart';
import 'package:marlo_task/constants/constants.dart';
import 'package:marlo_task/controller/transaction_provider.dart';

Widget mainCard(String image, String title, String subtitle) {
  return Card(
    color: Colors.white,
    elevation: 0,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage(image),
          ),
          kHeight10,
          Text(title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              )),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          )
        ],
      ),
    ),
  );
}

Widget moneyInAndOutWidget(TransactionProvider provider) {
  return Container(
    height: 90,
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Money in and out - 2",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  provider.moneyInOutFunction(provider.moneyInOut[0]);
                },
                child: filterContainer1(
                    contains:
                        provider.moneyInOutadd.contains(provider.moneyInOut[0]),
                    text: provider.moneyInOut[0]),
              ),
              kHeight10,
              InkWell(
                onTap: () {
                  provider.moneyInOutFunction(provider.moneyInOut[1]);
                },
                child: filterContainer1(
                    contains:
                        provider.moneyInOutadd.contains(provider.moneyInOut[1]),
                    text: provider.moneyInOut[1]),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget filterContainer1({required bool contains, required String text}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:
            contains ? const Color.fromARGB(255, 218, 243, 255) : Colors.white),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: contains
                  ? const Color.fromARGB(255, 51, 185, 247)
                  : Colors.grey,
              fontSize: 13),
        ),
      ),
    ),
  );
}

Widget filterContainer2({required bool contains, required String text}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:
            contains ? const Color.fromARGB(255, 218, 243, 255) : Colors.white),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
      child: Center(
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                  color: contains
                      ? const Color.fromARGB(255, 51, 185, 247)
                      : Colors.grey,
                  fontSize: 13),
            ),
            const Icon(
              Icons.close,
              size: 13,
              color: Color.fromARGB(255, 51, 185, 247),
            )
          ],
        ),
      ),
    ),
  );
}

Widget statusesWidget(TransactionProvider provider) {
  return Container(
    height: 120,
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Statuses - 3',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              InkWell(
                  onTap: () {
                    provider.statusFunction(provider.statuses[0]);
                  },
                  child: filterContainer1(
                      contains:
                          provider.statusAdd.contains(provider.statuses[0]),
                      text: provider.statuses[0])),
              const SizedBox(
                width: 8,
              ),
              InkWell(
                  onTap: () {
                    provider.statusFunction(provider.statuses[1]);
                  },
                  child: filterContainer1(
                      contains:
                          provider.statusAdd.contains(provider.statuses[1]),
                      text: provider.statuses[1])),
              const SizedBox(
                width: 8,
              ),
              InkWell(
                  onTap: () {
                    provider.statusFunction(provider.statuses[2]);
                  },
                  child: filterContainer1(
                      contains:
                          provider.statusAdd.contains(provider.statuses[2]),
                      text: provider.statuses[2])),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget amountWidget(TransactionProvider provider) {
  return Container(
    height: 100,
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Amount',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 45,
                width: 150,
                child: TextField(
                  controller: provider.minimumController,
                  cursorColor: const Color.fromARGB(255, 218, 243, 255),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Minimum',
                      hintStyle:
                          const TextStyle(fontSize: 12, color: Colors.grey),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 234, 234, 234),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(
                height: 45,
                width: 150,
                child: TextField(
                  controller: provider.maximumController,
                  cursorColor: const Color.fromARGB(255, 218, 243, 255),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Maximum',
                      hintStyle:
                          const TextStyle(fontSize: 12, color: Colors.grey),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 234, 234, 234),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none)),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
