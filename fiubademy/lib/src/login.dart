import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                const Image(
                  image: AssetImage('images/ubademy.png')
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'example@email.com',
                    labelText: 'Email',
                    filled: true,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
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
                  obscureText: _passwordObscured,
                ),
                const SizedBox(height: 16.0),
                const ElevatedButton(
                  onPressed: null,
                  child: Text('Sign in'),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: null,
                      child: Text('Sign up'),
                    )
                  ],
                ),
                const Divider(),
                SizedBox(
                  width: double.infinity,
                  child: SignInButton(
                    Buttons.Google,
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
