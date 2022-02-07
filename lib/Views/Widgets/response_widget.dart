import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResponseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.transparent),
      child: SvgPicture.asset('assets/images/bottom_nav.svg'),
    );
  }
}
