import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/user_model.dart';

abstract class FirebaseUtils {
  static CollectionReference<TaskModel> getTaskscollection(String uid) {
    return getUsersCollection()
        .doc(uid)
        .collection(TaskModel.collectionName)
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, options) =>
              TaskModel.fromFirestore(snapshot.data()!),
          toFirestore: (task, options) => task.toFirestore(),
        );
  }

  static Future<void> addTaskToFirebase(TaskModel task, String uid) {
    var tasksCollection = getTaskscollection(uid);
    DocumentReference<TaskModel> taskDocRef = tasksCollection.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFirestore(TaskModel task, String uid) {
    return getTaskscollection(uid).doc(task.id).delete();
  }

  static Future<void> editTasktoFirebase(
    TaskModel task,
    String uid, {
    required String newTitle,
    required String newDescription,
    required DateTime newTaskDateTime,
  }) {
    var tasksCollection = getTaskscollection(uid);
    return tasksCollection.doc(task.id).update({
      'title': newTitle,
      'description': newDescription,
      'taskDateTime': newTaskDateTime.millisecondsSinceEpoch,
    });
  }

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, options) =>
              UserModel.fromFirestore(snapshot.data()),
          toFirestore: (user, options) => user.toFirestore(),
        );
  }

  static Future<void> addUserToFirestore(UserModel user) {
    return getUsersCollection().doc(user.id).set(user);
  }

  static Future<UserModel?> readUserFromFirestore(String uid) async {
    var documentSnapshot = await getUsersCollection().doc(uid).get();
    return documentSnapshot.data();
  }
}
