import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:mobile2/constants/colors.dart';
import 'package:mobile2/features/occam/application/balance/balance_cubit.dart';
import 'package:mobile2/widgets/text_widget.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';

class BalanceHeader extends StatefulWidget {
  const BalanceHeader({Key? key}) : super(key: key);

  @override
  State<BalanceHeader> createState() => _BalanceHeaderState();
}

class _BalanceHeaderState extends State<BalanceHeader> {
  final ValueNotifier<String> _selectedWallet = ValueNotifier('Test Wallet');

  final ValueNotifier<ClusterNetworks> _selectedNetwork = ValueNotifier(ClusterNetworks.testnet);

  @override
  void initState() {
    context.read<BalanceCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BalanceCubit, BalanceState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const Spacer(),
                ValueListenableBuilder<ClusterNetworks>(
                  valueListenable: _selectedNetwork,
                  builder: (context, ClusterNetworks value, Widget? widget) {
                    return DropdownButton2(
                      value: value,
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
                        _selectedNetwork.value = value!;
                      },
                      items: const [
                        DropdownMenuItem(
                          value: ClusterNetworks.mainnet,
                          child: TextWidget(
                            'Mainnet Beta',
                            color: AppTheme.primary,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ),
                        DropdownMenuItem(
                          value: ClusterNetworks.testnet,
                          child: TextWidget(
                            'Testnet',
                            color: AppTheme.primary,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ),
                        DropdownMenuItem(
                          value: ClusterNetworks.devnet,
                          child: TextWidget(
                            'Devnet',
                            color: AppTheme.primary,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    );
                  },
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
                const SizedBox(width: 8),
                ValueListenableBuilder<String>(
                  valueListenable: _selectedWallet,
                  builder: (context, String value, Widget? widget) {
                    return DropdownButton2(
                      value: value,
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
                        _selectedWallet.value = value!;
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'Test Wallet',
                          child: TextWidget(
                            'Test Wallet',
                            color: AppTheme.purple,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Test2 Wallet2',
                          child: TextWidget(
                            'Test2 Wallet2',
                            color: AppTheme.purple,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    );
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }
}
