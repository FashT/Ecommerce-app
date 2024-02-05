import 'package:ecomm_app/screen/root_screens.dart';
import 'package:ecomm_app/services/my_app_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});
  Future<void> _googleSignIn({required BuildContext context}) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          final authResults = await FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            ),
          );
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            Navigator.pushReplacementNamed(context, RootScreen.routeName);
          });
        } on FirebaseAuthException catch (error) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await MyAppMethods.showErrorOrWarningDialogue(
              context: context,
              subtitle: 'An error has been occured here ${error.message}',
              fct: () async {},
            );
          });
        } catch (error) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await MyAppMethods.showErrorOrWarningDialogue(
              context: context,
              subtitle: 'An error has been occured here $error',
              fct: () async {},
            );
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        // backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        _googleSignIn(context: context);
      },
      icon: const Icon(
        Ionicons.logo_google,
      ),
      label: const Text(
        'Sign in with google',
      ),
    );
  }
}
