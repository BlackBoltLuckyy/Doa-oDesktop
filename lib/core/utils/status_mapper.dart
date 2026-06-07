import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class StatusMapper {
  StatusMapper._();

  static Color getColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDENTE':
        return AppColors.statusPending;
      case 'APROVADO':
        return AppColors.statusApproved;
      case 'RECUSADO':
        return AppColors.statusRejected;
      case 'EM_ESTOQUE':
        return AppColors.statusInStock;
      case 'ENTREGUE':
        return AppColors.statusDelivered;
      default:
        return Colors.grey;
    }
  }

  static String getLabel(String status) {
    switch (status.toUpperCase()) {
      case 'PENDENTE':
        return 'Pendente';
      case 'APROVADO':
        return 'Aprovado';
      case 'RECUSADO':
        return 'Recusado';
      case 'EM_ESTOQUE':
        return 'Em estoque';
      case 'ENTREGUE':
        return 'Entregue';
      default:
        return 'Desconhecido';
    }
  }
}
