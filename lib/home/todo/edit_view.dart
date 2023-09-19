import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/home/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditView extends StatefulWidget {
  const EditView({super.key});
  static String routeName = 'Edit-View';

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  var formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.app_title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.08,
        ),
        decoration: BoxDecoration(
          color: MyTheme.whitColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.edit_task,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_title;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.task_title,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_des;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.task_description,
                        ),
                        maxLines: 4,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        AppLocalizations.of(context)!.select_date,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.save_changes,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showCalender() async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      selectedDate = pickedDate;
    }
    setState(() {});
  }
}
