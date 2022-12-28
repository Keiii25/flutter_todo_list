import 'package:flutter/material.dart';
import 'package:flutter_todo_list/misc/constants.dart';
import 'package:flutter_todo_list/todo_list/controllers/todo_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_todo_list/l10n/l10n.dart';
import 'package:intl/intl.dart';

import 'package:flutter_todo_list/misc/enums.dart';
import 'package:flutter_todo_list/misc/widgets/appbar.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final todoController = Get.find<TodoController>();
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final todoList = todoController.todoList;
    return Scaffold(
        appBar: GenericAppBar(title: l10n.todoList, shouldNotGoBack: true),
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.fromLTRB(2, 2, 2, 0),
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: todoList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, int index) {
                      return todoList.length <= 0
                          ? Center(child: Text(l10n.noTodoItems))
                          : Column(
                              children: [
                                InkWell(
                                  onTap: () => _onTodoItemTapped(index),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: kLightGreyB0B0B0,
                                            offset: const Offset(0.0, 0.0),
                                            blurRadius: 4,
                                            spreadRadius: 1,
                                          ),
                                        ]),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 16, 16, 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                todoList[index].name,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 16),
                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(l10n.startDate,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.6),
                                                          )),
                                                      SizedBox(height: 4),
                                                      Text(
                                                          DateFormat(
                                                                  'dd MMM yyyy')
                                                              .format(todoList[
                                                                      index]
                                                                  .startDate),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(l10n.endDate,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.6),
                                                          )),
                                                      SizedBox(height: 4),
                                                      Text(
                                                          DateFormat(
                                                                  'dd MMM yyyy')
                                                              .format(todoList[
                                                                      index]
                                                                  .endDate),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(l10n.timeLeft,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.6),
                                                          )),
                                                      SizedBox(height: 4),
                                                      CountDownTimer(
                                                          startDate:
                                                              todoList[index]
                                                                  .startDate,
                                                          endDate:
                                                              todoList[index]
                                                                  .endDate),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          color: kLightBrownE5E2CF,
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 0, 16, 0),
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(l10n.status,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black)),
                                                  SizedBox(width: 4),
                                                  Text(
                                                      todoList[index].status
                                                          ? l10n.complete
                                                          : l10n.incomplete,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              Spacer(),
                                              Row(
                                                children: [
                                                  Text(l10n.tickIfCompleted,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black)),
                                                  SizedBox(width: 4),
                                                  Obx(() => Checkbox(
                                                      value: todoList[index]
                                                          .status,
                                                      onChanged: ((value) =>
                                                          _onCheckBoxClicked(
                                                              index, value))))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 24)
                              ],
                            );
                    },
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: IconButton(
              iconSize: 36.0,
              color: kOrangeEF571F,
              icon: Icon(Icons.add_circle),
              onPressed: _onAddButtonPressed,
            ),
          ),
        ]));
  }

  void _onAddButtonPressed() {
    Get.toNamed<void>(AppRoute.addTodoItem.path, arguments: {"edit": false});
  }

  void _onCheckBoxClicked(int index, bool? value) {
    final todoController = Get.find<TodoController>();
    final todoList = todoController.todoList;
    setState(() {
      todoList[index].updateTodoItem(status: value);
    });
  }

  void _onTodoItemTapped(int index) {
    todoController.selectedItemIndex.value = index;
    Get.toNamed<void>(AppRoute.addTodoItem.path, arguments: {"edit": true});
  }
}

// ignore: must_be_immutable
class CountDownTimer extends StatelessWidget {
  CountDownTimer({
    Key? key,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  DateTime startDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    startDate = startDate.isAfter(DateTime.now()) ? startDate : DateTime.now();
    final l10n = context.l10n;
    return StreamBuilder(
      stream: Stream.periodic(const Duration(minutes: 1)),
      builder: (context, snapshot) {
        return Text(
            endDate.difference(startDate.isAfter(DateTime.now()) ? startDate : DateTime.now()).inHours.toString() +
                l10n.hours +
                (endDate.difference(startDate.isAfter(DateTime.now()) ? startDate : DateTime.now()).inMinutes.toInt() % 60)
                    .toString() +
                l10n.minutes,
            style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold));
      },
    );
  }
}


