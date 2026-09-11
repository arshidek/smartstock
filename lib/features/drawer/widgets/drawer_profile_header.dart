import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';

class DrawerProfileHeader extends StatelessWidget {
  final dynamic currentUser;
  final bool isCollapsed;

  const DrawerProfileHeader({
    super.key,
    required this.currentUser,
    this.isCollapsed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isCollapsed ? 0 : AppSizes.padding25,
        vertical: AppSizes.padding10,
      ),
      child: Row(
        mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Container(
            width: AppSizes.size70,
            height: AppSizes.size70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.white.withOpacity(0.3),
                  blurRadius: AppSizes.borderRadius16,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: currentUser.profileImagePath != null &&
                      currentUser.profileImagePath!.isNotEmpty
                  ? kIsWeb
                      ? Image.network(
                          currentUser.profileImagePath!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person,
                              color: AppColors.blue,
                              size: AppSizes.size40,
                            );
                          },
                        )
                      : Image.file(
                          File(currentUser.profileImagePath!),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person,
                              color: AppColors.blue,
                              size: AppSizes.size40,
                            );
                          },
                        )
                  : Icon(Icons.person, color: AppColors.blue, size: AppSizes.size40),
            ),
          ),
          if (!isCollapsed) ...[
            const SizedBox(width: AppSizes.size16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentUser.username,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize:AppSizes.font22,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
