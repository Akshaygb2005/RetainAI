import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FooterSection extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onPredictTap;
  final VoidCallback onHelpTap;

  const FooterSection({
    super.key,
    required this.onHomeTap,
    required this.onPredictTap,
    required this.onHelpTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF08090D),
        border: Border(
          top: BorderSide(color: Color(0x1AFFFFFF), width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1280),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            if (isWide) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBrand(),
                  _buildLinks(),
                  _buildCopyright(),
                ],
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildBrand(),
                  const SizedBox(height: 20),
                  _buildLinks(),
                  const SizedBox(height: 20),
                  _buildCopyright(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildBrand() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.brandOrange,
          ),
          child: const Icon(
            Icons.manage_accounts_rounded,
            color: Colors.white,
            size: 16,
          ),
        ),
        const SizedBox(width: 10),
        RichText(
          text: TextSpan(
            style: AppTheme.displayFont.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            children: const [
              TextSpan(text: 'RETAIN'),
              TextSpan(
                text: '.AI',
                style: TextStyle(color: AppTheme.brandOrange),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        const Text('|', style: TextStyle(color: AppTheme.slate600)),
        const SizedBox(width: 8),
        Text(
          'Employee Churn Intelligence',
          style: AppTheme.sansFont.copyWith(
            fontSize: 11.5,
            color: AppTheme.slate500,
          ),
        ),
      ],
    );
  }

  Widget _buildLinks() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onHomeTap,
          child: Text(
            'Home',
            style: AppTheme.sansFont.copyWith(
              fontSize: 12,
              color: AppTheme.slate400,
            ),
          ),
        ),
        const SizedBox(width: 24),
        InkWell(
          onTap: onPredictTap,
          child: Text(
            'Predictor',
            style: AppTheme.sansFont.copyWith(
              fontSize: 12,
              color: AppTheme.slate400,
            ),
          ),
        ),
        const SizedBox(width: 24),
        InkWell(
          onTap: onHelpTap,
          child: Text(
            'Help',
            style: AppTheme.sansFont.copyWith(
              fontSize: 12,
              color: AppTheme.slate400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCopyright() {
    return Text(
      '© 2026 RETAIN.AI. All rights reserved.',
      style: AppTheme.sansFont.copyWith(
        fontSize: 11.5,
        color: AppTheme.slate500,
      ),
    );
  }
}
