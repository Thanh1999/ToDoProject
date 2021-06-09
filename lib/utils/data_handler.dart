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
    todoList.add(ToDoDTO(title: "Brushing teeth 😁"));
    todoList.add(ToDoDTO(title: "Doing exercise 🏃‍♂️"));
    todoList.add(ToDoDTO(title: "Drinking water 💦"));
    todoList.add(ToDoDTO(title: "Cleaning the house 🧹"));
    todoList.add(ToDoDTO(title: "Feeding the pet 🐠"));
    todoList.add(ToDoDTO(title: "Having breakfast 🥪"));
    todoList.add(ToDoDTO(title: "Improving skills 💪"));
    todoList.add(ToDoDTO(title: "Finding solution for current problems 🔎"));
    todoList.add(ToDoDTO(title: "Helping the family 🏠"));
    todoList.add(ToDoDTO(title: "Being a babysister 👨‍👧‍👦"));
    todoList.add(ToDoDTO(title: "Having lunch 🍚"));
    todoList.add(ToDoDTO(title: "Playing some games 🎮"));
    todoList.add(ToDoDTO(title: "Doing homework 📄"));
    todoList.add(ToDoDTO(title: "Having dinner 🍲"));
    todoList.add(ToDoDTO(title: "Praying 🙏"));
    todoList.add(ToDoDTO(title: "Going to bed 🛌"));
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
