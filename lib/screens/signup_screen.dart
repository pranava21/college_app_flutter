import 'dart:developer' as developer;

import 'package:college_app/models/department.dart';
import 'package:college_app/models/user.dart';
import 'package:college_app/resources/authmethods.dart';
import 'package:college_app/screens/login_screen.dart';
import 'package:college_app/utils/utils.dart';
import 'package:college_app/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => SignUpState();
}

enum SigningCharacter { student, faculty }

class SignUpState extends State<SignUp> {
  bool isLoading = false;
  SigningCharacter? _studentOrFaculty = SigningCharacter.faculty;
  List<Department> departments = [];
  String dropDownValue = '';
  String selectedDepartmentUid = '';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void signUp() async {
    setState(() {
      isLoading = true;
    });
    UserDetails user = UserDetails(
        emailId: _emailController.text,
        userId: _userNameController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        age: int.parse(_ageController.text.toString()),
        address: _addressController.text,
        phone: _phoneController.text,
        departmentUid: selectedDepartmentUid,
        isFaculty: _studentOrFaculty == SigningCharacter.faculty,
        isStudent: _studentOrFaculty == SigningCharacter.student);

    String result = await AuthMethods()
        .signUpUser(password: _passwordController.text, user: user);

    if (result == "Success") {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      var res = result.split(']');
      showSnackBar(context, res[1].trim());
    }
    developer.log(result);
  }

  @override
  initState() {
    super.initState();
    loadDepartments();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              child: Builder(
                  builder: (context) => Form(
                      key: _formKey,
                      child: SizedBox(
                        height: 1000,
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
                            const SizedBox(height: 5, width: double.infinity),
                            Text(
                              'Sign Up',
                              style: GoogleFonts.lato(fontSize: 30),
                            ),
                            const SizedBox(height: 20, width: double.infinity),

                            TextFieldInput(
                              textEditingController: _userNameController,
                              hintText: 'Enter your desired user name',
                              textInputType: TextInputType.text,
                              validatorText: 'User name cannot be empty',
                              labelText: 'User Name',
                            ),
                            const SizedBox(height: 20, width: double.infinity),

                            TextFieldInput(
                              textEditingController: _firstNameController,
                              hintText: 'Enter Your First Name',
                              textInputType: TextInputType.text,
                              validatorText: 'First Name cannot be empty',
                              labelText: 'First Name',
                            ),
                            const SizedBox(height: 20, width: double.infinity),

                            TextFieldInput(
                              textEditingController: _lastNameController,
                              hintText: 'Enter Your Last Name',
                              textInputType: TextInputType.text,
                              validatorText: 'Last name cannot be empty',
                              labelText: 'Last Name',
                            ),
                            const SizedBox(height: 20, width: double.infinity),

                            TextFieldInput(
                              textEditingController: _ageController,
                              hintText: 'Enter Your Age',
                              textInputType: TextInputType.number,
                              validatorText: 'Age cannot be empty',
                              labelText: 'Age',
                            ),
                            const SizedBox(height: 20, width: double.infinity),

                            TextFieldInput(
                              textEditingController: _phoneController,
                              hintText: 'Enter Your Phone Number',
                              textInputType: TextInputType.phone,
                              validatorText: 'Phone name cannot be empty',
                              labelText: 'Phone number',
                            ),
                            const SizedBox(height: 20, width: double.infinity),

                            TextFieldInput(
                              textEditingController: _addressController,
                              hintText: 'Enter Your Address',
                              textInputType: TextInputType.text,
                              validatorText: 'Address cannot be empty',
                              labelText: 'Address',
                            ),
                            const SizedBox(height: 20, width: double.infinity),

                            TextFieldInput(
                              textEditingController: _emailController,
                              hintText: 'Enter Your Email Address',
                              textInputType: TextInputType.emailAddress,
                              validatorText: 'Email cannot be empty',
                              labelText: 'Email address',
                            ),
                            const SizedBox(height: 20, width: double.infinity),

                            TextFieldInput(
                              textEditingController: _passwordController,
                              hintText: 'Enter Your Password',
                              textInputType: TextInputType.text,
                              isPass: true,
                              validatorText: 'Password cannot be empty',
                              labelText: 'Password',
                            ),
                            const SizedBox(height: 20, width: double.infinity),

                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Radio<SigningCharacter>(
                                      value: SigningCharacter.faculty,
                                      groupValue: _studentOrFaculty,
                                      onChanged: onChanged),
                                  const Text('Faculty'),
                                  Radio<SigningCharacter>(
                                      value: SigningCharacter.student,
                                      groupValue: _studentOrFaculty,
                                      onChanged: onChanged),
                                  const Text('Student'),
                                ]),
                            const SizedBox(height: 20, width: double.infinity),
                            _renderDepartmentList(),
                            const SizedBox(height: 20, width: double.infinity),
                            SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final form = _formKey.currentState;
                                  if (form!.validate()) {
                                    form.save();
                                    signUp();
                                  }
                                },
                                child: isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        'Sign Up',
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                              ),
                            ),
                            Flexible(
                              child: Container(),
                              flex: 3,
                            ),
                          ],
                        ),
                      ))))),
    ));
  }

  Future<void> loadDepartments() async {
    final departmentList = await Department.fetchAllDepartments();

    setState(() {
      departments = departmentList;
      dropDownValue = departments.first.departmentName;
      selectedDepartmentUid = departments.first.departmentUid;
    });
  }

  Widget _renderDepartmentList() {
    return InputDecorator(
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Department',
            labelStyle: TextStyle(fontSize: 20.0)),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
          value: dropDownValue,
          style: const TextStyle(color: Colors.blue, fontSize: 16.0),
          iconEnabledColor: Colors.black,
          underline: Container(
            height: 2,
            color: Colors.blueAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropDownValue = newValue!;
              _setSelectedDepartmentUid(dropDownValue);
            });
          },
          items: departments
              .map<DropdownMenuItem<String>>((Department department) {
            return DropdownMenuItem<String>(
              value: department.departmentName,
              child: Text(department.departmentName),
            );
          }).toList(),
          hint: const Text(
            "Please choose your department",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          borderRadius: BorderRadius.circular(10.0),
          isExpanded: true,
        )));
  }

  void _setSelectedDepartmentUid(String departmentName) {
    var dept = departments
        .where((element) => element.departmentName == departmentName)
        .toList();

    selectedDepartmentUid = dept.first.departmentUid;
  }

  void onChanged(SigningCharacter? value) {
    setState(() {
      _studentOrFaculty = value!;
    });
  }
}
