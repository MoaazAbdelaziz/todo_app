import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_list_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var desciptionController = TextEditingController();
  late TaskListProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<TaskListProvider>(context);

    return Container(
      padding: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44.0),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.add_new_task,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: titleController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return AppLocalizations.of(context)!.please_enter_title;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.enter_task_title,
                    ),
                  ),
                  const SizedBox(height: 7),
                  TextFormField(
                    controller: desciptionController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return AppLocalizations.of(context)!.please_enter_des;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText:
                          AppLocalizations.of(context)!.enter_task_description,
                    ),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppLocalizations.of(context)!.select_date,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () {
                      showCalender();
                    },
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(selectedDate),
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 7),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        addTask(context);
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.add,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addTask(BuildContext context) {
    TaskModel task = TaskModel(
      title: titleController.text,
      description: desciptionController.text,
      taskDateTime: selectedDate,
    );
    FirebaseUtils.addTaskToFirebase(task).timeout(
      const Duration(milliseconds: 500),
      onTimeout: () {
        print('Task Added Successfully');
        provider.getAllTasksFromFireStore();
        Navigator.pop(context);
      },
    );
  }

  void showCalender() async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      selectedDate = pickedDate;
    }
    setState(() {});
  }
}
