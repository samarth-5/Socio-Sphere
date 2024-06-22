import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//Authentication
import 'package:socio_sphere/authentication/auth_methods.dart';
import 'package:socio_sphere/responsive/mobile_screen_layout.dart';
import 'package:socio_sphere/responsive/responsive_layout_screen.dart';
import 'package:socio_sphere/responsive/web_screen_layout.dart';
import 'package:socio_sphere/screens/signup_screen.dart';

//Utils
import 'package:socio_sphere/utils/colors.dart';
import 'package:socio_sphere/utils/utils.dart';

//Widgets
import 'package:socio_sphere/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().logInUser(
        email: _emailController.text, password: _passwordController.text);
    setState(() {
      _isLoading = false;
    });
    if (res == 'success') {
      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const HomeScreen()));
      showSnackBar(context, 'Logged in successfully!');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(context, res);
    }
  }

  void navigateToSignup() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              //logo
              SvgPicture.asset(
                'assets/logo.svg',
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),
              //text fields
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              //button
              InkWell(
                onTap: loginUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Log in'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              //Transition to signing up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text('Don\'t have an account? '),
                  ),
                  GestureDetector(
                    onTap: navigateToSignup,
                    child: const Text(
                      ' Signup',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
