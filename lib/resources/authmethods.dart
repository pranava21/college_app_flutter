import 'package:college_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser(
      {required UserDetails user, required String password}) async {
    String result = "Some error occurred";

    try {
      // ignore: unused_local_variable
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: user.emailId, password: password);

      String facultyOrStudent = '';
      if (user.isFaculty) {
        facultyOrStudent = 'faculty';
      } else {
        facultyOrStudent = 'student';
      }
      var response =
          await UserDetails.addUserToDatabase(user, facultyOrStudent);

      if (response.isSucess) {
        result = "Success";
      } else {
        // ignore: unused_local_variable
        var response =
            await UserDetails.addUserToDatabase(user, facultyOrStudent);
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  Future<String> signInUser(
      {required String email, required String password}) async {
    String result = "Some error occurred";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      result = "Success";
    } catch (err) {
      result = err.toString();
    }

    return result;
  }

  Future<UserDetails?> getUserDetails() async {
    User currentUserEmail = _auth.currentUser!;

    UserDetails? user = await UserDetails.getUser(currentUserEmail.email!);

    return user;
  }

  Future<String> getToken() async {
    var token = await _auth.currentUser!.getIdToken(true);
    var finalToken = 'Bearer ' + token;

    return finalToken;
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
