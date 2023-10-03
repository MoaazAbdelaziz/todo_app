import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/dialog_utils.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/home/home_view.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/register/register_screen.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String routeName = 'login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Row(
                    children: [
                      Text(
                        'Don\'t have an account',
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
                          'SignUp',
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

  void login() async {
    if (formKey.currentState!.validate()) {
      DialogUtils.showLoading(context, 'Loading...');
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        var user = await FirebaseUtils.readUserFromFirestore(
          userCredential.user?.uid ?? '',
        );
        if (user == null) {
          return;
        }
        var provider = Provider.of<AuthProvider>(context);
        provider.updateUser(user);
        DialogUtils.hideDialog(context);
        DialogUtils.showMessage(
          context,
          'Login Successful',
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
        if (e.code == 'user-not-found') {
          DialogUtils.hideDialog(context);
          DialogUtils.showMessage(
            context,
            'No user found for that email.',
          );
        } else if (e.code == 'wrong-password') {
          DialogUtils.hideDialog(context);
          DialogUtils.showMessage(
            context,
            'Wrong password provided for that user.',
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
