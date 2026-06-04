import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  void _onLogin() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    // TODO: integrar autenticação com API
    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login realizado com sucesso.')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1E2D),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: SizedBox(
              width: 420,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bem-vindo ao painel', style: Theme.of(context).textTheme.displayLarge),
                    const SizedBox(height: 12),
                    const Text('Acesse com seu e-mail e senha para acompanhar as doações.', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'E-mail'),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'E-mail é obrigatório.';
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Digite um e-mail válido.';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Senha'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Senha é obrigatória.';
                        if (value.length < 6) return 'Senha deve ter ao menos 6 caracteres.';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: () {}, child: const Text('Esqueci a senha')),
                        ElevatedButton(
                          onPressed: _loading ? null : _onLogin,
                          child: _loading ? const CircularProgressIndicator() : const Text('Login'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
