import 'package:flutter/material.dart';

import '../../../core/config/app_config.dart';
import '../../../core/network/api_client.dart';
import '../../../core/service_locator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../data/services/local_storage_service.dart';
import '../../widgets/common/app_card.dart';
import '../../widgets/common/app_text_field.dart';
import '../../widgets/common/gradient_button.dart';
import '../../widgets/common/page_header.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final TextEditingController _apiUrlController;

  @override
  void initState() {
    super.initState();
    _apiUrlController = TextEditingController(text: sl<AppConfig>().baseUrl);
  }

  @override
  void dispose() {
    _apiUrlController.dispose();
    super.dispose();
  }

  Future<void> _onSaveApiUrl() async {
    final url = _apiUrlController.text.trim();
    if (url.isEmpty) return;

    await sl<LocalStorageService>().saveApiBaseUrl(url);
    sl<ApiClient>().updateBaseUrl(url);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('URL da API atualizada.'),
        backgroundColor: AppColors.statusApproved,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Configurações',
            subtitle: 'Preferências gerais do sistema.',
          ),
          const SizedBox(height: 24),

          AppCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Conexão', style: AppTextStyles.heading.copyWith(color: tokens.text)),
                const SizedBox(height: 4),
                Text(
                  'URL base da API usada pelo aplicativo desktop.',
                  style: AppTextStyles.label.copyWith(color: tokens.textMuted),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'URL base da API',
                        controller: _apiUrlController,
                        hintText: 'http://localhost:8080',
                      ),
                    ),
                    const SizedBox(width: 12),
                    GradientButton(label: 'Salvar', onPressed: _onSaveApiUrl),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          AppCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Geral', style: AppTextStyles.heading.copyWith(color: tokens.text)),
                const SizedBox(height: 16),
                const _SettingsRow(label: 'Dados da ONG'),
                const _SettingsRow(label: 'Usuários do sistema'),
                const _SettingsRow(label: 'Categorias de doação'),
                const _SettingsRow(label: 'Notificações e minha conta'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final String label;

  const _SettingsRow({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.body.copyWith(color: tokens.text)),
          Icon(Icons.chevron_right, color: tokens.textMuted, size: 20),
        ],
      ),
    );
  }
}
