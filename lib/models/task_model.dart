class TaskModel {
  static const String collectionName = 'tasks';

  String? id;
  String? title;
  String? description;
  DateTime? taskDateTime;
  bool? isDone;

  TaskModel({
    this.id = '',
    required this.title,
    required this.description,
    required this.taskDateTime,
    this.isDone = false,
  });

  TaskModel.fromFirestore(Map<String, dynamic> data)
      : this(
          id: data['id'] as String?,
          title: data['title'] as String?,
          description: data['description'] as String?,
          taskDateTime:
              DateTime.fromMillisecondsSinceEpoch(data['taskDateTime']),
          isDone: data['isDone'] as bool?,
        );

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'taskDateTime': taskDateTime?.millisecondsSinceEpoch,
      'isDone': isDone,
    };
  }
}
