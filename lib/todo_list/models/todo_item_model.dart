class TodoItemModel {
  TodoItemModel({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  String name;
  DateTime startDate;
  DateTime endDate;
  bool status;
  
  void updateTodoItem(
    {
      String? name,
      DateTime? startDate,
      DateTime? endDate,
      bool? status,
    }
  ) {
    this
      ..name = name ?? this.name
      ..startDate = startDate ?? this.startDate
      ..endDate = endDate ?? this.endDate
      ..status = status ?? this.status;
  }
}