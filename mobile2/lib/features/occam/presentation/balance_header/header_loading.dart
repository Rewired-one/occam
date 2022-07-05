import 'package:flutter/material.dart';
import 'package:mobile2/widgets/loading_skeleton.dart';

class BalanceHeaderLoading extends StatelessWidget {
  const BalanceHeaderLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            const Spacer(),
            const LoadingSkeleton(size: Size(80, 20)),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 40),
                width: 20,
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: LoadingSkeleton(
                    size: Size(20, 20),
                  ),
                ),
              ),
            ),
          ],
        ),
        const LoadingSkeleton(size: Size(166, 65)),
        const LoadingSkeleton(size: Size(140, 30)),
      ],
    );
  }
}
