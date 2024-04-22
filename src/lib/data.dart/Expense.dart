import 'package:wealthwatch/Pages/addExpense.dart';

class Expense {
  late String name;
  late int expenseAmount;

  Expense() {
    name = '';
    expenseAmount = 0;
  }
  addExpense(String x, int y) {
    name = x;
    expenseAmount = y;
  }
}

class ExpenseList {
  List<Expense> expenseListItems = [];

  addExpenseToList(Expense expense) {
    expenseListItems.add(expense);
  }
}
