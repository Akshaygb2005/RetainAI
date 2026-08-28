import 'package:flutter/material.dart';
import '../models/prediction_model.dart';
import '../theme/app_theme.dart';

class ResultCard extends StatelessWidget {
  final EmployeePredictionResponse? prediction;
  final bool isLoading;
  final String currentEmployeeId;

  const ResultCard({
    super.key,
    required this.prediction,
    required this.isLoading,
    required this.currentEmployeeId,
  });

  @override
  Widget build(BuildContext context) {
    final willChurn = prediction?.willChurn ?? false;
    final empId = prediction?.employeeId.isNotEmpty == true
        ? prediction!.employeeId
        : (currentEmployeeId.isNotEmpty ? currentEmployeeId : 'EMP_001');

    final confidence = prediction != null
        ? prediction!.confidencePercentage.toStringAsFixed(1)
        : '84.5';

    final badgeColor = willChurn ? AppTheme.statusRed : AppTheme.statusGreen;
    final badgeBg = willChurn ? AppTheme.statusRedBg : AppTheme.statusGreenBg;
    final badgeBorder = willChurn ? AppTheme.statusRedBorder : AppTheme.statusGreenBorder;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.brandDarkCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x1AFFFFFF)),
        boxShadow: [
          BoxShadow(
            color: willChurn
                ? AppTheme.statusRed.withValues(alpha: 0.08)
                : AppTheme.brandOrange.withValues(alpha: 0.06),
            blurRadius: 35,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isLoading ? Colors.amber : AppTheme.brandOrange,
                      boxShadow: [
                        BoxShadow(
                          color: (isLoading ? Colors.amber : AppTheme.brandOrange)
                              .withValues(alpha: 0.6),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'PREDICTION OUTPUT',
                    style: AppTheme.sansFont.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: AppTheme.slate300,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0x0DFFFFFF),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0x1AFFFFFF)),
                ),
                child: Text(
                  empId,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: AppTheme.slate400,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(color: Color(0x1AFFFFFF), height: 1),
          const SizedBox(height: 28),

          if (isLoading)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Column(
                children: [
                  const SizedBox(
                    width: 44,
                    height: 44,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppTheme.brandOrange),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Computing Attrition Probability...',
                    style: AppTheme.sansFont.copyWith(
                      fontSize: 14,
                      color: AppTheme.slate400,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          else ...[
            // Outcome Label
            Center(
              child: Text(
                'CHURN PREDICTION',
                style: AppTheme.sansFont.copyWith(
                  fontSize: 11,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.slate400,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Big YES / NO Outcome Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              decoration: BoxDecoration(
                color: badgeBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: badgeBorder, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: badgeColor.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    willChurn
                        ? Icons.warning_amber_rounded
                        : Icons.check_circle_outline_rounded,
                    color: badgeColor,
                    size: 32,
                  ),
                  const SizedBox(width: 14),
                  Text(
                    willChurn ? 'YES' : 'NO',
                    style: AppTheme.displayFont.copyWith(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                      color: badgeColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Subtext
            Center(
              child: Text(
                willChurn
                    ? 'Employee is predicted to churn (leave the company).'
                    : 'Employee is predicted to remain with the company.',
                textAlign: TextAlign.center,
                style: AppTheme.sansFont.copyWith(
                  fontSize: 12,
                  color: AppTheme.slate400,
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Confidence Box
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: AppTheme.brandDark,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0x0DFFFFFF)),
              ),
              child: Column(
                children: [
                  Text(
                    'CONFIDENCE',
                    style: AppTheme.sansFont.copyWith(
                      fontSize: 11,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.slate400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        confidence,
                        style: AppTheme.displayFont.copyWith(
                          fontSize: 42,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.brandOrange.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppTheme.brandOrange.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          '%',
                          style: AppTheme.displayFont.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.brandOrange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            if (prediction?.databaseRecordId != null ||
                prediction?.actionTaken != null) ...[
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0x0DFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (prediction?.databaseRecordId != null)
                      Text(
                        'Record ID: #${prediction!.databaseRecordId}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.slate400,
                          fontFamily: 'monospace',
                        ),
                      ),
                    if (prediction?.actionTaken != null)
                      Text(
                        'Action: ${prediction!.actionTaken}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.slate400,
                          fontFamily: 'monospace',
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
