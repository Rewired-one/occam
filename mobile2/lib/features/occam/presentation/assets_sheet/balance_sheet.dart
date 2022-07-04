import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile2/constants/colors.dart';
import 'package:mobile2/features/occam/presentation/assets_sheet/manage_assets.dart';

import 'package:mobile2/widgets/round_button.dart';
import 'package:mobile2/widgets/text_widget.dart';
import 'package:mobile2/features/occam/application/balance/balance_cubit.dart';
import 'package:mobile2/features/occam/presentation/assets_sheet/sheet_loading.dart';

// Display Assets in List
// Retrieve current USD amount of each Asset
// Return list of USD amount of each

final assets = [
  {'name': 'Solana', 'prefix': 'SOL', 'image': 'solana.png', 'currentValue': 35.37},
  {'name': 'Bitcoin', 'prefix': 'BTC', 'image': 'bitcoin.png', 'currentValue': 20288.03},
  {'name': 'EOS', 'prefix': 'EOS', 'image': 'eos.png', 'currentValue': 0.946094},
  {'name': 'Ethereum', 'prefix': 'ETH', 'image': 'eth.png', 'currentValue': 1144.51},
  {'name': 'Tether', 'prefix': 'USDT', 'image': 'usdt.png', 'currentValue': 0.999671},
  {'name': 'USD Coin', 'prefix': 'USDC', 'image': 'usdc.png', 'currentValue': 0.999367},
];

class BalanceSheet extends StatelessWidget {
  const BalanceSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BalanceCubit, BalanceState>(
      builder: (context, state) {
        switch (state.status) {
          case BalanceStatus.initial:
            return const SheetLoading();
          case BalanceStatus.loading:
            return const SheetLoading();
          case BalanceStatus.success:
            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                itemCount: assets.length + 1,
                itemBuilder: (context, index) {
                  if (index == assets.length) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: RoundButton(
                            text: 'Manage Tokens',
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            onPressed: () => Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) => const ManageAssetsScreen())),
                            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                          ),
                        ),
                      ],
                    );
                  }

                  final asset = assets[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/crypto_assets/${asset['image']}',
                          width: 45,
                          fit: BoxFit.fill,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 7.5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                      asset['name'].toString(),
                                      fontSize: 16,
                                      color: AppTheme.primary,
                                    ),
                                    TextWidget(
                                      asset['currentValue'].toString(),
                                      fontSize: 16,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: const Color(0xFF4D4D4D).withOpacity(.5),
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 7.5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                      asset['prefix'].toString(),
                                      fontSize: 16,
                                      color: AppTheme.inactive,
                                    ),
                                    const TextWidget(
                                      '0',
                                      fontSize: 16,
                                      color: AppTheme.inactive,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
        }
      },
    );
  }
}
