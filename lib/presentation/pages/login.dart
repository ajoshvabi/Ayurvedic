import 'package:ayurvedic/data/api.dart';
import 'package:ayurvedic/presentation/pages/home.dart';
import 'package:ayurvedic/presentation/widgets/customtextfiel.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  ApiClient api = ApiClient();

  void _loginUser() async {
    try {
      final response =
          await api.login(_emailController.text, _passwordController.text);

      if (response['status'] == true) {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Home()));
      } else {
        _emailController.clear();
        _passwordController.clear();
      }
    } catch (e) {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Image.asset(
                  'assets/loginbg.jpg',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        "Login Or Register To Book Your Appointments",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            height: 1.3),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomTextField(
                      text: "Email",
                      controller: _emailController,
                      labelText: "Enter Your Email",
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomTextField(
                      text: "Password",
                      controller: _passwordController,
                      labelText: "Enter Password",
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _loginUser(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 19, 93, 21),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text("Login"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text:
                          "By creating a logging into an account you are agreeing with our ",
                      style: TextStyle(color: Colors.black54),
                      children: [
                        TextSpan(
                          text: "Terms and Conditions",
                          style: TextStyle(color: Colors.blue),
                        ),
                        TextSpan(
                          text: " and ",
                          style: TextStyle(color: Colors.black54),
                        ),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
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
