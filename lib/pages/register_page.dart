import 'package:flutter/material.dart';
import 'package:movieapp__s/auth/auth_service.dart';
import 'package:movieapp__s/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
   //get auth service
  final authService = AuthService();

  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();


  //sign up button pressed
  void signUp() async {
    // prepare data
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // check passwords match
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context)
        .showSnackBar(
        const SnackBar(content: Text("Passwords don't match")));
      return;
    }
    
    // attempt Sign Up..
    try {
      await authService.signUpWithEmailPassword(email, password);
    

    // navigate to login page
    if (mounted) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful! Please log in.')));
      
      // Navigate back to the login page
      Navigator.pushReplacement( 
        context,
        MaterialPageRoute(builder:(context) => const LoginPage()),
      );
     }
    }

    // catch any error
    catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 58),
        children: [
          // email
          TextField(
            controller: _emailController,  
            decoration: const InputDecoration(labelText: 'Email'),
          ),

          // password
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'), 
            obscureText: true, 
          ),

          // confirm password
          TextField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(labelText: 'Confirm Password'),
            obscureText: true,  
          ),
          
          
          const SizedBox(height: 12),
          // buttton
          ElevatedButton(
            onPressed: signUp,
            child: const Text('Sign Up'),
            ),

            const SizedBox(height: 12),        

            // TextButton( 
            //   onPressed: () {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(builder: (context) => const LoginPage()),
            //     );
            //   },
            //   child: const Text('Already/ have an account? Log in'),
            // ),
          
                    // go to register page to sign up
          Row(
            children: [
              const Text("Already have an account?"),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                child: const Text('Login Now'),
              ),
            ]
          ),
        ],
      )
    ); 
   }
 }

