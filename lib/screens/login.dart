import 'package:flutter/material.dart';
import 'package:login_dart/providers/auth_provider.dart' as MyAppAuthProvider;
import 'package:login_dart/screens/home_screen.dart';
import 'package:login_dart/screens/registrar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Correo electrónico'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
               
                if (!_isValidEmail(_emailController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('El formato del correo electrónico es inválido'),
                    ),
                  );
                  return;
                }

                try {
                  await Provider.of<MyAppAuthProvider.AuthProvider>(context, listen: false)
                      .login(
                    _emailController.text,
                    _passwordController.text,
                  );

                
                  if (Provider.of<MyAppAuthProvider.AuthProvider>(context, listen: false).isAuthenticated) {
             
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Inicio de sesión exitoso'),
                      ),
                    );

              
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  } else {
                 
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Credenciales inválidas'),
                      ),
                    );
                  }
                } on FirebaseAuthException catch (e) {
     
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error durante el inicio de sesión. Verifica tus credenciales.'),
                    ),
                  );
                } catch (e) {
             
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error durante el inicio de sesión. Verifica tus credenciales.'),
                    ),
                  );
                }
              },
              child: Text('Iniciar sesión'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
         
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text('¿No tienes cuenta? Regístrate'),
            ),
          ],
        ),
      ),
    );
  }


  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }
}
