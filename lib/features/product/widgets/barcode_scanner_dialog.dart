import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';

class BarcodeScannerDialog extends StatefulWidget {
  const BarcodeScannerDialog({super.key});

  @override
  State<BarcodeScannerDialog> createState() => _BarcodeScannerDialogState();
}

class _BarcodeScannerDialogState extends State<BarcodeScannerDialog> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
  );

  bool _isScanned = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
        child: SizedBox(
          width: Responsive.isWeb(context)
              ? 450
              : MediaQuery.of(context).size.width * 0.9,
          height: Responsive.isWeb(context)
              ? 550
              : MediaQuery.of(context).size.height * 0.6,
          child: Stack(
            children: [
              MobileScanner(
                controller: _controller,
                onDetect: (capture) {
                  if (_isScanned) return;
                  final List<Barcode> barcodes = capture.barcodes;
                  if (barcodes.isNotEmpty) {
                    final String? code = barcodes.first.rawValue;
                    if (code != null) {
                      _isScanned = true;
                      AppNavigation.goBackWithResult(context, code);
                    }
                  }
                },
              ),
              Positioned(
                top: AppSizes.size10,
                right: AppSizes.size10,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: AppColors.white,
                    size: AppSizes.size40,
                  ),
                  onPressed: () => AppNavigation.goBack(context),
                ),
              ),
              Positioned(
                bottom: AppSizes.size20,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "Align barcode within frame",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: AppSizes.font16,
                      fontWeight: FontWeight.w600,
                      backgroundColor: AppColors.black,
                    ),
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
