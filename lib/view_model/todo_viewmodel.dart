import 'package:flutter/cupertino.dart';
import 'package:todo_project/model/todo_dao.dart';
import 'package:todo_project/model/todo_dto.dart';

class ToDoViewModel extends ChangeNotifier {
  ToDoDAO _todoDAO = ToDoDAO();
  bool isLoading = false;
  int selectedIndex = 0;
  List<ToDoDTO> todoList = [];

  void fecthList() {
    todoList = _todoDAO.getListToDo();
  }

  Future<bool> updateToDoList(ToDoDTO dto, bool update) async {
    isLoading = true;
    notifyListeners();
    dto.isChecked = update;
    bool result = await _todoDAO.saveToDo(todoList);
    isLoading = false;
    notifyListeners();
    return result;
  }

  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
