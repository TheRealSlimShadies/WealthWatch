import 'package:flutter/material.dart';
import 'package:wealthwatch/Pages/addExpense.dart';

class Expense {
  String name;
  int expenseAmount;
  Expense({required this.name, required this.expenseAmount});
}

class ExpenseList {
  List<Expense> expenseListItems = [];

  addExpenseToList(Expense expense) {
    expenseListItems.add(expense);
  }

  deleteExpenseFromList(Expense expense) {
    expenseListItems.remove(expense);
  }

  List<int> getExpenseNumber() {
    return expenseListItems.map((expense) => expense.expenseAmount).toList();
  }

  int getTotalExpenseAmount() {
    List<int> expenseAmounts = getExpenseNumber();
    return expenseAmounts.fold(
        0, (previousValue, element) => previousValue + element);
  }
}

final catFood = ExpenseList();
final catTransportation = ExpenseList();
final catEntertainment = ExpenseList();
final catHousing = ExpenseList();
final catMiscellaneous = ExpenseList();
final catHealth = ExpenseList();
final catEducation = ExpenseList();
