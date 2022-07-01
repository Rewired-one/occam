import 'package:flutter/material.dart';
import 'package:mobile2/constants/colors.dart';

/// Loading Overlay Widget
class LoadingOverlayWidget extends StatelessWidget {
  const LoadingOverlayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
      child: const Center(
        child: CircularProgressIndicator(
          color: AppTheme.purple,
        ),
      ),
    );
  }
}
