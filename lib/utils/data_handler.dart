import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_project/model/todo_dto.dart';

class DataHandler {
  static late SharedPreferences _sp;

  static Future<bool> verifyData({bool clearPreviousData = false}) async {
    _sp = await SharedPreferences.getInstance();
    if(clearPreviousData){
      await _sp.clear();
    }
    String? key = _sp.getString("DATA");
    if (key == null) {
      List<ToDoDTO> todoList = creatData();
      return await saveData(todoList);
    }
    return true;
  }

  static List<ToDoDTO> creatData() {
    //I will suppose every title is unique
    List<ToDoDTO> todoList = [];
    todoList.add(ToDoDTO(title: "Brushing teeth ๐"));
    todoList.add(ToDoDTO(title: "Doing exercise ๐โโ๏ธ"));
    todoList.add(ToDoDTO(title: "Drinking water ๐ฆ"));
    todoList.add(ToDoDTO(title: "Cleaning the house ๐งน"));
    todoList.add(ToDoDTO(title: "Feeding the pet ๐ "));
    todoList.add(ToDoDTO(title: "Having breakfast ๐ฅช"));
    todoList.add(ToDoDTO(title: "Improving skills ๐ช"));
    todoList.add(ToDoDTO(title: "Finding solution for current problems ๐"));
    todoList.add(ToDoDTO(title: "Helping the family ๐ "));
    todoList.add(ToDoDTO(title: "Being a babysister ๐จโ๐งโ๐ฆ"));
    todoList.add(ToDoDTO(title: "Having lunch ๐"));
    todoList.add(ToDoDTO(title: "Playing some games ๐ฎ"));
    todoList.add(ToDoDTO(title: "Doing homework ๐"));
    todoList.add(ToDoDTO(title: "Having dinner ๐ฒ"));
    todoList.add(ToDoDTO(title: "Praying ๐"));
    todoList.add(ToDoDTO(title: "Going to bed ๐"));
    return todoList;
  }

  static List<ToDoDTO> getData() {
    String? key = _sp.getString("DATA");
    if (key != null) {
      List<ToDoDTO> todoList =
          (jsonDecode(key) as List).map((e) => ToDoDTO.fromJson(e)).toList();
      return todoList;
    }
    return [];
  }

  static Future<bool> saveData(List<ToDoDTO> todoList) async {
    return await _sp.setString(
        "DATA", jsonEncode(todoList.map((e) => e.toJson()).toList()));
  }
  
}
