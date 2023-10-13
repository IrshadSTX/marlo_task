import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marlo_task/controller/services/json_data.dart';
import 'package:marlo_task/model/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  //Fetching Data
  TransactionModel? allTransaction;
  List<Transaction>? transaction;
  Future<void> fetchTransactionData() async {
    try {
      final jsonData = JsonData().jsonData;
      allTransaction = TransactionModel.fromJson(jsonData);
      transaction = allTransaction?.data;
      notifyListeners();
    } catch (e) {
      log("error fetching data");
    }
  }

  //Searching
  void search(String keyword) {
    if (keyword.isEmpty) {
      transaction = allTransaction?.data;
      notifyListeners();
    } else {
      transaction = allTransaction?.data
          ?.where((element) => element.description!
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }

  filtersearch() {
    if (allFilters.isEmpty) {
      transaction = allTransaction?.data;
      notifyListeners();
    } else {
      List<Transaction>? settledIn;
      List<Transaction>? cancelledIn;
      List<Transaction>? pendingIn;
      List<Transaction>? pendingOut;
      List<Transaction>? settledOut;
      List<Transaction>? cancelledOut;
      List<Transaction>? settled;
      List<Transaction>? cancelled;
      List<Transaction>? pending;
      List<Transaction>? moneyNull;
      List<Transaction>? moneyInTrue;
      List<Transaction>? moneyOutTrue;
      List<Transaction>? amountRangeSettled;
      List<Transaction>? amountRangeSettledIn;
      List<Transaction>? amountRangeSettledOut;
      List<Transaction>? amountRangePending;
      List<Transaction>? amountRangePendingIn;
      List<Transaction>? amountRangePendingOut;
      List<Transaction>? amountRangeCancel;
      List<Transaction>? amountRangeCancelIn;
      List<Transaction>? amountRangeCancelOut;

      final moneyIn = allFilters.contains('Money in')
          ? allTransaction?.data
              ?.where((element) => isMoneyIn(element))
              .toList()
          : null;
      final moneyOut = allFilters.contains('Money out')
          ? allTransaction?.data
              ?.where((element) => isMoneyIn(element))
              .toList()
          : null;

      if (moneyIn == null && moneyOut == null) {
        settled = allFilters.contains('Completed')
            ? allTransaction?.data
                ?.where((element) => element.status == "SETTLED")
                .toList()
            : null;
        cancelled = allFilters.contains('Cancelled')
            ? allTransaction?.data
                ?.where((element) => element.status == "CANCELLED")
                .toList()
            : null;
        pending = allFilters.contains('Pending')
            ? allTransaction?.data
                ?.where((element) => element.status == "PENDING")
                .toList()
            : null;

        if (minimumController.text.isNotEmpty &&
            maximumController.text.isNotEmpty) {
          final minInt = int.parse(minimumController.text);
          final maxInt = int.parse(maximumController.text);
          amountRangeSettled = settled
              ?.where((element) =>
                  double.parse(element.amount!.replaceAll(',', '')).abs() >
                      minInt &&
                  double.parse(element.amount!.replaceAll(',', '')).abs() <
                      maxInt)
              .toList();
          amountRangeCancel = cancelled
              ?.where((element) =>
                  double.parse(element.amount!.replaceAll(',', '')).abs() >
                      minInt &&
                  double.parse(element.amount!.replaceAll(',', '')).abs() <
                      maxInt)
              .toList();
          amountRangePending = pending
              ?.where((element) =>
                  double.parse(element.amount!.replaceAll(',', '')).abs() >
                      minInt &&
                  double.parse(element.amount!.replaceAll(',', '')).abs() <
                      maxInt)
              .toList();
          moneyNull = [
            ...?amountRangeSettled,
            ...?amountRangeCancel,
            ...?amountRangePending
          ];
        } else {
          moneyNull = [...?settled, ...?cancelled, ...?pending];
        }
        notifyListeners();
      }

      if (moneyIn != null) {
        settledIn = allFilters.contains('Completed')
            ? moneyIn.where((element) => element.status == "SETTLED").toList()
            : null;
        cancelledIn = allFilters.contains('Cancelled')
            ? moneyIn.where((element) => element.status == "CANCELLED").toList()
            : null;
        pendingIn = allFilters.contains('Pending')
            ? moneyIn.where((element) => element.status == "PENDING").toList()
            : null;
        if (settledIn == null && cancelledIn == null && pendingIn == null) {
          if (minimumController.text.isNotEmpty &&
              maximumController.text.isNotEmpty) {
            final minInt = int.parse(minimumController.text);
            final maxInt = int.parse(maximumController.text);
            final moneyInRange = moneyIn
                .where((element) =>
                    double.parse(element.amount!.replaceAll(',', '')).abs() >
                        minInt &&
                    double.parse(element.amount!.replaceAll(',', '')).abs() <
                        maxInt)
                .toList();
            moneyInTrue = moneyInRange;
          } else {
            moneyInTrue = moneyIn;
          }
        } else {
          if (minimumController.text.isNotEmpty &&
              maximumController.text.isNotEmpty) {
            final minint = int.parse(minimumController.text);
            final maxint = int.parse(maximumController.text);
            amountRangeSettledIn = settledIn
                ?.where((element) =>
                    double.parse(element.amount!.replaceAll(',', '')).abs() >
                        minint &&
                    double.parse(element.amount!.replaceAll(',', '')).abs() <
                        maxint)
                .toList();
            amountRangeCancelIn = cancelledIn
                ?.where((element) =>
                    double.parse(element.amount!.replaceAll(',', '')).abs() >
                        minint &&
                    double.parse(element.amount!.replaceAll(',', '')).abs() <
                        maxint)
                .toList();
            amountRangePendingIn = pendingIn
                ?.where((element) =>
                    double.parse(element.amount!.replaceAll(',', '')).abs() >
                        minint &&
                    double.parse(element.amount!.replaceAll(',', '')).abs() <
                        maxint)
                .toList();
            moneyInTrue = [
              ...?amountRangeSettledIn,
              ...?amountRangeCancelIn,
              ...?amountRangePendingIn
            ];
          } else {
            moneyInTrue = [...?settledIn, ...?cancelledIn, ...?pendingIn];
          }
        }

        notifyListeners();
      }

      if (moneyOut != null) {
        settledOut = allFilters.contains('Completed')
            ? moneyOut.where((element) => element.status == "SETTLED").toList()
            : null;
        pendingOut = allFilters.contains('Pending')
            ? moneyOut.where((element) => element.status == "PENDING").toList()
            : null;
        cancelledOut = allFilters.contains('Cancelled')
            ? allTransaction?.data
                ?.where((element) =>
                    element.status == "CANCELLED" && !isMoneyIn(element))
                .toList()
            : null;
        if (settledOut == null && cancelledOut == null && pendingOut == null) {
          if (minimumController.text.isNotEmpty &&
              maximumController.text.isNotEmpty) {
            final minInt = int.parse(minimumController.text);
            final maxInt = int.parse(maximumController.text);
            final moneyoutrange = moneyOut
                .where((element) =>
                    double.parse(element.amount!.replaceAll(',', '')).abs() >
                        minInt &&
                    double.parse(element.amount!.replaceAll(',', '')).abs() <
                        maxInt)
                .toList();
            moneyOutTrue = moneyoutrange;
          } else {
            moneyOutTrue = moneyOut;
          }
        } else {
          if (minimumController.text.isNotEmpty &&
              maximumController.text.isNotEmpty) {
            final minint = int.parse(minimumController.text);
            final maxint = int.parse(maximumController.text);
            amountRangeSettledOut = settledOut
                ?.where((element) =>
                    double.parse(element.amount!.replaceAll(',', '')).abs() >
                        minint &&
                    double.parse(element.amount!.replaceAll(',', '')).abs() <
                        maxint)
                .toList();
            amountRangeCancelOut = cancelledOut
                ?.where((element) =>
                    double.parse(element.amount!.replaceAll(',', '')).abs() >
                        minint &&
                    double.parse(element.amount!.replaceAll(',', '')).abs() <
                        maxint)
                .toList();
            amountRangePendingOut = pendingOut
                ?.where((element) =>
                    double.parse(element.amount!.replaceAll(',', '')).abs() >
                        minint &&
                    double.parse(element.amount!.replaceAll(',', '')).abs() <
                        maxint)
                .toList();
            moneyOutTrue = [
              ...?amountRangeSettledOut,
              ...?amountRangeCancelOut,
              ...?amountRangePendingOut
            ];
          } else {
            moneyOutTrue = [...?settledOut, ...?cancelledOut, ...?pendingOut];
          }
        }

        notifyListeners();
      }

      final transactions = <dynamic>{
        ...?moneyNull,
        ...?moneyInTrue,
        ...?moneyOutTrue
      };
      transaction = transactions.cast<Transaction>().toList();
      notifyListeners();
    }
  }

  //******************************filtering*********************************
  List<String> allFilters = [];
  DateTimeRange? dateTimeRange;
  //******money In and Out
  List<String> moneyInOut = ['Money in', 'Money out'];
  List<String> moneyInOutadd = [];
  moneyInOutFunction(String value) {
    if (!moneyInOutadd.contains(value)) {
      moneyInOutadd.add(value);
      notifyListeners();
    } else {
      moneyInOutadd.remove(value);
      notifyListeners();
    }
  }

  bool isMoneyIn(Transaction moneyInOut) {
    return moneyInOut.transactionType == "CONVERSION_BUY";
  }

  //******statuses
  TextEditingController minimumController = TextEditingController();
  TextEditingController maximumController = TextEditingController();
  List<String> statusAdd = [];
  List<String> statuses = ['Completed', 'Pending', 'Cancelled'];
  statusFunction(value) {
    if (!statusAdd.contains(value)) {
      statusAdd.add(value);
      notifyListeners();
    } else {
      statusAdd.remove(value);
      notifyListeners();
    }
  }

  //******time range
  List<String> timeRangeAdd = [];
  String? createCustomRange;
  List<String> timeRange = [
    'Today',
    'This week',
    'This month',
    'This quarter',
    'custom'
  ];
  timeRangeFuntion(value) {
    if (!timeRangeAdd.contains(value)) {
      timeRangeAdd.add(value);
      notifyListeners();
    } else {
      timeRangeAdd.remove(value);
      notifyListeners();
    }
  }

  //******Complete filtering******

  runFilter() {
    allFilters = [...moneyInOutadd, ...statusAdd, ...timeRangeAdd];
    if (minimumController.text.isNotEmpty &&
        maximumController.text.isNotEmpty) {
      allFilters
          .add("min ${minimumController.text} - max ${maximumController.text}");
    }
    if (dateTimeRange != null) {
      final dateTime = DateTime.parse(dateTimeRange!.start.toString());
      String formatedDate = DateFormat('d MMMM').format(dateTime);
      final dateTime2 = DateTime.parse(dateTimeRange!.end.toString());
      String formatedDate2 = DateFormat('d MMMM').format(dateTime2);

      allFilters.add("$formatedDate - $formatedDate2");
    }
    notifyListeners();
    log(allFilters.toString());
  }

  removeFilter(index) {
    if (allFilters[index] ==
        "min ${minimumController.text} - max ${maximumController.text}") {
      minimumController.clear();
      maximumController.clear();
    }

    allFilters.removeAt(index);
    minimumController.clear();
    maximumController.clear();
    notifyListeners();
  }

  newDateTimeRange(DateTimeRange newDate) {
    dateTimeRange = newDate;
    final dateTime = DateTime.parse(dateTimeRange!.start.toString());
    String formatedDate = DateFormat('d MMMM').format(dateTime);
    final dateTime2 = DateTime.parse(dateTimeRange!.end.toString());
    String formatedDate2 = DateFormat('d MMMM').format(dateTime2);

    createCustomRange = "$formatedDate - $formatedDate2";
    timeRange.removeLast();
    timeRange.add(createCustomRange!);
    notifyListeners();
  }

  disposeFilter() {
    minimumController.clear();
    maximumController.clear();
    moneyInOutadd.clear();
    timeRangeAdd.clear();
    statusAdd.clear();
    allFilters.clear();
    dateTimeRange = null;
    timeRange.removeLast();
    timeRange.add('custom');
    createCustomRange = null;
    notifyListeners();
  }
}
