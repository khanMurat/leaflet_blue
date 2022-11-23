import 'package:flutter/material.dart';
import 'package:leaflet_task/core/constants/size_constant.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;

  const CustomButton({super.key, this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p20),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text.toString()),
      ),
    );
  }
}
