import 'package:flutter/material.dart';
import 'package:occam/widgets/loading_skeleton.dart';

class SheetLoading extends StatelessWidget {
  const SheetLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                LoadingSkeleton(
                  size: const Size(50, 50),
                  borderRadius: BorderRadius.circular(100),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            LoadingSkeleton(size: Size(59, 17)),
                            LoadingSkeleton(size: Size(59, 17)),
                          ],
                        ),
                      ),
                      Divider(
                        color: const Color(0xFF4D4D4D).withOpacity(.5),
                        thickness: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            LoadingSkeleton(size: Size(59, 17)),
                            LoadingSkeleton(size: Size(59, 17)),
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
}
