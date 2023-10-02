import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/task_model.dart';

abstract class FirebaseUtils {
  static CollectionReference<TaskModel> getTaskscollection() {
    return FirebaseFirestore.instance
        .collection(TaskModel.collectionName)
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, options) =>
              TaskModel.fromFirestore(snapshot.data()!),
          toFirestore: (task, options) => task.toFirestore(),
        );
  }

  static Future<void> addTaskToFirebase(TaskModel task) {
    var tasksCollection = getTaskscollection();
    DocumentReference<TaskModel> taskDocRef = tasksCollection.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFirestore(TaskModel task) {
    return getTaskscollection().doc(task.id).delete();
  }

  static Future<void> editTasktoFirebase(
    TaskModel task, {
    required String newTitle,
    required String newDescription,
    required DateTime newTaskDateTime,
  }) {
    var tasksCollection = getTaskscollection();
    return tasksCollection.doc(task.id).update({
      'title': newTitle,
      'description': newDescription,
      'taskDateTime': newTaskDateTime.millisecondsSinceEpoch,
    });
  }
}
