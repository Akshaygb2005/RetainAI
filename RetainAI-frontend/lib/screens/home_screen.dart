import 'package:flutter/material.dart';
import '../models/prediction_model.dart';
import '../services/prediction_service.dart';
import '../theme/app_theme.dart';
import '../widgets/footer_section.dart';
import '../widgets/header_nav.dart';
import '../widgets/hero_section.dart';
import '../widgets/predictor_form.dart';
import '../widgets/result_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final PredictionService _predictionService = PredictionService();

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _predictorKey = GlobalKey();
  final GlobalKey _footerKey = GlobalKey();

  EmployeePredictionResponse? _currentPrediction;
  bool _isLoading = false;
  String _currentEmpId = 'EMP_001';

  @override
  void initState() {
    super.initState();
    // Run initial default prediction calculation
    _runInitialPrediction();
  }

  void _runInitialPrediction() {
    final initialRequest = EmployeePredictionRequest(
      employeeId: "EMP_001",
      gender: "Male",
      age: 32,
      yearsAtCompany: 4,
      annualIncome: 75000,
      department: "HR",
      jobRole: "Executive",
      position: "Mid-Level",
      employmentType: "Full-time",
      state: "Punjab",
      educationLevel: "Graduate",
      maritalStatus: "Single",
      environmentSatisfaction: "Medium",
      employeeCostToCompany: 90000,
    );

    setState(() {
      _currentPrediction = EmployeePredictionResponse.fromSimulation(initialRequest);
    });
  }

  Future<void> _handlePredictionSubmit(EmployeePredictionRequest request) async {
    setState(() {
      _isLoading = true;
      _currentEmpId = request.employeeId;
    });

    try {
      final result = await _predictionService.predict(request);
      if (mounted) {
        setState(() {
          _currentPrediction = result;
          _isLoading = false;
        });

        // If on small screen, scroll to result card so user sees output
        if (MediaQuery.of(context).size.width < 1000) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppTheme.brandDarkCard,
              content: Text(
                'Prediction generated for ${request.employeeId}: ${_currentPrediction?.attritionStatus == "Yes" ? "YES (Will Churn)" : "NO (Will Stay)"}',
                style: const TextStyle(color: Colors.white),
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1000;

    return Scaffold(
      backgroundColor: AppTheme.brandDark,
      body: Stack(
        children: [
          // Main Scrollable Body
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 80), // Offset for fixed top navbar

                // Hero Section
                Container(
                  key: _heroKey,
                  child: HeroSection(
                    onPredictClick: () => _scrollToKey(_predictorKey),
                  ),
                ),

                // Predictor Section
                Container(
                  key: _predictorKey,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppTheme.brandDark,
                    border: Border(
                      top: BorderSide(color: Color(0x1AFFFFFF), width: 1),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 80,
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1280),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section Header
                        Row(
                          children: [
                            Text(
                              'INPUT ASSESSMENT',
                              style: AppTheme.sansFont.copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                color: AppTheme.brandOrange,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              width: 40,
                              height: 2,
                              color: AppTheme.brandOrange,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Employee Details',
                          style: AppTheme.displayFont.copyWith(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Provide the employee attributes to calculate churn outcome and model confidence.',
                          style: AppTheme.sansFont.copyWith(
                            fontSize: 14,
                            color: AppTheme.slate400,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Form & Result Grid
                        if (isDesktop)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left Form (7 cols)
                              Expanded(
                                flex: 7,
                                child: PredictorForm(
                                  onSubmit: _handlePredictionSubmit,
                                  onEmployeeIdChanged: (id) {
                                    setState(() => _currentEmpId = id);
                                  },
                                  isLoading: _isLoading,
                                ),
                              ),
                              const SizedBox(width: 32),
                              // Right Sticky Result Card (5 cols)
                              Expanded(
                                flex: 5,
                                child: ResultCard(
                                  prediction: _currentPrediction,
                                  isLoading: _isLoading,
                                  currentEmployeeId: _currentEmpId,
                                ),
                              ),
                            ],
                          )
                        else
                          Column(
                            children: [
                              PredictorForm(
                                onSubmit: _handlePredictionSubmit,
                                onEmployeeIdChanged: (id) {
                                  setState(() => _currentEmpId = id);
                                },
                                isLoading: _isLoading,
                              ),
                              const SizedBox(height: 32),
                              ResultCard(
                                prediction: _currentPrediction,
                                isLoading: _isLoading,
                                currentEmployeeId: _currentEmpId,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),

                // Footer Section
                Container(
                  key: _footerKey,
                  child: FooterSection(
                    onHomeTap: () => _scrollToKey(_heroKey),
                    onPredictTap: () => _scrollToKey(_predictorKey),
                    onHelpTap: () => _scrollToKey(_footerKey),
                  ),
                ),
              ],
            ),
          ),

          // Fixed Top Header Nav
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: HeaderNav(
              onHomeTap: () => _scrollToKey(_heroKey),
              onPredictTap: () => _scrollToKey(_predictorKey),
              onHelpTap: () => _scrollToKey(_footerKey),
            ),
          ),
        ],
      ),
    );
  }
}
