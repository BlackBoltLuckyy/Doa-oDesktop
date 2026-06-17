import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../providers/register_provider.dart';

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

  // Estado do validador de e-mail em tempo real
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

    // Exibe erro via SnackBar sem sair da tela
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

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Center(
        child: state.isSuccess
            ? _buildSuccessState(state.successMessage ?? '')
            : _buildForm(state.isLoading),
      ),
    );
  }

  // ── Tela de sucesso ────────────────────────────────────────────────────────

  Widget _buildSuccessState(String mensagem) {
    final email = _emailController.text.trim();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.statusApproved.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mark_email_read_outlined,
                  size: 36,
                  color: AppColors.statusApproved,
                ),
              ),
              const SizedBox(height: 24),
              Text('Cadastro realizado!', style: AppTextStyles.displayTitle),
              const SizedBox(height: 12),
              Text(
                mensagem.isNotEmpty
                    ? mensagem
                    : 'Verifique seu e-mail para ativar a conta.',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(color: Colors.black54),
              ),
              if (email.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.email_outlined,
                        size: 16,
                        color: Colors.black45,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        email,
                        style: AppTextStyles.body.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => context.go('/login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Voltar ao login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Formulário de cadastro ─────────────────────────────────────────────────

  Widget _buildForm(bool isLoading) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: SizedBox(
              width: 480,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Painel ONG',
                          style: AppTextStyles.heading
                              .copyWith(color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Text('Criar conta', style: AppTextStyles.displayTitle),
                    const SizedBox(height: 6),
                    Text(
                      'Preencha os dados para cadastrar um novo operador.',
                      style:
                          AppTextStyles.body.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(height: 28),

                    // Nome completo
                    TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome completo',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Nome é obrigatório.';
                        }
                        if (v.trim().split(' ').length < 2) {
                          return 'Informe nome e sobrenome.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // E-mail com validador em tempo real
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (v) => setState(() => _emailValue = v),
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            prefixIcon: const Icon(Icons.email_outlined),
                            suffixIcon: _emailDigitado
                                ? Icon(
                                    _emailValido
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: _emailValido
                                        ? AppColors.statusApproved
                                        : AppColors.statusRejected,
                                    size: 20,
                                  )
                                : null,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: _emailDigitado
                                    ? (_emailValido
                                        ? AppColors.statusApproved
                                        : AppColors.statusRejected)
                                    : AppColors.borderColor,
                                width: _emailDigitado ? 1.5 : 1,
                              ),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'E-mail é obrigatório.';
                            }
                            if (!_emailValido) {
                              return 'Digite um e-mail válido (ex: nome@dominio.com).';
                            }
                            return null;
                          },
                        ),
                        if (_emailDigitado && !_emailValido)
                          Padding(
                            padding: const EdgeInsets.only(top: 6, left: 4),
                            child: Text(
                              'Formato inválido — use nome@dominio.com',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.statusRejected,
                              ),
                            ),
                          ),
                        if (_emailDigitado && _emailValido)
                          Padding(
                            padding: const EdgeInsets.only(top: 6, left: 4),
                            child: Text(
                              'E-mail válido',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.statusApproved,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Papel
                    DropdownButtonFormField<String>(
                      value: _papel,
                      decoration: const InputDecoration(
                        labelText: 'Perfil de acesso',
                        prefixIcon: Icon(Icons.badge_outlined),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'OPERADOR',
                          child: Text('Operador'),
                        ),
                        DropdownMenuItem(
                          value: 'ADMIN',
                          child: Text('Administrador'),
                        ),
                      ],
                      onChanged: (v) => setState(() => _papel = v ?? 'OPERADOR'),
                    ),
                    const SizedBox(height: 16),

                    // Senha
                    TextFormField(
                      controller: _senhaController,
                      obscureText: _obscureSenha,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: const Icon(Icons.lock_outline),
                        helperText: 'Mínimo 8 caracteres',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureSenha
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () =>
                              setState(() => _obscureSenha = !_obscureSenha),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Senha é obrigatória.';
                        if (v.length < 8) {
                          return 'A senha deve ter ao menos 8 caracteres.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Confirmar senha
                    TextFormField(
                      controller: _confirmaSenhaController,
                      obscureText: _obscureConfirma,
                      decoration: InputDecoration(
                        labelText: 'Confirmar senha',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirma
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () => setState(
                              () => _obscureConfirma = !_obscureConfirma),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Confirmação é obrigatória.';
                        }
                        if (v != _senhaController.text) {
                          return 'As senhas não coincidem.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // Botão cadastrar
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _onRegistrar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Criar conta',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Link para login
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Já tem uma conta? ',
                            style: AppTextStyles.body
                                .copyWith(color: Colors.black54),
                          ),
                          GestureDetector(
                            onTap: () => context.go('/login'),
                            child: Text(
                              'Fazer login',
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
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
