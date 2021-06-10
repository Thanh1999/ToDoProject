import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/model/todo_dto.dart';
import 'package:todo_project/view_model/todo_viewmodel.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  ToDoViewModel model = ToDoViewModel();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    model.fecthList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => model,
      child: ScaffoldMessenger(
        key: scaffoldMessKey,
        child: Scaffold(
            appBar: AppBar(
              title: Text("TODO Project"),
            ),
            body: buildBody(),
            bottomNavigationBar: buildBottomBar()),
      ),
    );
  }

  Widget buildBody() {
    return Consumer<ToDoViewModel>(
      builder: (context, model, child) {
        if (model.isLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator(), Text("Please waiting")],
            ),
          );
        }
        List<ToDoDTO> allTodo = model.todoList;
        List<ToDoDTO> completeTodo =
            model.todoList.where((element) => element.isChecked).toList();
        List<ToDoDTO> incompleteTodo =
            model.todoList.where((element) => !element.isChecked).toList();

        List<Widget> screens = [
          buildListView(allTodo),
          buildListView(completeTodo, title: "completed"),
          buildListView(incompleteTodo, title: "incompleted")
        ];
        return screens[model.selectedIndex];
      },
    );
  }

  Widget buildBottomBar() {
    return Consumer<ToDoViewModel>(builder: (context, model, child) {
      return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Complete',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.crop_square),
            label: 'Incomplete',
          ),
        ],
        currentIndex: model.selectedIndex,
        selectedItemColor: Colors.green,
        onTap: (value) {
          model.changeIndex(value);
        },
      );
    });
  }

  Widget buildListView(List<ToDoDTO> list, {String? title}) {
    if (list.isEmpty) {
      return Center(child: Text("No todo is ${title ?? ""}"));
    }
    return ListView.separated(
      itemBuilder: (context, index) {
        return CheckboxListTile(
          value: list[index].isChecked,
          onChanged: (value) async {
            bool result =
                await model.updateToDoList(list[index], value ?? false);
            scaffoldMessKey.currentState?.hideCurrentSnackBar();
            if (result) {
              scaffoldMessKey.currentState?.showSnackBar(
                  SnackBar(content: Text("Save changed successfully")));
            } else {
              scaffoldMessKey.currentState?.showSnackBar(
                  SnackBar(content: Text("Fail to save changed")));
            }
          },
          title: Text(list[index].title),
        );
      },
      itemCount: list.length,
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
