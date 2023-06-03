import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:talk_to_me/components/auth_form.dart';
import 'package:talk_to_me/core/models/auth_form_data.dart';
import 'package:talk_to_me/core/services/auth/auth_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoading = false;

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      if (!mounted) return;
      setState(() => isLoading = true);
      if (formData.isLogin) {
        await AuthService().login(formData.email, formData.password);
      } else {
        log("Sign up");
        await AuthService().signup(
            formData.name, formData.email, formData.password, formData.image!);
      }
    } catch (e) {
      log(e.toString(), name: 'Error');
    } finally {
      if (!mounted) return;

      setState(() => isLoading = false);
    }
    log("Auth Page...");
    log(formData.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(onSubmit: _handleSubmit),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Colors.orange[700],
                ),
              ),
            )
        ]));
  }
}
