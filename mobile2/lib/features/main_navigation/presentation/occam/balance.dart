import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:mobile2/constants/colors.dart';
import 'package:mobile2/widgets/text_widget.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';

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
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Spacer(),
                          DropdownButton<String>(
                            value: 'Testnet',
                            underline: const SizedBox.shrink(),
                            onChanged: (value) {},
                            items: const [
                              DropdownMenuItem(
                                value: 'Testnet',
                                child: TextWidget('Testnet'),
                              )
                            ],
                          ),
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
                          )
                        ],
                      ),
                      const TextWidget(
                        '\$0.00',
                        fontSize: 58,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Iconify(
                            Fa6Solid.wallet,
                            color: AppTheme.purple,
                            size: 15,
                          ),
                          const SizedBox(width: 4),
                          DropdownButton<String>(
                            value: 'Test Wallet',
                            underline: const SizedBox.shrink(),
                            icon: const Icon(
                              Icons.expand_more,
                              color: AppTheme.purple,
                            ),
                            onChanged: (String? value) {},
                            items: [
                              DropdownMenuItem(
                                value: 'Test Wallet',
                                child: TextWidget(
                                  'Test Wallet',
                                  color: AppTheme.purple,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const Expanded(
                  child: Center(child: Text('List Here')),
                )
              ],
            ));
      },
    );
  }
}
