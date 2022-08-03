import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:occam/constants/colors.dart';

class SecondNavigation extends StatelessWidget {
  const SecondNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFF646464),
            width: 1,
          ),
        ),
        color: Theme.of(context).canvasColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              const Icon(
                Icons.arrow_circle_down,
                color: AppTheme.green,
              ),
              const SizedBox(width: 2),
              Text(
                'Deposit',
                style: GoogleFonts.dmSans(
                  color: AppTheme.green,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.arrow_circle_up,
                color: AppTheme.green,
              ),
              const SizedBox(width: 2),
              Text(
                'Withdraw',
                style: GoogleFonts.dmSans(
                  color: AppTheme.green,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.swap_horizontal_circle_outlined,
                color: AppTheme.green,
              ),
              const SizedBox(width: 2),
              Text(
                'Swap',
                style: GoogleFonts.dmSans(
                  color: AppTheme.green,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
