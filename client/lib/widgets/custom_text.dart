import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? textNamed;
  final void Function()? onTap;
  const CustomText({super.key, this.textNamed, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            textNamed!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          InkWell(onTap: onTap, child: const Text("View All"))
        ],
      ),
    );
  }
}
