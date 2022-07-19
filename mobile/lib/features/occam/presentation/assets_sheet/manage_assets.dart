import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile2/constants/colors.dart';
import 'package:mobile2/constants/token_assets.dart';
import 'package:mobile2/features/occam/application/balance/balance_cubit.dart';
import 'package:mobile2/widgets/text_widget.dart';

class ManageAssetsScreen extends StatelessWidget {
  const ManageAssetsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BalanceCubit, BalanceState>(
      listener: (context, state) {
        // TODO:
        // [ ] Implement API Error Messages
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF242024),
          appBar: AppBar(
            backgroundColor: const Color(0xFF242024),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.clear,
                color: Color(0xFFBEBEBE),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: tokenAssets.length,
                  itemBuilder: (context, index) {
                    final asset = tokenAssets[index];
                    final bool selected = state.selectedTokens.any((e) => e.id == asset['id']);

                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/crypto_assets/${asset['image']}',
                                    width: 45,
                                    fit: BoxFit.fill,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        asset['name'].toString(),
                                      ),
                                      TextWidget(
                                        asset['prefix'].toString(),
                                        color: AppTheme.inactive,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    icon: Transform.rotate(
                                      angle: .75,
                                      child: Icon(
                                        selected ? Icons.push_pin : Icons.push_pin_outlined,
                                        color: selected ? AppTheme.green : const Color(0xFFC7C7C7),
                                        size: 20,
                                      ),
                                    ),
                                    onPressed: () =>
                                        context.read<BalanceCubit>().selectToken(asset['id'], selected ? false : true),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Icon(
                                    selected ? Icons.visibility : Icons.visibility_off,
                                    color: const Color(0xFFC7C7C7),
                                    size: 20,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          color: Color(0xFF646464),
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
