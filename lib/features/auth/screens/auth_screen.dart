import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';

enum AuthEnum {
  signup,
  signIn,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth_screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // radio enum
  AuthEnum _auth = AuthEnum.signup;
  // signup and signIn global keys
  final signupGlobalKey = GlobalKey<FormState>();
  final signInGlobalKey = GlobalKey<FormState>();

  //text field controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    //dispose all controllers ( close them )
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // welcome title
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Radio for signup
              ListTile(
                tileColor: _auth == AuthEnum.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: AuthEnum.signup,
                  groupValue: _auth,
                  onChanged: (value) {
                    setState(() {
                      _auth = value!;
                    });
                  },
                ),
              ),
              // text form fields for signup
              if (_auth == AuthEnum.signup)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  padding: EdgeInsets.all(12.r),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: signupGlobalKey,
                    child: Column(
                      children: [
                        //name field
                        CustomTextField(
                          controller: _nameController,
                          hint: 'Name',
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        // email field
                        CustomTextField(
                            controller: _emailController, hint: 'Email'),
                        SizedBox(
                          height: 12.h,
                        ),
                        // password field
                        CustomTextField(
                            controller: _passwordController, hint: 'Password'),
                        SizedBox(height: 12.h),
                        CustomButton(
                          text: 'SingUp',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              // Radio for signIn
              ListTile(
                tileColor: _auth == AuthEnum.signIn
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: AuthEnum.signIn,
                  groupValue: _auth,
                  onChanged: (value) {
                    setState(() {
                      _auth = value!;
                    });
                  },
                ),
              ),
              if (_auth == AuthEnum.signIn)

                // singIn form and it's fields
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  padding: EdgeInsets.all(12.r),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: signInGlobalKey,
                    child: Column(
                      children: [
                        // email field
                        CustomTextField(
                          controller: _emailController,
                          hint: 'Email',
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        // password field
                        CustomTextField(
                          controller: _passwordController,
                          hint: 'Password',
                        ),
                        SizedBox(height: 12.h),
                        CustomButton(
                          text: 'SignIn',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
