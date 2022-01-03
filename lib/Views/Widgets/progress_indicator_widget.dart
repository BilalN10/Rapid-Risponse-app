import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SmartDoubleBounceIndicatorWidget extends StatelessWidget {
  const SmartDoubleBounceIndicatorWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      color: Colors.white,
    );
  }
}
