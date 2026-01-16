import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // 1. Controllers to capture user input
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // 2. Validation Logic Function
  void validateAndRegister() {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    RegExp passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$');
    // Check if any field is empty
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showSnackBar("All fields are required!", Colors.orange);
    } 
    // Check if email contains @ and .
    else if (!email.contains("@") || !email.contains(".")) {
      _showSnackBar("Please enter a valid email address!", Colors.red);
    } 
    // Check if password is long enough
    else if (!passwordRegExp.hasMatch(password)) {
      _showSnackBar("Password needs at least 1 letter and 1 number!", Colors.red);}
    else if (password.length < 6) {
      _showSnackBar("Password must be at least 6 characters!", Colors.red);
    } 
    // If all conditions pass
    else {
      _showSnackBar("Account created for $name!", Colors.green);
      
      // Navigate back to Login Page after a small delay
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    }
  }

  // Helper method to show messages
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person_add, size: 80, color: Colors.blue),
              const SizedBox(height: 20),
              
              // Name Field
              _buildTextField(nameController, "Full Name", Icons.person, false),
              const SizedBox(
                width: 300,
                height: 55,
              ),

              // Email Field
              _buildTextField(emailController, "Email", Icons.email, false),
              const SizedBox(
                width: 250,
                height: 55,
              ),

              // Password Field
              _buildTextField(passwordController, "Password", Icons.lock, true),
              const SizedBox(
                width: 250,
                height: 55,),

              // Register Button
              SizedBox(
                width: 250,
                height: 55,
                child: ElevatedButton(
                  onPressed: validateAndRegister, // Runs the condition check
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable TextField Widget
  Widget _buildTextField(TextEditingController controller, String label, IconData icon, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }
}