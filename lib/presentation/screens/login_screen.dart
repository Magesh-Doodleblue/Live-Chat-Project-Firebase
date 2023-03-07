// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

String verificationIdReceived = "";
late final bool _loading;
final FirebaseAuth auth = FirebaseAuth.instance;

class _LoginState extends State<Login> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  // Future<void> _sendCodeToPhoneNumber() async {
  //   setState(() {
  //     _loading = true;
  //   });
  //   try {
  //     await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: _phoneNumberController.text,
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //         setState(() {
  //           _loading = false;
  //         });
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         setState(() {
  //           _loading = false;
  //         });
  //         if (e.code == 'invalid-phone-number') {
  //         } else {}
  //       },
  //       codeSent: (String verificationId, int? resendToken) {
  //         setState(() {
  //           _loading = false;
  //           _verificationId = verificationId;
  //         });
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         setState(() {
  //           _loading = false;
  //           _verificationId = verificationId;
  //         });
  //       },
  //     );
  //   } catch (e) {
  //     setState(() {
  //       _loading = false;
  //     });
  //   }
  // }

  // Future<void> _signInWithPhoneNumber() async {
  //   setState(() {
  //     _loading = true;
  //   });
  //   try {
  //     final PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: _verificationId!,
  //       smsCode: _smsController.text,
  //     );
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //     setState(() {
  //       _loading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _loading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      backgroundColor: const Color.fromARGB(235, 224, 249, 208),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
                child: Text(
              "OTP Login",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Phone Number',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16.0),
            OutlinedButton(
              child: const Text(
                'Send OTP',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                verifyPhoneNumber();
                // _sendCodeToPhoneNumber();
              },
            ),
            const SizedBox(height: 26.0),
            const Text(
              'OTP',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _smsController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            OutlinedButton(
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // _signInWithPhoneNumber();
              },
            ),
          ],
        ),
      ),
    );
  }

  verifyPhoneNumber() {
    auth.verifyPhoneNumber(
        phoneNumber: _phoneNumberController.text,
        verificationCompleted: ((PhoneAuthCredential credential) {
          auth
              .signInWithCredential(credential)
              .then((value) => {print("Logged successfully")});
        }),
        verificationFailed: (FirebaseAuthException exception) {
          print(exception.message);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          verificationIdReceived = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }
}
