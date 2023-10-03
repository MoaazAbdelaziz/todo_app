import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/models/task_model.dart';

class TaskListProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];
  DateTime selectdDate = DateTime.now();

  void getAllTasksFromFireStore(String uid) async {
    QuerySnapshot<TaskModel> querySnapshot =
        await FirebaseUtils.getTaskscollection(uid).get();
    tasks = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    tasks = tasks.where(
      (task) {
        if (task.taskDateTime?.day == selectdDate.day &&
            task.taskDateTime?.month == selectdDate.month &&
            task.taskDateTime?.year == selectdDate.year) {
          return true;
        }
        return false;
      },
    ).toList();

    tasks.sort(
      (task1, task2) {
        return task1.taskDateTime!.compareTo(task2.taskDateTime!);
      },
    );
    notifyListeners();
  }

  void setNewSelectedDate(DateTime newSelectedDate, String uid) {
    selectdDate = newSelectedDate;
    getAllTasksFromFireStore(uid);
  }
}
