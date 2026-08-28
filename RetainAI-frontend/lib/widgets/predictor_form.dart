import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/prediction_model.dart';
import '../theme/app_theme.dart';

class PredictorForm extends StatefulWidget {
  final Function(EmployeePredictionRequest) onSubmit;
  final Function(String) onEmployeeIdChanged;
  final bool isLoading;

  const PredictorForm({
    super.key,
    required this.onSubmit,
    required this.onEmployeeIdChanged,
    required this.isLoading,
  });

  @override
  State<PredictorForm> createState() => _PredictorFormState();
}

class _PredictorFormState extends State<PredictorForm> {
  final _formKey = GlobalKey<FormState>();

  // Form Controllers & State
  final _empIdController = TextEditingController(text: 'EMP_001');
  String _gender = 'Male';
  String _maritalStatus = 'Single';
  String _educationLevel = 'Graduate';
  double _age = 32;

  String _department = 'HR';
  String _jobRole = 'Executive';
  String _position = 'Mid-Level';
  String _employmentType = 'Full-time';
  String _state = 'Punjab';
  final _tenureController = TextEditingController(text: '4');

  String _satisfaction = 'Medium';
  final _incomeController = TextEditingController(text: '75000');
  final _ctcController = TextEditingController(text: '90000');

  static const List<String> _genderOptions = [
    'Male',
    'Female',
    'Non-Binary',
    'Other',
  ];

  static const List<String> _maritalStatusOptions = [
    'Single',
    'Divorced',
    'Married',
  ];

  static const List<String> _educationLevelOptions = [
    'Diploma',
    'High School',
    'Graduate',
    'PhD',
    'Postgraduate',
  ];

  static const List<String> _departmentOptions = [
    'HR',
    'Finance',
    'Operations',
    'Customer Support',
    'Sales',
    'Supply Chain',
    'IT',
    'Marketing',
  ];

  static const List<String> _jobRoleOptions = [
    'Executive',
    'Assistant',
    'Supervisor',
    'Technician',
    'Specialist',
    'Analyst',
    'Coordinator',
    'Manager',
  ];

  static const List<String> _positionOptions = [
    'Junior',
    'Senior',
    'Mid-Level',
    'Lead',
  ];

  static const List<String> _employmentTypeOptions = [
    'Full-time',
    'Contract',
    'Part-time',
  ];

  static const List<String> _stateOptions = [
    'Punjab',
    'West Bengal',
    'Tamil Nadu',
    'Karnataka',
    'Maharashtra',
    'Uttar Pradesh',
    'Rajasthan',
    'Delhi',
    'Madhya Pradesh',
    'Gujarat',
  ];

  @override
  void initState() {
    super.initState();
    _empIdController.addListener(() {
      widget.onEmployeeIdChanged(_empIdController.text);
    });
  }

  @override
  void dispose() {
    _empIdController.dispose();
    _tenureController.dispose();
    _incomeController.dispose();
    _ctcController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final request = EmployeePredictionRequest(
      employeeId: _empIdController.text.trim(),
      gender: _gender,
      age: _age.toInt(),
      yearsAtCompany: int.tryParse(_tenureController.text) ?? 4,
      annualIncome: int.tryParse(_incomeController.text) ?? 75000,
      department: _department,
      jobRole: _jobRole,
      position: _position,
      employmentType: _employmentType,
      state: _state,
      educationLevel: _educationLevel,
      maritalStatus: _maritalStatus,
      environmentSatisfaction: _satisfaction,
      employeeCostToCompany: int.tryParse(_ctcController.text) ?? 90000,
    );

    widget.onSubmit(request);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.brandDarkCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x1AFFFFFF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Demographics & Identity
            _buildSectionHeader(
              icon: Icons.badge_outlined,
              title: 'Demographics & Identity',
            ),
            const SizedBox(height: 16),
            _buildGridRow(
              context,
              children: [
                _buildTextField(
                  controller: _empIdController,
                  label: 'Employee ID *',
                  hint: 'e.g. EMP_001',
                  prefixIcon: Icons.tag,
                ),
                _buildDropdown(
                  label: 'Gender *',
                  value: _gender,
                  items: _genderOptions,
                  onChanged: (val) => setState(() => _gender = val!),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildGridRow(
              context,
              children: [
                _buildDropdown(
                  label: 'Marital Status',
                  value: _maritalStatus,
                  items: _maritalStatusOptions,
                  onChanged: (val) => setState(() => _maritalStatus = val!),
                ),
                _buildDropdown(
                  label: 'Education Level',
                  value: _educationLevel,
                  items: _educationLevelOptions,
                  onChanged: (val) => setState(() => _educationLevel = val!),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Age Slider
            _buildAgeSlider(),
            const SizedBox(height: 32),

            // 2. Role & Work Environment
            _buildSectionHeader(
              icon: Icons.business_center_outlined,
              title: 'Role & Work Environment',
            ),
            const SizedBox(height: 16),
            _buildGridRow(
              context,
              children: [
                _buildDropdown(
                  label: 'Department *',
                  value: _department,
                  items: _departmentOptions,
                  onChanged: (val) => setState(() => _department = val!),
                ),
                _buildDropdown(
                  label: 'Job Role *',
                  value: _jobRole,
                  items: _jobRoleOptions,
                  onChanged: (val) => setState(() => _jobRole = val!),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildGridRow(
              context,
              children: [
                _buildDropdown(
                  label: 'Position',
                  value: _position,
                  items: _positionOptions,
                  onChanged: (val) => setState(() => _position = val!),
                ),
                _buildDropdown(
                  label: 'Employment Type',
                  value: _employmentType,
                  items: _employmentTypeOptions,
                  onChanged: (val) => setState(() => _employmentType = val!),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildGridRow(
              context,
              children: [
                _buildDropdown(
                  label: 'State',
                  value: _state,
                  items: _stateOptions,
                  onChanged: (val) => setState(() => _state = val!),
                ),
                _buildTextField(
                  controller: _tenureController,
                  label: 'Years at Company (Tenure)',
                  hint: 'e.g. 4',
                  prefixIcon: Icons.hourglass_empty_rounded,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 3. Compensation & Satisfaction
            _buildSectionHeader(
              icon: Icons.payments_outlined,
              title: 'Compensation & Satisfaction',
            ),
            const SizedBox(height: 16),

            // Satisfaction Selector
            Text(
              'Environment Satisfaction',
              style: AppTheme.sansFont.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppTheme.slate300,
              ),
            ),
            const SizedBox(height: 10),
            _buildSatisfactionSelector(),
            const SizedBox(height: 20),

            _buildGridRow(
              context,
              children: [
                _buildTextField(
                  controller: _incomeController,
                  label: 'Annual Income (\$)',
                  hint: 'e.g. 75000',
                  prefixText: '\$ ',
                  keyboardType: TextInputType.number,
                ),
                _buildTextField(
                  controller: _ctcController,
                  label: 'Employee Cost to Company (\$)',
                  hint: 'e.g. 90000',
                  prefixText: '\$ ',
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Submit Button
            ElevatedButton(
              onPressed: widget.isLoading ? null : _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.brandOrange,
                foregroundColor: Colors.white,
                elevation: 8,
                shadowColor: AppTheme.brandOrange.withValues(alpha: 0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              child: widget.isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calculate_outlined, size: 20),
                        const SizedBox(width: 10),
                        Text(
                          'Predict Churn',
                          style: AppTheme.sansFont.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader({required IconData icon, required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppTheme.brandOrange, size: 16),
            const SizedBox(width: 8),
            Text(
              title.toUpperCase(),
              style: AppTheme.sansFont.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: AppTheme.brandOrange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(color: Color(0x1AFFFFFF), height: 1),
      ],
    );
  }

  Widget _buildGridRow(BuildContext context, {required List<Widget> children}) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    if (isMobile) {
      return Column(
        children: children
            .map((c) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: c,
                ))
            .toList(),
      );
    }
    return Row(
      children: [
        Expanded(child: children[0]),
        const SizedBox(width: 16),
        Expanded(child: children[1]),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    IconData? prefixIcon,
    String? prefixText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.sansFont.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppTheme.slate300,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: keyboardType == TextInputType.number
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          style: const TextStyle(color: Colors.white, fontSize: 13),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: AppTheme.slate500, size: 16)
                : null,
            prefixText: prefixText,
            prefixStyle: const TextStyle(
              color: AppTheme.brandOrange,
              fontWeight: FontWeight.bold,
            ),
          ),
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.sansFont.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppTheme.slate300,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.brandDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0x1AFFFFFF)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: items.contains(value) ? value : items.first,
              isExpanded: true,
              dropdownColor: AppTheme.brandDarkCard,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppTheme.slate400,
              ),
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAgeSlider() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.brandDark,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0x0DFFFFFF)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.cake_outlined,
                    color: AppTheme.brandOrange,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Age',
                    style: AppTheme.sansFont.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.slate300,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.brandOrange.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppTheme.brandOrange.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  '${_age.toInt()} yrs',
                  style: const TextStyle(
                    color: AppTheme.brandOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppTheme.brandOrange,
              inactiveTrackColor: AppTheme.brandDarkBorder,
              thumbColor: AppTheme.brandOrange,
              overlayColor: AppTheme.brandOrange.withValues(alpha: 0.2),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 9),
              trackHeight: 5,
            ),
            child: Slider(
              min: 18,
              max: 65,
              value: _age,
              onChanged: (val) => setState(() => _age = val),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('18', style: TextStyle(color: AppTheme.slate500, fontSize: 10)),
                Text('35', style: TextStyle(color: AppTheme.slate500, fontSize: 10)),
                Text('50', style: TextStyle(color: AppTheme.slate500, fontSize: 10)),
                Text('65', style: TextStyle(color: AppTheme.slate500, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSatisfactionSelector() {
    final levels = [
      {'label': 'Low', 'icon': Icons.sentiment_dissatisfied_outlined, 'color': AppTheme.statusRed},
      {'label': 'Medium', 'icon': Icons.sentiment_neutral_outlined, 'color': const Color(0xFFF59E0B)},
      {'label': 'High', 'icon': Icons.sentiment_satisfied_alt_outlined, 'color': AppTheme.statusGreen},
      {'label': 'Very High', 'icon': Icons.sentiment_very_satisfied_outlined, 'color': const Color(0xFF14B8A6)},
    ];

    return Row(
      children: levels.map((lvl) {
        final label = lvl['label'] as String;
        final icon = lvl['icon'] as IconData;
        final color = lvl['color'] as Color;
        final isSelected = _satisfaction == label;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: () => setState(() => _satisfaction = label),
              borderRadius: BorderRadius.circular(12),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.brandOrange.withValues(alpha: 0.12)
                      : AppTheme.brandDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.brandOrange
                        : const Color(0x1AFFFFFF),
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(icon, color: color, size: 22),
                    const SizedBox(height: 6),
                    Text(
                      label,
                      style: AppTheme.sansFont.copyWith(
                        fontSize: 11,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected ? Colors.white : AppTheme.slate300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
