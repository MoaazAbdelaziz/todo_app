import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/dialog_utils.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/home/home_view.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String routeName = 'register-screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController(text: 'moaaz');
  var emailController = TextEditingController(text: 'moaaz@gmail.com');
  var passwordController = TextEditingController(text: '123456');
  var passwordConfirmController = TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/main_background.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  CustomTextFormField(
                    text: 'User Name',
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    validator: (text) {
                      if (text!.isEmpty || text.trim().isEmpty) {
                        return 'Please Enter User Name';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    text: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (text) {
                      if (text!.isEmpty || text.trim().isEmpty) {
                        return 'Please Enter Email';
                      }
                      final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(text);
                      if (!emailValid) {
                        return 'Please Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    text: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    isNotVisible: true,
                    validator: (text) {
                      if (text!.isEmpty || text.trim().isEmpty) {
                        return 'Please Enter Password';
                      }
                      if (text.length < 6) {
                        return 'Password should be at least Characters';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    text: 'Password Confirm',
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordConfirmController,
                    isNotVisible: true,
                    validator: (text) {
                      if (text!.isEmpty || text.trim().isEmpty) {
                        return 'Please Enter Password Confirmation';
                      }
                      if (passwordController.text != text) {
                        return 'Password not Matching';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        register();
                      },
                      child: Text(
                        'Register',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Row(
                    children: [
                      Text(
                        'Already have an account',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            RegisterScreen.routeName,
                          );
                        },
                        child: Text(
                          'SignIp',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      DialogUtils.showLoading(context, 'Loading...');
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        UserModel user = UserModel(
          id: userCredential.user?.uid ?? '',
          email: emailController.text,
          name: nameController.text,
        );
        var provider = Provider.of<AuthProvider>(context, listen: false);
        provider.updateUser(user);
        await FirebaseUtils.addUserToFirestore(user);
        DialogUtils.hideDialog(context);
        DialogUtils.showMessage(
          context,
          'Register Sccessful',
          title: 'Success',
          posActionName: 'Ok',
          posAction: () {
            Navigator.pushReplacementNamed(
              context,
              HomeView.routeName,
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideDialog(context);
        String errMessage = 'Something went wrong';
        if (e.code == 'weak-password') {
          errMessage = 'The password provided is too weak.';
          DialogUtils.showMessage(
            context,
            errMessage,
          );
        } else if (e.code == 'email-already-in-use') {
          errMessage = 'The account already exists for that email.';
          DialogUtils.showMessage(
            context,
            errMessage,
          );
        }
      } catch (e) {
        DialogUtils.hideDialog(context);
        DialogUtils.showMessage(
          context,
          'Error: ${e.toString()}',
        );
      }
    }
  }
}
