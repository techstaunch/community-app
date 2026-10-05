import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../theme/app_theme.dart';

class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? gender;
  final Uint8List? memoryBytes;
  final File? localFile;
  final double size;
  final bool isUploading;
  final VoidCallback? onEdit;
  final Widget? fallbackWidget;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.gender,
    this.memoryBytes,
    this.localFile,
    this.size = 60,
    this.isUploading = false,
    this.onEdit,
    this.fallbackWidget,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFemale = gender?.toLowerCase() == 'female';
    final String placeholderAsset = isFemale ? 'assets/images/placeholder_female.jpg' : 'assets/images/placeholder_male.jpg';

    final Widget defaultFallback = fallbackWidget ?? 
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(placeholderAsset),
            fit: BoxFit.cover,
          ),
        ),
      );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: localFile != null
              ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: FileImage(localFile!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : memoryBytes != null
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: MemoryImage(memoryBytes!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : (imageUrl != null && imageUrl!.isNotEmpty)
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      width: size,
                      height: size,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => SizedBox(
                        width: size,
                        height: size,
                        child: CircularProgressIndicator(
                          strokeWidth: size > 40 ? 3.0 : 2.0,
                          color: AppColors.orange,
                        ),
                      ),
                      errorWidget: (context, url, error) => defaultFallback,
                    )
                  : defaultFallback,
        ),
        if (isUploading)
          Positioned.fill(
            child: CircularProgressIndicator(
              strokeWidth: size > 40 ? 3.0 : 2.0,
              color: AppColors.orange,
            ),
          ),
        if (onEdit != null)
          Positioned(
            bottom: -size * 0.06,
            right: -size * 0.06,
            child: GestureDetector(
              onTap: onEdit,
              child: Container(
                padding: EdgeInsets.all(size * 0.08),
                decoration: const BoxDecoration(
                  color: AppColors.orange,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.edit,
                  size: size * 0.25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
