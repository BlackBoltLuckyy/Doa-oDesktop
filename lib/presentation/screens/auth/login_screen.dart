import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_tokens.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/gradient_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final error = await ref.read(authProvider.notifier).login(
          _emailController.text.trim(),
          _passwordController.text,
        );

    if (error != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: AppColors.statusRejected,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(24),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Theme(
      data: AppTheme.darkTheme,
      child: Scaffold(
        backgroundColor: AppColors.bgDark,
        body: Stack(
          children: [
            const _BackgroundOrbs(),
            Center(
              child: authState.isInitializing
                  ? const CircularProgressIndicator(color: AppColors.primary)
                  : _GlassCard(child: _buildForm(authState.isLoading)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(bool isLoading) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.favorite, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              RichText(
                text: TextSpan(
                  style: AppTextStyles.heading.copyWith(color: AppColors.textDark),
                  children: const [
                    TextSpan(text: 'Doe'),
                    TextSpan(text: '+', style: TextStyle(color: AppColors.primary)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text(
            'Bem-vindo de volta',
            style: AppTextStyles.pageTitle.copyWith(color: AppColors.textDark),
          ),
          const SizedBox(height: 6),
          Text(
            'Acesse com seu e-mail institucional para continuar.',
            style: AppTextStyles.body.copyWith(color: AppColors.textMutedDark),
          ),
          const SizedBox(height: 32),

          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: AppColors.textDark),
            decoration: const InputDecoration(
              labelText: 'E-mail',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'E-mail é obrigatório.';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
                return 'Digite um e-mail válido.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: const TextStyle(color: AppColors.textDark),
            decoration: InputDecoration(
              labelText: 'Senha',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                ),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Senha é obrigatória.';
              }
              if (value.length < 6) {
                return 'Senha deve ter ao menos 6 caracteres.';
              }
              return null;
            },
          ),
          const SizedBox(height: 32),

          GradientButton(
            label: 'Entrar',
            loading: isLoading,
            expand: true,
            onPressed: isLoading ? null : _onLogin,
          ),
          const SizedBox(height: 20),

          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Não tem conta? ',
                  style: AppTextStyles.body.copyWith(color: AppColors.textMutedDark),
                ),
                GestureDetector(
                  onTap: () => context.go(AppRoutes.kCadastro),
                  child: Text(
                    'Criar nova conta',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundOrbs extends StatelessWidget {
  const _BackgroundOrbs({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -120,
          left: -100,
          child: _Orb(color: AppColors.primary.withValues(alpha: 0.35), size: 360),
        ),
        Positioned(
          bottom: -140,
          right: -120,
          child: _Orb(color: AppColors.secondary.withValues(alpha: 0.28), size: 420),
        ),
      ],
    );
  }
}

class _Orb extends StatelessWidget {
  final Color color;
  final double size;

  const _Orb({super.key, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;

  const _GlassCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: 460,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: AppColors.surfaceDark.withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
          ),
          child: child,
        ),
      ),
    );
  }
}
