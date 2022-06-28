import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile2/constants/colors.dart';
import 'package:mobile2/features/occam/presentation/sheet_loading.dart';
import 'package:mobile2/widgets/text_widget.dart';
import 'package:mobile2/features/occam/application/balance/balance_cubit.dart';

// Display Assets in List
// Retrieve current USD amount of each Asset
// Return list of USD amount of each

final assets = [
  {'name': 'Solana', 'prefix': 'SOL', 'image': '', 'currentValue': '\$10'},
  {'name': 'Tether', 'prefix': 'USDT', 'image': '', 'currentValue': '\$10'},
  {'name': 'Chainlink', 'prefix': 'LINK', 'image': '', 'currentValue': '\$10'},
  {'name': 'Terra', 'prefix': 'LUNA', 'image': '', 'currentValue': '\$10'},
  {'name': 'USD Coin', 'prefix': 'USDC', 'image': '', 'currentValue': '\$10'},
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
                itemCount: assets.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        const Icon(Icons.circle, size: 50),
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    TextWidget(
                                      'Solana',
                                      fontSize: 16,
                                      color: AppTheme.primary,
                                    ),
                                    TextWidget(
                                      '\$1,000',
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
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    TextWidget(
                                      'SOL',
                                      fontSize: 16,
                                      color: AppTheme.inactive,
                                    ),
                                    TextWidget(
                                      '10',
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
