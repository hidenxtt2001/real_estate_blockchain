import 'dart:io';

import 'package:flutter/material.dart';
import 'package:real_estate_blockchain/config/app_color.dart';

class ImageCustom extends Image {
  const ImageCustom({
    super.key,
    required super.image,
    super.frameBuilder,
    super.loadingBuilder,
    super.errorBuilder,
    super.semanticLabel,
    super.excludeFromSemantics,
    super.width,
    super.height,
    super.color,
    super.opacity,
    super.colorBlendMode,
    super.fit,
    super.alignment,
    super.repeat,
    super.centerSlice,
    super.matchTextDirection,
    super.gaplessPlayback,
    super.isAntiAlias,
    super.filterQuality,
  }) : super();

  ImageCustom.network(
    super.src, {
    super.key,
    super.scale,
    super.frameBuilder,
    super.loadingBuilder,
    super.errorBuilder,
    super.semanticLabel,
    super.excludeFromSemantics,
    super.width,
    super.height,
    super.color,
    super.opacity,
    super.colorBlendMode,
    super.fit,
    super.alignment,
    super.repeat,
    super.centerSlice,
    super.matchTextDirection,
    super.gaplessPlayback,
    super.filterQuality,
    super.isAntiAlias,
    super.headers,
    super.cacheWidth,
    super.cacheHeight,
  }) : super.network();

  ImageCustom.file(
    File file, {
    super.key,
    super.scale,
    super.frameBuilder,
    super.errorBuilder,
    super.semanticLabel,
    super.excludeFromSemantics = false,
    super.width,
    super.height,
    super.color,
    super.opacity,
    super.colorBlendMode,
    super.fit,
    super.alignment = Alignment.center,
    super.repeat = ImageRepeat.noRepeat,
    super.centerSlice,
    super.matchTextDirection = false,
    super.gaplessPlayback = false,
    super.isAntiAlias = false,
    super.filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) : super.file(file);

  @override
  ImageErrorWidgetBuilder? get errorBuilder => (context, error, stackTrace) {
        return const _ErrorWidgget();
      };

  @override
  ImageLoadingBuilder? get loadingBuilder => (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const _LoadingWidget();
      };

  @override
  ImageFrameBuilder? get frameBuilder =>
      (context, child, frame, wasSynchronouslyLoaded) {
        if (frame != null) return child;
        return Container(
          color: AppColor.kNeutrals_.shade500,
        );
      };
}

class _ErrorWidgget extends StatelessWidget {
  const _ErrorWidgget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.kNeutrals_.shade500,
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.kNeutrals_.shade500,
    );
  }
}
