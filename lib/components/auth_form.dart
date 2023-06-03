import 'dart:io';

import 'package:flutter/material.dart';
import 'package:talk_to_me/components/user_image_picker.dart';
import 'package:talk_to_me/core/models/auth_form_data.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({required this.onSubmit, super.key});

  @override
  State<StatefulWidget> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();
  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    if (_formData.image == null && _formData.isSignup) {
      return _showError("Imagem não selecionada!");
    }

    widget.onSubmit(_formData);
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg), backgroundColor: Theme.of(context).errorColor));
  }

  _handleImagePick(File image) {
    _formData.image = image;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_formData.isSignup)
                  UserImagePicker(
                    onImagePick: _handleImagePick,
                  ),
                if (_formData.isSignup)
                  TextFormField(
                    decoration: const InputDecoration(label: Text("Nome")),
                    initialValue: _formData.name,
                    key: const ValueKey("name"),
                    onChanged: ((name) => _formData.name = name),
                    validator: ((tempName) {
                      final name = tempName ?? "";
                      if (name.isEmpty) {
                        return "O campo nome é obrigatório.";
                      }
                      return null;
                    }),
                  ),
                TextFormField(
                  decoration: const InputDecoration(label: Text("E-mail")),
                  key: const ValueKey("email"),
                  onChanged: ((email) => _formData.email = email),
                  validator: ((tempEmail) {
                    final email = tempEmail ?? "";
                    if (email.isEmpty) {
                      return "O campo nome é obrigatório.";
                    }
                    if (!email.contains("@")) {
                      return "Insira um email válido.";
                    }

                    return null;
                  }),
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text("Senha")),
                  key: const ValueKey("password"),
                  onChanged: ((pasword) => _formData.password = pasword),
                  validator: ((tempPassword) {
                    final password = tempPassword ?? "";
                    if (password.isEmpty) {
                      return "O campo nome é obrigatório.";
                    }
                    if (password.length < 6) {
                      return "A senha deve ter mais de 6 caracteres.";
                    }
                    return null;
                  }),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: _submit,
                    child: Text(
                      _formData.isLogin ? "Entrar" : "Cadastrar",
                      style: const TextStyle(color: Colors.white),
                    )),
                const SizedBox(height: 10),
                TextButton(
                    onPressed: (() {
                      setState(() {
                        _formData.toggleAuthMode();
                      });
                    }),
                    child: Text(
                      _formData.isLogin
                          ? "Criar uma nova conta ?"
                          : "Já possui conta ?",
                    ))
              ],
            )),
      ),
    );
  }
}
