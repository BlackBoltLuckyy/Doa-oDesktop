import 'package:flutter/material.dart';

import '../../../core/utils/status_mapper.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: StatusMapper.getColor(status).withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        StatusMapper.getLabel(status),
        style: TextStyle(color: StatusMapper.getColor(status), fontWeight: FontWeight.w700),
      ),
    );
  }
}
