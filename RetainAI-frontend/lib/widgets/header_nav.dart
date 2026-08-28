import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';

class HeaderNav extends StatelessWidget {
  final VoidCallback onPredictTap;
  final VoidCallback onHomeTap;
  final VoidCallback onHelpTap;

  const HeaderNav({
    super.key,
    required this.onPredictTap,
    required this.onHomeTap,
    required this.onHelpTap,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateStr = DateFormat('yyyy/MM/dd').format(now);

    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: AppTheme.brandDark.withValues(alpha: 0.92),
        border: const Border(
          bottom: BorderSide(color: Color(0x1AFFFFFF), width: 1),
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1280),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final showLinks = constraints.maxWidth >= 880;
              final showDate = constraints.maxWidth >= 600;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo
                  InkWell(
                    onTap: onHomeTap,
                    borderRadius: BorderRadius.circular(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [AppTheme.brandOrange, Color(0xFFF59E0B)],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x33E65124),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.manage_accounts_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'RETAIN',
                                  style: AppTheme.displayFont.copyWith(
                                    fontSize: 17,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                Text(
                                  '.AI',
                                  style: AppTheme.displayFont.copyWith(
                                    fontSize: 17,
                                    color: AppTheme.brandOrange,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'EMPLOYEE CHURN INTELLIGENCE',
                              style: AppTheme.sansFont.copyWith(
                                fontSize: 8.5,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.1,
                                color: AppTheme.slate400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Nav Links (Desktop only)
                  if (showLinks)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _NavButton(
                          title: 'Home',
                          isActive: true,
                          onTap: onHomeTap,
                        ),
                        const SizedBox(width: 28),
                        _NavButton(
                          title: 'Predictor',
                          isActive: false,
                          onTap: onPredictTap,
                        ),
                        const SizedBox(width: 28),
                        _NavButton(
                          title: 'Help',
                          isActive: false,
                          onTap: onHelpTap,
                        ),
                      ],
                    ),

                  // Date Display & Action Button
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (showDate) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0x0DFFFFFF),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0x1AFFFFFF)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                color: AppTheme.brandOrange,
                                size: 13,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                dateStr,
                                style: const TextStyle(
                                  color: AppTheme.slate400,
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      ElevatedButton(
                        onPressed: onPredictTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.brandOrange,
                          foregroundColor: Colors.white,
                          elevation: 4,
                          shadowColor:
                              AppTheme.brandOrange.withValues(alpha: 0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                        child: Text(
                          'Predict',
                          style: AppTheme.sansFont.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _NavButton({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: AppTheme.sansFont.copyWith(
                fontSize: 13.5,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? Colors.white : AppTheme.slate400,
              ),
            ),
            if (isActive) ...[
              const SizedBox(height: 4),
              Container(
                width: 24,
                height: 2,
                color: AppTheme.brandOrange,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
