import 'package:todo_project/model/todo_dto.dart';
import 'package:todo_project/utils/data_handler.dart';

class ToDoDAO {
  List<ToDoDTO> getListToDo() {
    return DataHandler.getData();
  }

  Future<bool> saveToDo(List<ToDoDTO> list) async {
    return await DataHandler.saveData(list);
  }
}
