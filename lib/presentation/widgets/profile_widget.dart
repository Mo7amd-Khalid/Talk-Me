import 'dart:io';

import 'package:flutter/material.dart';
import 'package:talk_me/core/theme/app_colors.dart';

import '../../core/utils/context_func.dart';

Widget buildProfileImage({
  required String path,
  required BuildContext context,
  required double width,
  required double height,
  required Color color
}) {
  if (path.startsWith('http')) {
    return Image.network(path, height: height, width: width, fit: BoxFit.cover);
  } else if (path.startsWith('/')) {
    return Image.file(
      File(path),
      height: height,
      width: width,
      fit: BoxFit.cover,
    );
  } else {
    return Image.asset(
      path,
      height: height,
      width: width,
      fit: BoxFit.cover,
      color: color,
    );
  }
}
