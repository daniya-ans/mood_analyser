import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  bool isLogin = true;
  bool loading = false;

  Future<void> submit() async {

    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty) {

      showMessage("Please fill all fields");
      return;
    }

    if (!isLogin && usernameController.text.isEmpty) {
      showMessage("Please enter username");
      return;
    }

    setState(() {
      loading = true;
    });

    try {

      if (isLogin) {

        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

      } else {

        UserCredential user =
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        await user.user?.updateDisplayName(
          usernameController.text.trim(),
        );
      }

      if (mounted) {
        Navigator.pushReplacementNamed(context, "/home");
      }

    } on FirebaseAuthException catch (e) {

      showMessage(e.message ?? "Authentication failed");

    } finally {

      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  void showMessage(String message) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(25),

          child: Column(

            children: [

              const Icon(
                Icons.self_improvement,
                size: 80,
                color: Colors.teal,
              ),

              const SizedBox(height: 15),

              const Text(
                "Mood Advisor",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                isLogin
                    ? "Welcome Back!"
                    : "Create Your Account",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 30),

              if (!isLogin)
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),

              if (!isLogin)
                const SizedBox(height: 15),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,

                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: passwordController,
                obscureText: true,

                decoration: const InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton(

                  onPressed: loading ? null : submit,

                  child: loading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : Text(
                    isLogin
                        ? "LOGIN"
                        : "REGISTER",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextButton(

                onPressed: () {

                  setState(() {
                    isLogin = !isLogin;
                  });

                },

                child: Text(
                  isLogin
                      ? "Don't have an account? Register"
                      : "Already have an account? Login",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}