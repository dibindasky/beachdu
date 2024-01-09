import 'package:beachdu/application/presentation/utils/colors.dart';
import 'package:beachdu/application/presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class ElevatedButtonLong extends StatelessWidget {
  const ElevatedButtonLong({
    super.key,
    required this.onPressed,
    required this.text,
    this.height = 40,
    this.color = kBluePrimary,
  });
  final VoidCallback onPressed;
  final String text;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(sWidth, 40),
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: kRadius5)),
      child: Text(
        text,
        style: textHeadBold1.copyWith(color: kWhite),
      ),
    );
  }
}

