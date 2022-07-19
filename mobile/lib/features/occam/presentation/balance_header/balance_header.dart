import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:mobile2/constants/colors.dart';
import 'package:mobile2/widgets/text_widget.dart';
import 'package:mobile2/features/occam/application/balance/balance_cubit.dart';
import 'package:mobile2/features/occam/presentation/balance_header/header_loading.dart';

class BalanceHeader extends StatefulWidget {
  const BalanceHeader({Key? key}) : super(key: key);

  @override
  State<BalanceHeader> createState() => _BalanceHeaderState();
}

class _BalanceHeaderState extends State<BalanceHeader> {
  @override
  void initState() {
    context.read<BalanceCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BalanceCubit, BalanceState>(
      builder: (context, state) {
        switch (state.status) {
          case BalanceStatus.initial:
            return const BalanceHeaderLoading();
          case BalanceStatus.loading:
            return const BalanceHeaderLoading();
          case BalanceStatus.success:
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    DropdownButton2(
                      value: state.selectedNetwork,
                      underline: const SizedBox.shrink(),
                      icon: const Icon(
                        Icons.expand_more,
                        color: AppTheme.primary,
                      ),
                      dropdownWidth: 120,
                      buttonWidth: 80,
                      style: GoogleFonts.dmSans(),
                      isExpanded: true,
                      offset: const Offset(-20, 0),
                      onChanged: (ClusterNetworks? value) {
                        context.read<BalanceCubit>().changeNetwork(value!);
                      },
                      items: [
                        ...ClusterNetworks.values.map(
                          (network) => DropdownMenuItem(
                            value: network,
                            child: TextWidget(
                              network.name,
                              color: AppTheme.primary,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
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
                            onPressed: () {
                              OverlayEntry? overlay;
                              overlay = OverlayEntry(
                                  builder: (context) => NetworkOverlay(
                                        closeCallback: () => overlay?.remove(),
                                      ));

                              Overlay.of(context)?.insert(overlay);
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                TextWidget(
                  '\$${state.balance.toStringAsFixed(2)}',
                  fontSize: 58,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Iconify(
                      Fa6Solid.wallet,
                      color: AppTheme.purple,
                      size: 15,
                    ),
                    const SizedBox(width: 8),
                    DropdownButton2(
                      value: state.selectedWallet?.walletName,
                      underline: const SizedBox.shrink(),
                      icon: const Icon(
                        Icons.expand_more,
                        color: AppTheme.purple,
                      ),
                      dropdownWidth: 140,
                      buttonWidth: 100,
                      style: GoogleFonts.dmSans(),
                      isExpanded: true,
                      offset: const Offset(-20, 0),
                      onChanged: (String? value) {
                        context.read<BalanceCubit>().changeWallet(value!);
                      },
                      items: [
                        ...state.walletList.map(
                          (wallet) => DropdownMenuItem(
                            value: wallet.walletName,
                            child: TextWidget(
                              wallet.walletName,
                              color: AppTheme.purple,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            );
        }
      },
    );
  }
}

class NetworkOverlay extends StatelessWidget {
  const NetworkOverlay({Key? key, required this.closeCallback}) : super(key: key);

  final Function closeCallback;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Positioned(
      top: 0,
      left: 0,
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              color: Colors.black45.withOpacity(.75),
            ),
          ),
          Positioned(
            top: 70,
            left: 100,
            child: Material(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                width: 200,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => closeCallback.call(),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                        child: TextWidget(
                          'Testnet',
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const Divider(
                      color: AppTheme.inactive,
                    ),
                    GestureDetector(
                      onTap: () => closeCallback.call(),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 5.0, bottom: 10),
                        child: TextWidget(
                          'Mainnet',
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
