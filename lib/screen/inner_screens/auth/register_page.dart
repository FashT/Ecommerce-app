import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm_app/screen/inner_screens/loading_manager.dart';
import 'package:ecomm_app/services/my_app_methods.dart';
import 'package:ecomm_app/widgets/app_name_text.dart';
import 'package:ecomm_app/widgets/auth/pick_image.dart';
import 'package:ecomm_app/widgets/title_texts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../../consts/my_validator.dart';

class RegisterPageScreen extends StatefulWidget {
  static const routeName = '/RegisterPageScreen';
  const RegisterPageScreen({super.key});

  @override
  State<RegisterPageScreen> createState() => _RegisterPageScreenState();
}

class _RegisterPageScreenState extends State<RegisterPageScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _nameFocusNode;
  late final FocusNode _confirmPasswordFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool confirmObscureText = true;
  bool isLoading = false;
  final auth = FirebaseAuth.instance;
  String? userImageUrl;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    //focus node
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _nameFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
    //focus node
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _nameFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  XFile? _pickImage;

  Future<void> regFct() async {
    final isValid = _formKey.currentState!.save();
      FocusScope.of(context).unfocus();
    if (_pickImage == null) {
      MyAppMethods.showErrorOrWarningDialogue(
        context: context,
        subtitle: 'make sure to pick an image',
        fct: () {},
      );
      return;
    }
  if (isValid) {
   _formKey.currentState!.save();
  

    try {
      setState(() {
        isLoading = true;
      });
      final ref = FirebaseStorage.instance
          .ref()
          .child('user images')
          .child('${_emailController.text.trim()}.jpg');
      await ref.putFile(
        File(_pickImage!.path),
      );
      userImageUrl = await ref.getDownloadURL();
      await auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      User? user = auth.currentUser;
      final uid = user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'userId':uid,
        'userName':_nameController.text,
        'userImage':userImageUrl,
        'userEmail': _emailController.text.toLowerCase(),
        'createdAt': Timestamp.now(),
        'userWish': [],
        'userCart': [],

      });
      Fluttertoast.showToast(
        msg: 'Account created successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
      );
    } on FirebaseAuthException catch (error) {
      if (!mounted) {
        return;
      }
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

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await MyAppMethods.imagePickerDialog(
        context: context,
        cameraFCT: () async {
          _pickImage = await picker.pickImage(source: ImageSource.camera);
          setState(() {});
        },
        galleryFCT: () async {
          _pickImage = await picker.pickImage(
            source: ImageSource.gallery,
          );
          setState(() {});
        },
        removeFCT: () {
          setState(() {
            _pickImage = null;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(label: 'Welcome'),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Your welcome message',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: size.width * 0.3,
                    width: size.width * 0.3,
                    child: PickImageWidget(
                      function: () async {
                        await localImagePicker();
                      },
                      pickedImage: _pickImage,
                    ),
                  ),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          obscureText: false,
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          focusNode: _nameFocusNode,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'Full name',
                            prefixIcon: Icon(IconlyLight.message),
                          ),
                          validator: (value) {
                            return MyValidators.displayNameValidator(value);
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_emailFocusNode);
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
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
                            FocusScope.of(context)
                                .requestFocus(_confirmPasswordFocusNode);
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          obscureText: confirmObscureText,
                          controller: _confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          focusNode: _confirmPasswordFocusNode,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: 'Confirm password',
                            prefixIcon: const Icon(
                              IconlyLight.lock,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  confirmObscureText = !confirmObscureText;
                                });
                              },
                              icon: Icon(
                                confirmObscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          validator: (value) {
                            return MyValidators.passwordValidator(value);
                          },
                          onFieldSubmitted: (value) {
                            regFct();
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.lightBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(12),
                            ),
                            onPressed: () async {
                              regFct();
                            },
                            icon: const Icon(
                              Icons.person_add,
                            ),
                            label: const Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
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
      ),
    );
  }
}
}