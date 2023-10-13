import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marlo_task/controller/transaction_provider.dart';
import 'package:provider/provider.dart';

class TransactionListWidget extends StatelessWidget {
  const TransactionListWidget({super.key});
  String formatDate(DateTime dateTime) {
    final formatter = DateFormat('MMMM d, y - h:mm a');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TransactionProvider>(context, listen: false)
          .fetchTransactionData();
    });
    return SizedBox(
      height: 220,
      child: Consumer<TransactionProvider>(builder: (context, value, child) {
        if (value.transaction != null && value.transaction!.isNotEmpty) {
          return ListView.builder(
              itemBuilder: (context, index) {
                final DateTime creationDate =
                    DateTime.parse(value.transaction![index].createdAt!);
                return Card(
                  elevation: 0,
                  color: Colors.white,
                  child: ListTile(
                    title: Text(
                      value.transaction![index].description!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      formatDate(creationDate),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: value.transaction![index].amount![0] != '-'
                          ? Text(
                              value.transaction![index].amount!,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.green),
                            )
                          : Text(
                              value.transaction![index].amount!,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                    ),
                    leading: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 6, 50, 87)),
                        child: Center(
                          child: Icon(
                            getIconForTransactionType(
                                value.transaction![index].transactionType!),
                            color: Colors.white,
                          ),
                        )),
                  ),
                );
              },
              itemCount: value.transaction!.length);
        } else {
          return const Center(
            child: Text(
              'No Transactions Found!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }
      }),
    );
  }
}

IconData getIconForTransactionType(String transactionType) {
  switch (transactionType) {
    case "CONVERSION_BUY":
      return Icons.north_west_rounded;
    case "CONVERSION_SELL":
      return Icons.north_east_rounded;
    case "PAYOUT":
      return Icons.payment;
    default:
      return Icons.error;
  }
}
