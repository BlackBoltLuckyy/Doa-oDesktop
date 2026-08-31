import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_tokens.dart';
import '../../providers/register_provider.dart';
import '../../widgets/common/gradient_button.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();

  bool _obscureSenha = true;
  bool _obscureConfirma = true;
  String _papel = 'OPERADOR';

  String _emailValue = '';
  bool get _emailValido =>
      _emailValue.isNotEmpty &&
      RegExp(r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$')
          .hasMatch(_emailValue);
  bool get _emailDigitado => _emailValue.isNotEmpty;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _confirmaSenhaController.dispose();
    super.dispose();
  }

  Future<void> _onRegistrar() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(registerProvider.notifier).register(
          nome: _nomeController.text.trim(),
          email: _emailController.text.trim(),
          senha: _senhaController.text,
          papel: _papel,
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerProvider);

    ref.listen<RegisterState>(registerProvider, (prev, next) {
      if (next.error != null && next.error != prev?.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: AppColors.statusRejected,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(24),
          ),
        );
      }
    });

    return Theme(
      data: AppTheme.darkTheme,
      child: Scaffold(
        backgroundColor: AppColors.bgDark,
        body: Stack(
          children: [
            Positioned(
              top: -120,
              left: -100,
              child: _Orb(color: AppColors.primary.withValues(alpha: 0.35), size: 360),
            ),
            Positioned(
              bottom: -140,
              right: -120,
              child: _Orb(color: AppColors.accent.withValues(alpha: 0.25), size: 420),
            ),
            Center(
              child: state.isSuccess
                  ? _GlassCard(width: 460, child: _buildSuccessState(state.successMessage ?? ''))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: _GlassCard(width: 480, child: _buildForm(state.isLoading)),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessState(String mensagem) {
    final email = _emailController.text.trim();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.statusApproved.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.mark_email_read_outlined, size: 36, color: AppColors.statusApproved),
        ),
        const SizedBox(height: 24),
        Text(
          'Cadastro realizado!',
          style: AppTextStyles.pageTitle.copyWith(color: AppColors.textDark),
        ),
        const SizedBox(height: 12),
        Text(
          mensagem.isNotEmpty ? mensagem : 'Verifique seu e-mail para ativar a conta.',
          textAlign: TextAlign.center,
          style: AppTextStyles.body.copyWith(color: AppColors.textMutedDark),
        ),
        if (email.isNotEmpty) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(AppRadius.input),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.email_outlined, size: 16, color: AppColors.textMutedDark),
                const SizedBox(width: 8),
                Text(
                  email,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 32),
        GradientButton(
          label: 'Voltar ao login',
          expand: true,
          onPressed: () => context.go('/login'),
        ),
      ],
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
          Text('Criar conta', style: AppTextStyles.pageTitle.copyWith(color: AppColors.textDark)),
          const SizedBox(height: 6),
          Text(
            'Preencha os dados para cadastrar um novo operador.',
            style: AppTextStyles.body.copyWith(color: AppColors.textMutedDark),
          ),
          const SizedBox(height: 28),

          TextFormField(
            controller: _nomeController,
            style: const TextStyle(color: AppColors.textDark),
            decoration: const InputDecoration(
              labelText: 'Nome completo',
              prefixIcon: Icon(Icons.person_outline),
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Nome é obrigatório.';
              if (v.trim().split(' ').length < 2) return 'Informe nome e sobrenome.';
              return null;
            },
          ),
          const SizedBox(height: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: AppColors.textDark),
                onChanged: (v) => setState(() => _emailValue = v),
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: const Icon(Icons.email_outlined),
                  suffixIcon: _emailDigitado
                      ? Icon(
                          _emailValido ? Icons.check_circle : Icons.cancel,
                          color: _emailValido ? AppColors.statusApproved : AppColors.statusRejected,
                          size: 20,
                        )
                      : null,
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'E-mail é obrigatório.';
                  if (!_emailValido) return 'Digite um e-mail válido (ex: nome@dominio.com).';
                  return null;
                },
              ),
              if (_emailDigitado)
                Padding(
                  padding: const EdgeInsets.only(top: 6, left: 4),
                  child: Text(
                    _emailValido ? 'E-mail válido' : 'Formato inválido — use nome@dominio.com',
                    style: TextStyle(
                      fontSize: 11,
                      color: _emailValido ? AppColors.statusApproved : AppColors.statusRejected,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            initialValue: _papel,
            style: const TextStyle(color: AppColors.textDark),
            decoration: const InputDecoration(
              labelText: 'Perfil de acesso',
              prefixIcon: Icon(Icons.badge_outlined),
            ),
            items: const [
              DropdownMenuItem(value: 'OPERADOR', child: Text('Operador')),
              DropdownMenuItem(value: 'ADMIN', child: Text('Administrador')),
            ],
            onChanged: (v) => setState(() => _papel = v ?? 'OPERADOR'),
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _senhaController,
            obscureText: _obscureSenha,
            style: const TextStyle(color: AppColors.textDark),
            decoration: InputDecoration(
              labelText: 'Senha',
              prefixIcon: const Icon(Icons.lock_outline),
              helperText: 'Mínimo 8 caracteres',
              suffixIcon: IconButton(
                icon: Icon(_obscureSenha ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                onPressed: () => setState(() => _obscureSenha = !_obscureSenha),
              ),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Senha é obrigatória.';
              if (v.length < 8) return 'A senha deve ter ao menos 8 caracteres.';
              return null;
            },
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _confirmaSenhaController,
            obscureText: _obscureConfirma,
            style: const TextStyle(color: AppColors.textDark),
            decoration: InputDecoration(
              labelText: 'Confirmar senha',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(_obscureConfirma ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                onPressed: () => setState(() => _obscureConfirma = !_obscureConfirma),
              ),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Confirmação é obrigatória.';
              if (v != _senhaController.text) return 'As senhas não coincidem.';
              return null;
            },
          ),
          const SizedBox(height: 32),

          GradientButton(
            label: 'Criar conta',
            loading: isLoading,
            expand: true,
            onPressed: isLoading ? null : _onRegistrar,
          ),
          const SizedBox(height: 20),

          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Já tem uma conta? ', style: AppTextStyles.body.copyWith(color: AppColors.textMutedDark)),
                GestureDetector(
                  onTap: () => context.go('/login'),
                  child: Text(
                    'Fazer login',
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
  final double width;

  const _GlassCard({super.key, required this.child, required this.width});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: width,
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
