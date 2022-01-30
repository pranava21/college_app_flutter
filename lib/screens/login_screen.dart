import 'dart:developer';

import 'package:college_app/layouts/faculty_layout.dart';
import 'package:college_app/layouts/student_layout.dart';
import 'package:college_app/layouts/user_layout.dart';
import 'package:college_app/resources/authmethods.dart';
import 'package:college_app/screens/signup_screen.dart';
import 'package:college_app/utils/utils.dart';
import 'package:college_app/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    String result = await AuthMethods().signInUser(
        email: _emailController.text, password: _passwordController.text);

    if (result == "Success") {
      setState(() {
        isLoading = false;
      });
      log(result);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const UserLayout(studentLayout: StudentLayout(), facultyLayout: FacultyLayout())
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      var res = result.split(']');
      log(res[1].trim());
      showSnackBar(context, res[1].trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                child: Builder(
                  builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(),
                          flex: 2,
                        ),
                        //SVG Image
                        Image.asset(
                          'assets/university.png',
                          height: 130,
                        ),
                        const SizedBox(height: 24, width: double.infinity),
                        Text(
                          'College App',
                          style: GoogleFonts.pacifico(fontSize: 40),
                        ),
                        const SizedBox(height: 24, width: double.infinity),
                        TextFieldInput(
                          textEditingController: _emailController,
                          hintText: 'Enter Your Email Address',
                          textInputType: TextInputType.emailAddress,
                          validatorText: 'Please enter your email address',
                          labelText: 'Email Address',
                        ),
                        const SizedBox(height: 24, width: double.infinity),
                        TextFieldInput(
                          textEditingController: _passwordController,
                          hintText: 'Enter Your Password',
                          textInputType: TextInputType.text,
                          isPass: true,
                          validatorText: 'Please enter your password',
                          labelText: 'Password',
                        ),
                        const SizedBox(height: 24, width: double.infinity),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              final form = _formKey.currentState;
                              if (form!.validate()) {
                                form.save();
                                loginUser();
                              }
                            },
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                          ),
                        ),
                        Flexible(
                          child: Container(),
                          flex: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: const Text("Don't have an account?"),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SignUp(),
                                ),
                              ),
                              child: Container(
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ))));
  }
}
