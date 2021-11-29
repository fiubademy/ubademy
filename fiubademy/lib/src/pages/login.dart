import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'package:fiubademy/src/pages/signup.dart';
import 'package:fiubademy/src/services/server.dart';
import 'package:fiubademy/src/services/auth.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Image(image: AssetImage('images/ubademy.png')),
              const SizedBox(height: 16.0),
              const LogInForm(),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    child: const Text('Sign up'),
                  )
                ],
              ),
              const Divider(),
              const GoogleLogInButton()
            ],
          ),
        ),
      ),
    );
  }
}

class LogInForm extends StatefulWidget {
  const LogInForm({Key? key}) : super(key: key);

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  bool _passwordObscured = true;
  bool isLoading = false;
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty || !Server.isValidEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  void _login() async {
    setState(() {
      isLoading = true;
    });
    FocusScope.of(context).unfocus();
    if (_loginFormKey.currentState!.validate()) {
      Auth auth = Provider.of<Auth>(context, listen: false);
      String? result = await Server.login(
          auth, _emailController.text, _passwordController.text);
      if (result != null) {
        final snackBar = SnackBar(content: Text(result));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            validator: (value) => _validateEmail(value),
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              hintText: 'example@email.com',
              labelText: 'Email',
              filled: true,
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            validator: (value) => _validatePassword(value),
            obscureText: _passwordObscured,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordObscured = !_passwordObscured;
                      });
                    },
                    icon: Icon(_passwordObscured
                        ? Icons.visibility_off
                        : Icons.visibility))),
          ),
          const SizedBox(height: 16.0),
          isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () => _login(),
                  child: const Text('Sign in'),
                ),
        ],
      ),
    );
  }
}

class GoogleLogInButton extends StatefulWidget {
  const GoogleLogInButton({Key? key}) : super(key: key);

  @override
  _GoogleLogInButtonState createState() => _GoogleLogInButtonState();
}

class _GoogleLogInButtonState extends State<GoogleLogInButton> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        Provider.of<Auth>(context).deleteAuth();
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  void _googleLogIn(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      const snackBar = SnackBar(content: Text('Google Sign In failed'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SignInButton(
        Buttons.Google,
        onPressed: () => _googleLogIn(context),
      ),
    );
  }
}
