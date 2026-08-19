import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({super.key});

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  bool _isAgreed = false;

  final List<Map<String, dynamic>> _terms = [
    {
      "title": "Acceptance of Terms",
      "description":
          "By accessing and using SmartStock, you accept and agree to be bound by these Terms & Conditions.",
      "icon": Icons.person_outline,
    },
    {
      "title": "Use of the App",
      "description":
          "SmartStock is an offline inventory management app designed to help you manage your products and stock.",
      "icon": Icons.widgets_outlined,
    },
    {
      "title": "User Responsibilities",
      "description":
          "You are responsible for the accuracy of the data you enter into the app and for maintaining the security of your device.",
      "icon": Icons.verified_user_outlined,
    },
    {
      "title": "Data Storage",
      "description":
          "All your data is stored locally on your device. You are responsible for creating backups to prevent data loss.",
      "icon": Icons.storage_outlined,
    },
    {
      "title": "Limitation of Liability",
      "description":
          "SmartStock is provided \"as is\" without any warranties. We are not liable for any data loss or damages resulting from the use of this app.",
      "icon": Icons.warning_amber_rounded,
    },
    {
      "title": "Changes to Terms",
      "description":
          "We may update these terms from time to time. Any changes will be reflected in this page.",
      "icon": Icons.edit_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Terms & Conditions",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Please read these terms carefully",
              style: TextStyle(color: AppColors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.size20),
        child: Column(
          children: [
            // Welcome Card
            Container(
              padding: const EdgeInsets.all(AppSizes.size20),
              decoration: BoxDecoration(
                color: AppColors.blue.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.blue.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Icon(
                          Icons.description_outlined,
                          color: AppColors.blue,
                          size: 28,
                        ),
                      ),
                      Positioned(
                        right: -4,
                        bottom: -4,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.blue,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(2),
                          child: Icon(
                            Icons.check,
                            color: AppColors.white,
                            size: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: AppSizes.size15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Welcome to SmartStock",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "By using SmartStock, you agree to the following terms and conditions. Please read them carefully before using our app.",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.grey,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.size20),

            // Terms List Card
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blackShadow,
                    blurRadius: AppSizes.blurRadius,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _terms.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFF1F5F9),
                ),
                itemBuilder: (context, index) {
                  final term = _terms[index];
                  return Padding(
                    padding: const EdgeInsets.all(AppSizes.size15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.blue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(
                              color: AppColors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSizes.size15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                term["title"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                term["description"],
                                style: const TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          term["icon"],
                          color: AppColors.blue.withValues(alpha: 0.5),
                          size: 20,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: AppSizes.size20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppSizes.size20),
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
          border: Border(
            top: BorderSide(color: AppColors.blue.withValues(alpha: 0.1)),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.blue.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
          ),
          child: Row(
            children: [
              Checkbox(
                value: _isAgreed,
                onChanged: (value) {
                  setState(() {
                    _isAgreed = value ?? false;
                  });
                },
                activeColor: AppColors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const Expanded(
                child: Text(
                  "I have read and agree to the Terms & Conditions",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
