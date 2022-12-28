import 'package:flutter/material.dart';
import 'package:flutter_todo_list/l10n/l10n.dart';
import 'package:flutter_todo_list/misc/constants.dart';
import 'package:flutter_todo_list/misc/widgets/appbar.dart';
import 'package:get/get.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'package:flutter_todo_list/todo_list/controllers/todo_controller.dart';

class AddTodoItemPage extends StatefulWidget {
  const AddTodoItemPage({Key? key}) : super(key: key);

  @override
  State<AddTodoItemPage> createState() => _AddTodoItemPageState();
}

class _AddTodoItemPageState extends State<AddTodoItemPage> {
  bool edit = false; //indicate status of editing todo item action
  final _formKey = GlobalKey<FormState>();

  String? title;
  DateTime? _startDate;
  DateTime? _endDate;

  final TextEditingController _todoTitleController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  final todoController = Get.find<TodoController>();

  @override
  void dispose() {
    _todoTitleController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //Initialise text fields with the corespondings value during editing of todo item
    edit = Get.arguments['edit'] ?? false;
    final todoList = todoController.todoList;
    final selectedIndex = todoController.selectedItemIndex.value;
    _todoTitleController.text = edit ? todoList[selectedIndex].name : '';
    _startDateController.text = edit
        ? DateFormat('dd MMM yyyy HH:mm aaa')
            .format(todoList[selectedIndex].startDate)
        : '';
    _endDateController.text = edit
        ? DateFormat('dd MMM yyyy HH:mm aaa')
            .format(todoList[selectedIndex].endDate)
        : '';
    _startDate = edit ? todoList[selectedIndex].startDate : null;
    _endDate = edit ? todoList[selectedIndex].endDate : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
        appBar: GenericAppBar(title: l10n.addNewTodoList),
        resizeToAvoidBottomInset: false,
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(24, 32, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.todoTitle,
                        style: TextStyle(
                          color: kGrey8C8C8C,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8),
                      FormInputField(
                          maxLines: 5,
                          hintText: l10n.pleaseKeyInYourTodoTitleHere,
                          controller: _todoTitleController,
                          validator: _titleValidator),
                      SizedBox(height: 24),
                      Text(
                        l10n.startDate,
                        style: TextStyle(
                          color: kGrey8C8C8C,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8),
                      FormInputField(
                        controller: _startDateController,
                        readOnly: true,
                        onTap: () => onStartDatePressed(),
                        validator: _dateValidator,
                        hintText: l10n.selectADate,
                        suffixIcon: Icon(Icons.expand_more),
                      ),
                      SizedBox(height: 24),
                      Text(
                        l10n.estimatedEndDate,
                        style: TextStyle(
                          color: kGrey8C8C8C,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8),
                      FormInputField(
                        controller: _endDateController,
                        onTap: () => onEndDatePressed(),
                        validator: _dateValidator,
                        hintText: l10n.selectADate,
                        suffixIcon: Icon(Icons.expand_more),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            height: 48,
                            width: double.infinity,
                            decoration:
                                BoxDecoration(borderRadius: BorderRadius.zero),
                            child: TextButton(
                                onPressed: edit
                                    ? onConfirmChangesButtonPressed
                                    : onCreateNowButtonPressed,
                                child: Text(
                                  edit ? l10n.confirmChanges : l10n.createNow,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero)))))),
              ],
            )));
  }

  String? _titleValidator(String? value) {
    final l10n = context.l10n;
    if (value == null || value.isEmpty) {
      return l10n.pleaseEnterATitle;
    }
    return null;
  }

  String? _dateValidator(String? value) {
    final l10n = context.l10n;
    if (value == null || value.isEmpty) {
      return l10n.pleaseEnterADate;
    }
    return null;
  }

  void onConfirmChangesButtonPressed() {
    final state = _formKey.currentState;
    if (state != null && state.validate()) {
      todoController.editTodoItem(
          _todoTitleController.text, _startDate!, _endDate!);
      Get.back<void>();
    }
  }

  void onCreateNowButtonPressed() {
    final state = _formKey.currentState;
    if (state != null && state.validate()) {
      todoController.addTodoItem(
          _todoTitleController.text, _startDate!, _endDate!);

      Get.back<void>();
    }
  }

  void onStartDatePressed() {
    DatePicker.showDateTimePicker(context, minTime: DateTime.now(),
        onChanged: (date) {
      _startDate = date;
      String formattedDate = DateFormat('dd MMM yyyy HH:mm aaa').format(date);

      setState(() {
        _startDateController.text = formattedDate; //display date in text field
      });
    });
  }

  void onEndDatePressed() {
    DatePicker.showDateTimePicker(context,
        minTime: DateTime.now().add(Duration(minutes: 1)), onChanged: (date) {
      _endDate = date;
      String formattedDate = DateFormat('dd MMM yyyy HH:mm aaa').format(date);
      setState(() {
        _endDateController.text = formattedDate; //display date in text field
      });
    });
  }
}

class FormInputField extends StatelessWidget {
  const FormInputField(
      {Key? key,
      this.readOnly = false,
      this.controller,
      this.validator,
      this.onTap,
      this.hintText,
      this.suffixIcon,
      this.maxLines = 1})
      : super(key: key);

  final bool readOnly;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final String? hintText;
  final Icon? suffixIcon;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        onTap: onTap,
        validator: validator,
        readOnly: readOnly,
        maxLines: maxLines,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.zero),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.zero),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.zero),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.zero,
          ),
          hintText: hintText,
          suffixIcon: suffixIcon,
        ));
  }
}
