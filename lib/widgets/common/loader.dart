import 'package:cma_mobile/constants.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: loginBlue,
      child: const Center(
        child: CircularProgressIndicator(color: primaryOrange),
      ),
    );
  }
}
