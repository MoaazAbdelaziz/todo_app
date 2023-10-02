import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      try {
        var userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        print('register success');
        print(userCredential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print('error: ${e.toString()}');
      }
    }
  }
}
