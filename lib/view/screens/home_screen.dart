import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/core/app_routes.dart';
import 'package:todo_app/data/model/task_model.dart';
import 'package:todo_app/data/model/user_model.dart';
import 'package:todo_app/view/screens/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> tasks = [];
  int numOfTasks = 0;
  int numOfPending = 0;
  int numOfDone = 0;
  @override
  void initState() {
    super.initState();
    getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FB),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: .start,
          spacing: 20,
          children: [
            SizedBox(height: 60),
            HeaderWidget(fullName: getName()),
            TaskInfoDetails(
              numOfTasks: numOfTasks,
              numOfDone: numOfDone,
              numOfPending: numOfPending,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's Tasks",
                    style: TextStyle(fontSize: 20, fontWeight: .bold),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => TaskItem(
                        task: tasks[index],
                        delete: () {
                          deleteItem(index);
                        },
                        edit: () {
                          editItem(index);
                        },
                      ),
                      itemCount: tasks.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () async {
          await Navigator.of(context).pushNamed(AppRoutes.addTask);
          getAllTasks();
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffDEE0FF),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                offset: Offset(5, 5),
              ),
            ],
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            spacing: 10,
            mainAxisSize: .min,
            children: [Icon(Icons.add, size: 30), Text("Task")],
          ),
        ),
      ),
    );
  }

  void getAllTasks() {
    var taskBox = Hive.box<TaskModel>('Tasks');
    tasks = taskBox.values.toList();
    numbers();
    setState(() {});
  }

  String getName() {
    var taskBox = Hive.box<UserModel>('User');
    var user = taskBox.get("UserKey");
    return user?.fullName ?? "Error From Name";
  }

  void numbers() {
    numOfTasks = tasks.length;
    numOfDone = tasks.where((e) => e.status == StatusTask.done).toList().length;
    numOfPending = tasks
        .where((e) => e.status == StatusTask.pending)
        .toList()
        .length;
  }

  void deleteItem(int index) {
    var taskBox = Hive.box<TaskModel>('Tasks');
    taskBox.deleteAt(index);
    tasks.removeAt(index);
    setState(() {});
  }

  void editItem(int index) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddTaskScreen(task: tasks[index], index: index),
      ),
    );
    getAllTasks();
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.fullName});
  final String fullName;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xffE8ECF5),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(Icons.person, size: 40, color: Color(0xff3F51B5)),
        ),
        Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          spacing: 10,
          children: [
            Text(
              "Good Morning",
              style: TextStyle(
                fontSize: 16,
                fontWeight: .w400,
                color: Colors.grey,
              ),
            ),
            Text(fullName, style: TextStyle(fontSize: 16, fontWeight: .bold)),
          ],
        ),
      ],
    );
  }
}

class TaskInfoDetails extends StatelessWidget {
  const TaskInfoDetails({
    super.key,
    required this.numOfTasks,
    required this.numOfPending,
    required this.numOfDone,
  });
  final int numOfTasks;
  final int numOfPending;
  final int numOfDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xff3F51B5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: .spaceAround,
        children: [
          item(numOfTasks, "Tasks"),
          item(numOfPending, "Pending"),
          item(numOfDone, "Done"),
        ],
      ),
    );
  }

  Widget item(int num, String des) {
    return Column(
      spacing: 10,
      mainAxisSize: .min,
      children: [
        Text(
          num.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: .bold,
            color: Colors.white,
          ),
        ),
        Text(
          des,
          style: TextStyle(fontSize: 16, fontWeight: .bold, color: Colors.grey),
        ),
      ],
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task,
    required this.delete,
    required this.edit,
  });
  final TaskModel task;
  final void Function()? delete;
  final void Function()? edit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: edit,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          spacing: 10,
          children: [
            Container(
              height: 60,
              width: 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(task.colorHex),
              ),
            ),
            Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              spacing: 5,
              children: [
                Text(
                  task.title,
                  style: TextStyle(fontSize: 18, fontWeight: .bold),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    task.description,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: .w400,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: .ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(task.colorHex).withAlpha(50),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    task.status == StatusTask.pending ? "Pending" : "Done",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: .bold,
                      color: Color(task.colorHex),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: delete,
              icon: Icon(Icons.delete, color: Colors.red, size: 40),
            ),
          ],
        ),
      ),
    );
  }
}
