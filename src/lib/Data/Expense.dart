// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:wealthwatch/Authentication/register.dart';
// import 'package:wealthwatch/Pages/addExpense.dart';

class Expense {
  String name;
  int expenseAmount;
  DateTime datetime;
  String id;
  Expense(
      {required this.name,
      required this.expenseAmount,
      required this.datetime,
      this.id = ' '});
}

class ExpenseList {
  //final test1 = Expense(name: '', expenseAmount: 0);

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
final catEducation = ExpenseList();
final catMiscellaneous = ExpenseList();
final catHealth = ExpenseList();
final catEntertainment = ExpenseList();
final catHousing = ExpenseList();

class Income {
  int incomeAmount;
  Income({required this.incomeAmount});
}

class IncomeList {
  List<Income> incomeListItems = [];

  addIncomeToList(Income income) {
    incomeListItems.add(income);
  }

  deleteIncomeFromList(Income income) {
    incomeListItems.remove(income);
  }

  List<int> getIncomeNumber() {
    return incomeListItems.map((income) => income.incomeAmount).toList();
  }

  int getTotalIncomeAmount() {
    List<int> incomeAmounts = getIncomeNumber();
    return incomeAmounts.fold(
        0, (previousValue, element) => previousValue + element);
  }
}

final catDeposit = IncomeList();
final catRent = IncomeList();
final catSalary = IncomeList();
