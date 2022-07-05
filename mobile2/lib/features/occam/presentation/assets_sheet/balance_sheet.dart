import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile2/constants/colors.dart';
import 'package:mobile2/features/occam/presentation/assets_sheet/manage_assets.dart';

import 'package:mobile2/widgets/round_button.dart';
import 'package:mobile2/widgets/text_widget.dart';
import 'package:mobile2/features/occam/application/balance/balance_cubit.dart';
import 'package:mobile2/features/occam/presentation/assets_sheet/sheet_loading.dart';

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
                itemCount: state.selectedTokens.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.selectedTokens.length) {
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

                  final tokenAsset = state.selectedTokens[index];

                  final solanaTokensOwned = tokenAsset.id == 'solana' ? state.solanaTokensOwned : 0;

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/crypto_assets/${tokenAsset.image}',
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
                                      tokenAsset.name,
                                      fontSize: 16,
                                      color: AppTheme.primary,
                                    ),
                                    TextWidget(
                                      '\$${tokenAsset.currentValue}',
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
                                      tokenAsset.prefix,
                                      fontSize: 16,
                                      color: AppTheme.inactive,
                                    ),
                                    TextWidget(
                                      '$solanaTokensOwned',
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
