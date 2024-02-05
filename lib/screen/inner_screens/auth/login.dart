import 'package:ecomm_app/screen/inner_screens/auth/forget_password_screen.dart';
import 'package:ecomm_app/screen/inner_screens/auth/register_page.dart';
import 'package:ecomm_app/screen/inner_screens/loading_manager.dart';
import 'package:ecomm_app/screen/root_screens.dart';
import 'package:ecomm_app/widgets/app_name_text.dart';
import 'package:ecomm_app/widgets/subtitle_texts.dart';
import 'package:ecomm_app/widgets/title_texts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../consts/my_validator.dart';
import '../../../services/my_app_methods.dart';
import '../../../widgets/auth/google_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = '/LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLoading = false;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    //focus node
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordController.dispose();
    //focus node
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> loginFct() async {
    // final isValid = _formKey.currentState!.validate;
    FocusScope.of(context).unfocus();

// if (isValid!) {
//   _formKey.currentState!.save();
// }

    try {
      setState(() {
        isLoading = true;
      });
      await auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Fluttertoast.showToast(
        msg: 'Login successful',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16,
      );
      if (!mounted) {
        return;
      }
      Navigator.pushNamed(context, RootScreen.routeName);
    } on FirebaseAuthException catch (error) {
      await MyAppMethods.showErrorOrWarningDialogue(
          context: context,
          subtitle: 'An error has been occurred ${error.message}',
          fct: () {});
    } catch (error) {
      if (!mounted) {
        return;
      }
      await MyAppMethods.showErrorOrWarningDialogue(
          context: context,
          subtitle: 'An error has been occurred $error',
          fct: () {});
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: LoadingManager(
          isLoading: isLoading,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const AppNameText(
                    fontSize: 30,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: TitleText(label: 'Welcome back'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          obscureText: false,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          focusNode: _emailFocusNode,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'Email address',
                            prefixIcon: Icon(IconlyLight.message),
                          ),
                          validator: (value) {
                            return MyValidators.emailValidator(value);
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          obscureText: obscureText,
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          focusNode: _passwordFocusNode,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: 'password',
                            prefixIcon: const Icon(
                              IconlyLight.lock,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          validator: (value) {
                            return MyValidators.passwordValidator(value);
                          },
                          onFieldSubmitted: (value) {
                            loginFct();
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, ForgetPasswordScreen.routeName);
                            },
                            child: const Text(
                              'Forget Password',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(12),
                            ),
                            onPressed: () async {
                              loginFct();
                            },
                            icon: const Icon(
                              Icons.login,
                            ),
                            label: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SubtitleText(
                          label: 'Or connect using google'.toUpperCase(),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: kBottomNavigationBarHeight,
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight,
                                  child: FittedBox(
                                    child: GoogleButton(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(12),
                                      // backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Text('Guest'),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SubtitleText(
                        label: 'Don\'t have an account?',
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RegisterPageScreen.routeName);
                        },
                        child: const SubtitleText(
                          label: 'Sign up',
                          textDecoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
