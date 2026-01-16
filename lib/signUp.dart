import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Password visibility
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // Validation logic
  void validateAndRegister() {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    RegExp passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$');

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showSnackBar("All fields are required!", Colors.orange);
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      _showSnackBar("Enter a valid email address!", Colors.red);
    } else if (!passwordRegExp.hasMatch(password)) {
      _showSnackBar(
        "Password must contain at least 1 letter and 1 number!",
        Colors.red,
      );
    } else if (password.length < 6) {
      _showSnackBar("Password must be at least 6 characters!", Colors.red);
    } else if (password != confirmPassword) {
      _showSnackBar("Passwords do not match!", Colors.red);
    } else {
      _showSnackBar("Account created successfully!", Colors.green);

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    }
  }

  // Snackbar helper
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 149, 78, 78),
      appBar: AppBar(
        title: const Text("Create Account"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 6,
            
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.person_2_outlined,
                    size: 70,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Full Name
                  SizedBox(
                    width:350,
                    height:55,
                    child:_buildTextField(
                      controller: nameController,
                      label: "Username",
                      icon: Icons.person,
                      isPassword: false,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Email
                  SizedBox(
                    width:350,
                    height:55,
                    child:_buildTextField(
                      controller: emailController,
                      label: "Email",
                      icon: Icons.email,
                      isPassword: false,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Password
                  SizedBox(
                    width:350,
                    height:55,
                    child:_buildTextField(
                      controller: passwordController,
                      label: "Password",
                      icon: Icons.lock,
                      isPassword: true,
                      isConfirm: false,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Confirm Password
                  SizedBox(
                    width:350,
                    height:55, 
                    child:_buildTextField(                                 
                      controller: confirmPasswordController,
                      label: "Confirm Password",
                      icon: Icons.lock_outline,
                      isPassword: true,
                      isConfirm: true,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Button
                  SizedBox(
                    width: 250,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: validateAndRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Create Account",
                        style: TextStyle(fontSize: 15),
                      ),
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

  // Compact reusable TextField
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isPassword,
    bool isConfirm = false,
  }) {
    bool obscure =
        isConfirm ? _obscureConfirmPassword : _obscurePassword;

    return TextField(
      controller: controller,
      obscureText: isPassword ? obscure : false,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        labelText: label,
        labelStyle: const TextStyle(fontSize: 14),
        prefixIcon: Icon(icon, size: 20),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscure
                      ? Icons.visibility_off
                      : Icons.visibility,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    if (isConfirm) {
                      _obscureConfirmPassword =
                          !_obscureConfirmPassword;
                    } else {
                      _obscurePassword = !_obscurePassword;
                    }
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
