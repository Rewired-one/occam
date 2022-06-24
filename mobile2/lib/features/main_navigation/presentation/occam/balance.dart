import 'package:flutter/material.dart';
import 'package:mobile2/features/main_navigation/presentation/occam/balance_header.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({Key? key}) : super(key: key);

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Column(
            children: [
              const SafeArea(child: SizedBox.shrink()),
              Container(
                height: constraints.maxHeight * .35,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: const Color(0xFF4D4D4D).withOpacity(.5),
                    ),
                  ),
                ),
                child: BalanceHeader(),
              ),
              const Expanded(
                child: Center(child: Text('List Here')),
              )
            ],
          ),
        );
      },
    );
  }
}
