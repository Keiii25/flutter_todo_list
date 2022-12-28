import 'package:flutter_todo_list/misc/controllers/shared_preference_controller.dart';
import 'package:flutter_todo_list/todo_list/models/todo_item_model.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  RxList<TodoItemModel> todoList = <TodoItemModel>[].obs;
  RxInt selectedItemIndex = 0.obs; // stores the current todo item index in the list for editing;
  final sharedPreferencesController = SharedPreferencesController();

  void addTodoItem(String name, DateTime startDate, DateTime endDate) {
    final todoItem =
        new TodoItemModel(name: name, startDate: startDate, endDate: endDate, status: false);
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
