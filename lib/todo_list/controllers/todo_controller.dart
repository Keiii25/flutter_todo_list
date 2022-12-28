import 'package:flutter/material.dart';
import 'package:flutter_todo_list/todo_list/models/todo_item_model.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  RxList<TodoItemModel> todoList = <TodoItemModel>[].obs;
  RxInt selectedItemIndex = 0.obs;
  BuildContext? context;

  void addTodoItem(String name, DateTime startDate, DateTime endDate) {
    final todoItem =
        new TodoItemModel(name: name, startDate: startDate, endDate: endDate);
    todoList.add(todoItem);
  }

  void editTodoItem(String? name, DateTime? startDate, DateTime? endDate) {
    if (name != null) {
      todoList[selectedItemIndex.value].name = name;
    }
    if (startDate != null) {
      todoList[selectedItemIndex.value].startDate = startDate;
    }

    if (endDate != null) {
      todoList[selectedItemIndex.value].endDate = endDate;
    }
    todoList.refresh();
  }
}
