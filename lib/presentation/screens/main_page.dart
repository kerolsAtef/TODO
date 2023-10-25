import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:to_do_app/domain/models/to_do_model.dart';
import 'package:to_do_app/presentation/helpers.dart';
import 'package:to_do_app/presentation/screens/insert_page.dart';
import 'package:to_do_app/presentation/screens/login_page.dart';
import 'package:to_do_app/data/local/db.dart';
import 'package:to_do_app/data/remote/firestore_service.dart';
import '../../data/remote/firebase.dart';
import '../../domain/repositiories/todo_repository.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  User? user = FirebaseAuth.instance.currentUser;
  late TodoRepository todoRepository;
  late List<Todo> todoList = [];


  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    final LocalDatabase localDatabase = LocalDatabase();
    await localDatabase.initialize();
    todoRepository = TodoRepository(
      localDatabase: localDatabase,
      database: localDatabase.database,
    );

    await fetchTodoList();
  }

  Future<void> refreshToDoList() async {
    await fetchTodoList(); // Refresh the todo list.

    // After refreshing the data, call `setState` to rebuild the screen.
    setState(() {});
  }

  Future<void> fetchTodoList() async {
    final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      final List<Todo> items = await FirestoreService(user!.uid).getAllTodos();
      setState(() {
        todoList = items;
      });
    } else {
      final List<Todo> items = await todoRepository.getAllTodos();
      setState(() {
        todoList = items;
      });
    }
  }
  Future<void> toggleTodoCheckbox(Todo todo) async {
    final updatedTodo = Todo(id: todo.id,
        title: todo.title, time: todo.time, isChecked: 1-todo.isChecked);

    if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
      await todoRepository.updateTodoStatus(updatedTodo);
    } else {
      await FirestoreService(user!.uid).updateTodo(updatedTodo);
      await todoRepository.updateTodoStatus(updatedTodo);

    }

    setState(() {
      // Update the UI with the updated todo.
      // final index = todoList.indexWhere((element) => element.id == updatedTodo.id);
      // if (index != -1) {
      //   todoList[index] = updatedTodo;
      // }
      todo.isChecked=1-todo.isChecked;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.BackgroundColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => InsertPage()));
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(AppStrings.MainPageHeaderString, style: AppStyles.MainFontStyle),
                GestureDetector(
                  onTap: () async {
                    // Implement the logout functionality.
                    AuthService authService = AuthService();
                    await authService.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false,
                    );
                  },
                  child: Icon(Icons.login, color: AppColors.MainTextColor, size: 30),
                )
              ],
            ),
            Expanded(
              child: buildToDoList(),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildToDoList() {
    if (todoList.isEmpty) {
      // Show a message when the list is empty.
      return Center(child: Text('No tasks found.'));
    }

    return RefreshIndicator(
      onRefresh: refreshToDoList,
      child: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          final todo = todoList[index];
          return ListTile(
            subtitle: Text(
              "at ${todo.time.substring(11,16)}",
              style: TextStyle(
                decoration: todo.isChecked == 1 ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
            title: Text(
              todo.title,
              style: TextStyle(
                decoration: todo.isChecked == 1 ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
            leading: Checkbox(
              value: todo.isChecked == 1,
              onChanged: (value) {
                // Toggle the checkbox and update the todo.
                toggleTodoCheckbox(todo);
              },
            ),
          );
        },
      ),
    );
  }
}
