import 'package:flutter/material.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../widgets/terms_conditions_cards.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({super.key});

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
            size: AppSizes.size30,
          ),
          onPressed: () => AppNavigation.goBack(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Terms & Conditions",
              style: TextStyle(
                color: AppColors.black,
                fontSize: AppSizes.font24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.background),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.size20),
          child: Column(
            children: [
              const TermsWelcomeCard(),
              const SizedBox(height: AppSizes.size20),
              TermsListCard(),
              const SizedBox(height: AppSizes.size20),
            ],
          ),
        ),
      ),
    );
  }
}
