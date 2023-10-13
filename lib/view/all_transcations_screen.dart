import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marlo_task/constants/constants.dart';
import 'package:marlo_task/controller/transaction_provider.dart';
import 'package:marlo_task/view/widgets/main_widgets.dart';
import 'package:marlo_task/view/widgets/transaction_list_widget.dart';
import 'package:provider/provider.dart';

class AllTransactionScreen extends StatelessWidget {
  const AllTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TransactionProvider>(context, listen: false)
          .fetchTransactionData();
    });
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 247, 253, 255),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.download,
                color: Colors.black,
              )),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 247, 253, 255),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 14.0, bottom: 10),
              child: Text(
                'Transactions',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            kHeight10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 300,
                  child: Consumer<TransactionProvider>(
                    builder: (context, provider, child) =>
                        CupertinoSearchTextField(
                      placeholder: 'Enter text',
                      controller: searchController,
                      onChanged: (value) {
                        provider.search(value);
                      },
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                          child: Container(
                            height: 700,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 247, 247, 247),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                topRight: Radius.circular(25.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              child: Consumer<TransactionProvider>(
                                builder: (context, provider, child) => ListView(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Filter",
                                          style: TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              provider.disposeFilter();
                                            },
                                            child: const Text("Clear",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.w500)))
                                      ],
                                    ),
                                    kHeight10,
                                    moneyInAndOutWidget(provider),
                                    kheight20,
                                    statusesWidget(provider),
                                    kheight20,
                                    amountWidget(provider),
                                    kheight20,
                                    kheight20,
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            provider.disposeFilter();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 218, 243, 255),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              padding: const EdgeInsets.only(
                                                  top: 15, bottom: 15)),
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 51, 185, 247)),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          provider.runFilter();
                                          Navigator.of(context).pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 51, 185, 247),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            padding: const EdgeInsets.only(
                                                top: 15, bottom: 15)),
                                        child: const Text(
                                          'Apply',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: const CustomBox()),
              ],
            ),
            kheight20,
            Consumer<TransactionProvider>(
              builder: (context, value, child) {
                if (value.allFilters.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: 40,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () {
                                value.removeFilter(index);
                              },
                              child: filterContainer2(
                                  contains: true,
                                  text: value.allFilters[index]),
                            ),
                          );
                        },
                        itemCount: value.allFilters.length,
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            const Expanded(child: TransactionListWidget())
          ],
        ),
      ),
    );
  }
}

class CustomBox extends StatelessWidget {
  const CustomBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 236, 238, 237),
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6), // Shadow color
            ),
          ],
        ),
        child: const SizedBox(
          width: 35,
          height: 35,
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(
              Icons.filter_alt_rounded,
              color: Color.fromARGB(255, 157, 158, 158),
            ),
          ),
        ));
  }

  Future datePicker(BuildContext context) async {
    DateTimeRange? newDateTime = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
      currentDate: DateTime.now(),
      helpText: 'Custom time range',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromARGB(255, 218, 243, 255),
          ),
          child: Builder(builder: (BuildContext context) {
            return child!;
          }),
        );
      },
    );

    if (newDateTime != null) {
      Provider.of<TransactionProvider>(context, listen: false)
          .newDateTimeRange(newDateTime);
    }
  }
}
