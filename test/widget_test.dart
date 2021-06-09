// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_project/model/todo_dao.dart';
import 'package:todo_project/model/todo_dto.dart';
import 'package:todo_project/utils/data_handler.dart';
import 'package:todo_project/view_model/todo_viewmodel.dart';

void main() {
  late bool verified;
  late List<ToDoDTO> list;

  setUp(() async {
    verified = await DataHandler.verifyData(clearPreviousData: true);
    list = DataHandler.creatData();
  });

  group("DataHandler", () {
    test("Test verify init data", () {
      expect(verified, true);
    });

    test("Test create data", () {
      expect(list.isNotEmpty, true);
      list.forEach((element) {
        expect(element.isChecked, false);
      });
    });

    test("Test get data", () async {
      List<ToDoDTO> list = DataHandler.getData();
      expect(list.isNotEmpty, true);
      list.forEach((element) {
        expect(element.isChecked, false);
      });
    });

    test("Test save data", () async {
      list.last.isChecked = true;
      bool result = await DataHandler.saveData(list);
      expect(result, true);
      ToDoDTO dto = DataHandler.getData().last;
      expect(dto.isChecked, true);
    });
  });

  group("ToDoDAO", () {
    ToDoDAO dao = ToDoDAO();

    test("Test get list data", () {
      List<ToDoDTO> testList = dao.getListToDo();
      expect(testList.isNotEmpty, true);
      expect(testList.length, list.length);
    });

    test("Test save list data", () async {
      list.last.title = "Text title";
      list.first.isChecked = true;
      bool result = await dao.saveToDo(list);
      expect(result, true);
      List<ToDoDTO> testList = dao.getListToDo();
      expect(testList.isNotEmpty, true);
      expect(testList.last.title, "Text title");
      expect(testList.first.isChecked, true);
    });
  });

  group("ToDoDTO", () {
    test("Test from Json function", () {
      Map map = {
        "title": "DTO Test",
        "isChecked": true,
      };
      ToDoDTO dto = ToDoDTO.fromJson(map);
      expect(dto.title, "DTO Test");
      expect(dto.isChecked, true);
    });

    test("Test to Json function", () {
      ToDoDTO dto = ToDoDTO(title: "Testing title");
      Map map = dto.toJson();
      expect(map.keys.contains("title"), true);
      expect(map.keys.contains("isChecked"), true);
      expect(map["title"], "Testing title");
      expect(map["isChecked"], false);
    });
  });

  group("ToDoViewModel", () {
    ToDoViewModel model = ToDoViewModel();

    test("Test init data", () {
      expect(model.isLoading, false);
      expect(model.selectedIndex, 0);
      expect(model.todoList.isEmpty, true);
    });

    test("Test get data", () {
      model.fecthList();
      expect(model.todoList.isNotEmpty, true);
    });

    test("Test save data", () async {
      model.fecthList();
      bool result = await model.updateToDoList(model.todoList.first, true);
      expect(result, true);
      model.fecthList();
      expect(model.todoList.first.isChecked, true);
    });
  });
}
