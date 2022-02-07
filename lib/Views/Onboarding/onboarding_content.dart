import 'package:flutter/material.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key key,
    this.index,
    this.title,
    this.subtitle,
    this.image,
  }) : super(key: key);
  final String title, subtitle, image;
  final index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100 * SizeConfig.heightMultiplier,
      width: 100 * SizeConfig.widthMultiplier,
      decoration: BoxDecoration(
          color: Colors.red,
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 70 * SizeConfig.heightMultiplier,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
              //style: MyTextStyles.headline1.copyWith(color: primaryClr),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),

              // style: MyTextStyles.headline1.copyWith(color: primaryClr),
            ),
            const SizedBox(
              height: 0,
            ),
            // Container(
            //     alignment: Alignment.center,
            //     height: 60 * SizeConfig.heightMultiplier,
            //     width: 100 * SizeConfig.widthMultiplier,
            //     //  color: Colors.blue,
            //     child: Stack(
            //       children: [
            //         // CustomPaint(
            //         //   size: Size(100 * SizeConfig.widthMultiplier,
            //         //       60 * SizeConfig.heightMultiplier),
            //         //   painter: RPSCustomPainter1(),
            //         // ),
            //         // Container(
            //         //   alignment: Alignment.center,
            //         //   height: 100 * SizeConfig.heightMultiplier,
            //         //   width: 100 * SizeConfig.widthMultiplier,
            //         //   child: index == 1
            //         //       ? Padding(
            //         //           padding: EdgeInsets.only(
            //         //               top: 4.5 * SizeConfig.heightMultiplier,
            //         //               left: 2 * SizeConfig.widthMultiplier),
            //         //           child: Image.asset(image))
            //         //       : Image.asset(image),
            //         // )
            //       ],
            //     )),
          ],
        ),
      ),

      // child: Column(
      //   children: <Widget>[
      //     Text(
      //       title,
      //       textAlign: TextAlign.center,
      //       //style: MyTextStyles.headline1.copyWith(color: primaryClr),
      //     ),
      //     Text(
      //       subtitle,
      //       textAlign: TextAlign.center,
      //       // style: MyTextStyles.headline1.copyWith(color: primaryClr),
      //     ),
      //     const SizedBox(
      //       height: 0,
      //     ),
      //     Container(
      //         alignment: Alignment.center,
      //         height: 60 * SizeConfig.heightMultiplier,
      //         width: 100 * SizeConfig.widthMultiplier,
      //         //  color: Colors.blue,
      //         child: Stack(
      //           children: [
      //             // CustomPaint(
      //             //   size: Size(100 * SizeConfig.widthMultiplier,
      //             //       60 * SizeConfig.heightMultiplier),
      //             //   painter: RPSCustomPainter1(),
      //             // ),
      //             Container(
      //               alignment: Alignment.center,
      //               height: 100 * SizeConfig.heightMultiplier,
      //               width: 100 * SizeConfig.widthMultiplier,
      //               child: index == 1
      //                   ? Padding(
      //                       padding: EdgeInsets.only(
      //                           top: 4.5 * SizeConfig.heightMultiplier,
      //                           left: 2 * SizeConfig.widthMultiplier),
      //                       child: Image.asset(image))
      //                   : Image.asset(image),
      //             )
      //           ],
      //         )),
      //   ],
      // ),
    );
  }
}
