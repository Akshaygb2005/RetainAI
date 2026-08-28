import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onPredictClick;

  const HeroSection({super.key, required this.onPredictClick});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1000;

    return Stack(
      children: [
        // Subtle Background Glows
        Positioned(
          top: 80,
          left: 100,
          child: Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.brandOrange.withValues(alpha: 0.08),
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          right: 80,
          child: Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF2563EB).withValues(alpha: 0.07),
            ),
          ),
        ),

        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 650),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1280),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 7,
                        child: _buildLeftHeroContent(context),
                      ),
                      const SizedBox(width: 48),
                      Expanded(
                        flex: 5,
                        child: _buildRightContextCard(context),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLeftHeroContent(context),
                      const SizedBox(height: 48),
                      _buildRightContextCard(context),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeftHeroContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Eyebrow
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "LET'S SEE",
              style: AppTheme.sansFont.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
                color: AppTheme.slate400,
              ),
            ),
            const SizedBox(width: 14),
            Container(
              width: 50,
              height: 2,
              color: AppTheme.brandOrange,
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Main Title
        RichText(
          text: TextSpan(
            style: AppTheme.displayFont.copyWith(
              fontSize: 54,
              fontWeight: FontWeight.w900,
              height: 1.05,
              letterSpacing: -1,
            ),
            children: const [
              TextSpan(
                text: 'WHO ',
                style: TextStyle(color: Colors.white),
              ),
              TextSpan(
                text: 'STAYS ?',
                style: TextStyle(
                  color: Color(0xFFCBD5E1),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Description Paragraph
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: RichText(
            text: TextSpan(
              style: AppTheme.sansFont.copyWith(
                fontSize: 15,
                height: 1.6,
                color: AppTheme.slate300,
              ),
              children: const [
                TextSpan(
                  text: 'RETAIN.AI ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text:
                      'is an intelligent employee churn prediction platform designed to evaluate workforce retention probability. Enter employee demographic, organizational, and financial parameters below to get instant churn predictions.',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),

        // CTA Button
        ElevatedButton(
          onPressed: onPredictClick,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.brandOrange,
            foregroundColor: Colors.white,
            elevation: 8,
            shadowColor: AppTheme.brandOrange.withValues(alpha: 0.35),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Predict',
                style: AppTheme.sansFont.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.arrow_forward_rounded, size: 16),
            ],
          ),
        ),
        const SizedBox(height: 36),

        // Slider Index Indicator (01 - 04)
        Row(
          children: [
            Text(
              '01',
              style: AppTheme.displayFont.copyWith(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 90,
              height: 2,
              color: const Color(0x33FFFFFF),
              alignment: Alignment.centerLeft,
              child: Container(
                width: 32,
                height: 2,
                color: AppTheme.brandOrange,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              '04',
              style: AppTheme.displayFont.copyWith(
                fontSize: 14,
                color: AppTheme.slate500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRightContextCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.brandDarkCard.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x1AFFFFFF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 30,
            offset: Offset(0, 15),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WORKFORCE ANALYSIS',
                    style: AppTheme.sansFont.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      color: AppTheme.slate400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Attrition Assessment',
                    style: AppTheme.displayFont.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppTheme.brandOrange.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.brandOrange.withValues(alpha: 0.25),
                  ),
                ),
                child: const Icon(
                  Icons.groups_outlined,
                  color: AppTheme.brandOrange,
                  size: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Color(0x1AFFFFFF), height: 1),
          const SizedBox(height: 20),

          // Context Body
          Text(
            'Fill in all 14 employee attributes including tenure, role, compensation, and satisfaction to compute the binary churn decision and model confidence score.',
            style: AppTheme.sansFont.copyWith(
              fontSize: 13,
              height: 1.55,
              color: AppTheme.slate300,
            ),
          ),
          const SizedBox(height: 20),

          // Metrics Preview Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0x66000000),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0x0DFFFFFF)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Prediction Output:',
                      style: AppTheme.sansFont.copyWith(
                        fontSize: 13,
                        color: AppTheme.slate400,
                      ),
                    ),
                    Text(
                      'Yes / No',
                      style: AppTheme.sansFont.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Certainty Level:',
                      style: AppTheme.sansFont.copyWith(
                        fontSize: 13,
                        color: AppTheme.slate400,
                      ),
                    ),
                    Text(
                      'Confidence %',
                      style: AppTheme.sansFont.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Info Banner
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.brandOrange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.brandOrange.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  color: AppTheme.brandOrange,
                  size: 18,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Use the form below to assess employee records one by one.',
                    style: AppTheme.sansFont.copyWith(
                      fontSize: 12,
                      color: AppTheme.slate300,
                      height: 1.4,
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
