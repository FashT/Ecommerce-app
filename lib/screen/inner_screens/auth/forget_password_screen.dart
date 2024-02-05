import 'package:ecomm_app/consts/my_validator.dart';
import 'package:ecomm_app/services/assets_manager.dart';

import 'package:ecomm_app/widgets/app_name_text.dart';
import 'package:ecomm_app/widgets/subtitle_texts.dart';
import 'package:ecomm_app/widgets/title_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';



class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgotPasswordScreen';
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late final TextEditingController _emailController;
  late final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
    }
    super.dispose();
  }

  Future<void> _forgetPassFct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppNameText(
          fontSize: 22,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: ListView(
            // shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            physics: const BouncingScrollPhysics(),
            children: [
              // section 1 - header
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                AssetsManager.forgotPassword,
                width: size.width * 0.6,
                height: size.width * 0.6,
              ),
              const SizedBox(
                height: 10,
              ),
              const TitleText(
                label: 'Forgot password',
                fontSize: 22,
              ),
              const SubtitleText(
                label:
                    'Please enter the email address you \'d like your password reset information sent to',
              ),
              const SizedBox(
                height: 40,
              ),

              Form(
                child: TextFormField(
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'your email@yahoo.com',
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(12),
                      child: const Icon(
                        IconlyLight.message,
                      ),
                    ),
                    filled: true,
                  ),
                  validator: (value) {
                    return MyValidators.emailValidator(value);
                  },
                  onFieldSubmitted: (_) {
                    // Move focus to the field when the next the button
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    // backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    _forgetPassFct();
                  },
                  icon: const Icon(IconlyBold.send),
                  label: const Text('Request link'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
