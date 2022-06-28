import 'package:flutter/material.dart';
import 'package:mobile2/widgets/text_widget.dart';

class BalanceHeaderLoading extends StatelessWidget {
  const BalanceHeaderLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            const Spacer(),
            Container(color: const Color.fromRGBO(77, 77, 77, .5), width: 80, height: 20),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                width: double.infinity,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.qr_code),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(color: const Color.fromRGBO(77, 77, 77, .5), width: 166, height: 65),
        const SizedBox(height: 30),
        Container(color: const Color.fromRGBO(77, 77, 77, .5), width: 140, height: 30),
      ],
    );
  }
}
