import 'package:flutter/material.dart';

class TodoItem {
  String task;
  bool isDone;

  TodoItem({required this.task, this.isDone = false});
}

class ToDoProvider extends ChangeNotifier {
  final List<TodoItem> _todoList = [];

  List<TodoItem> get todoList => _todoList;
  int get totalTasks => _todoList.length;
  int get complededTasks => _todoList
      .where((item) => item.isDone)
      .length; // where, 항목들을 조회하며 걸러내는 느낌, item 들중에 isDone 인 아이템만 걸러내기!
  int get pendingTasks => totalTasks - complededTasks;

  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      _todoList.add(TodoItem(task: task));
      notifyListeners();
    }
  }

  // 2. 체크박스를 눌렀을 때 isDone 상태를 변경하는 함수
  void _toggleDone(int index) {
    _todoList[index].isDone = !_todoList[index].isDone;
    notifyListeners();
  }

  // 3. 삭제 버튼을 눌렀을 때 해당 아이템을 리스트에서 제거하는 함수
  void _deleteTodoItem(int index) {
    _todoList.removeAt(index);
    notifyListeners();
  }

  void addTodoItem(String task) => _addTodoItem(task);
  void toggleDone(int index) => _toggleDone(index);
  void deleteTodoItem(int index) => _deleteTodoItem(index);
}
