# Painel ONG — Sistema de Doações

Painel Administrativo Desktop em Flutter para gestão de doações, estoque, beneficiários e distribuições.

## Como usar

1. Copie `.env.example` para `.env`
2. Ajuste `API_BASE_URL`
3. Rode `flutter pub get`
4. Execute `flutter run -d windows`

## Estrutura

- `lib/core`: configuração, tema, rede e utilitários
- `lib/data`: models, repositórios e serviço local
- `lib/presentation`: layouts, widgets e telas

## Tecnologias

- Flutter desktop Windows
- DIO, GoRouter, Provider, GetIt, json_serializable
- fl_chart, shared_preferences, flutter_dotenv
