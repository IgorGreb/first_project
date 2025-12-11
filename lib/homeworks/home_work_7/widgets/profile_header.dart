import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/dimensions.dart';
import 'package:flutter_application_grebenyuk/constants/text_styles.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.description,
    required this.isWide,
  });

  final String name;
  final String description;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final double avatarRadius = isWide
        ? AppDimensions.profileAvatarRadiusWide
        : AppDimensions.profileAvatarRadiusCompact;
    final double nameFontSize = isWide ? 26 : 22;
    final double descriptionFontSize = isWide ? 18 : 16;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: avatarRadius,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            name.isNotEmpty ? name[0] : '',
            style: AppTextStyles.profileAvatarInitial(isWide ? 32 : 28)
                .copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        const SizedBox(width: AppDimensions.profileAvatarSpacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTextStyles.profileHeaderName(nameFontSize),
              ),
              const SizedBox(height: AppDimensions.gap6),
              Text(
                description,
                style: AppTextStyles.profileHeaderDescription(
                  descriptionFontSize,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
