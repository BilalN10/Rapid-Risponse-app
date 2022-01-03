import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Constants/colors.dart';
import 'package:rapid_response/Views/Widgets/mytextfield.dart';

class RapidResponseDialog extends StatefulWidget {
  final blur;

  const RapidResponseDialog({Key key, this.blur = true}) : super(key: key);

  @override
  _RapidResponseDialogState createState() => _RapidResponseDialogState();
}

class _RapidResponseDialogState extends State<RapidResponseDialog> {
  final _formKey = GlobalKey<FormState>();

  final UserAthenticationController userAthenticationController =
      Get.find<UserAthenticationController>();
  bool checkedValue = false;
  static const Map<String, int> frequencyOptions = {
    "Guard": 444,
    "Comitee Members": 333,
    "All": 000,
    "Resident": 222,
  };

  int _frequencyValue = 000;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationCurve: Curves.linearToEaseOut,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    var blurVal = 0.0;
    if (widget.blur) {
      blurVal = 10.0;
    }
    return SizedBox(
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurVal, sigmaY: blurVal),
          child: Container(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Medical",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          //Get.back();
                          OneContext().popDialog();
                        },
                        icon: Icon(
                          Icons.clear,
                          color: MyColors.grey,
                        ))
                  ],
                )),
                Container(
                    child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 4),
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: MyColors.primary, shape: BoxShape.circle),
                      child: Text(
                        '6',
                        style: TextStyle(color: MyColors.white),
                      ),
                    ),
                    Text(
                      "Responders",
                    )
                  ],
                )),

                const SizedBox(
                  height: 16,
                ),
                // DropdownSearch<String>(
                //     hint: "Send to : All",
                //     mode: Mode.BOTTOM_SHEET,
                //     showSearchBox: true,
                //     searchBoxDecoration: InputDecoration(
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.grey, width: 0.4),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.grey, width: 0.4),
                //       ),
                //       labelText: "Send to : All",
                //     ),
                //     items: ['All'],
                //     // selectedItem: _store.skpd,
                //     showClearButton: true,
                //     onChanged: (value) {

                //     }),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  height: 6 * SizeConfig.heightMultiplier,
                  width: 90 * SizeConfig.widthMultiplier,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<int>(
                      isExpanded: true,
                      underline: SizedBox(),
                      items: frequencyOptions
                          .map((description, value) {
                            return MapEntry(
                                description,
                                DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(description),
                                ));
                          })
                          .values
                          .toList(),
                      value: _frequencyValue,
                      onChanged: (int newValue) {
                        if (newValue != null) {
                          setState(() {
                            print(newValue);
                            _frequencyValue = newValue;
                            userAthenticationController
                                .sendAlertDialog(_frequencyValue);
                          });
                        }
                      },
                    ),
                    //  DropdownButton<String>(
                    //   borderRadius: BorderRadius.circular(10),
                    //   isExpanded: true,
                    //   value: dropdownValue,
                    //   icon: const Icon(Icons.keyboard_arrow_down_outlined),
                    //   iconSize: 24,
                    //   elevation: 16,
                    //   underline: SizedBox(),
                    //   // style: const TextStyle(color: Colors.deepPurple),
                    //   // underline: Container(
                    //   //   width: 50,
                    //   //   height: 5,
                    //   //   color: Colors.black,
                    //   // ),
                    //   onChanged: (String newValue) {
                    //     setState(() {
                    //       dropdownValue = newValue;
                    //     });
                    //   },
                    //   items: <String>[
                    //     'All',
                    //     'Residenct',
                    //     'Guard',
                    //     'Comitee memebers'
                    //   ].map<DropdownMenuItem<String>>((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    // ),
                  ),
                ),
                // MyTextField(
                //   isPass: false,
                //   validator: (value) {
                //     if (value.isEmpty || value == null) {
                //       return "Required";
                //     }
                //     //  else if (!GetUtils.isEmail(value)) {
                //     //   return "Invalid Email";
                //     // }
                //     else {
                //       return null;
                //     }
                //   },
                //   // controller:
                //   //     userAthenticationController.signupUnitCodeController,
                //   hintText: "Send to all",
                //   icon: Icons.qr_code,
                //   isNumberField: false,
                // ),

                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Required";
                      }
                      //  else if (!GetUtils.isEmail(value)) {
                      //   return "Invalid Email";
                      // }
                      else {
                        return null;
                      }
                    },
                    controller: userAthenticationController
                        .dialogNotifiactionController,
                    autofocus: false,
                    minLines: 6,
                    keyboardType: TextInputType.text,
                    maxLines: null,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.4),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.4),
                      ),
                      labelText: 'Description',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    ),
                    onChanged: (value) {},
                  ),
                ),

                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    _inputValidation();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 90 * SizeConfig.widthMultiplier,
                    height: 6 * SizeConfig.heightMultiplier,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: MyColors.primary,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0, color: MyColors.primary)),
                    child: const Text(
                      "Send Rapid Response",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _inputValidation() {
    if (_formKey.currentState.validate()) {
      userAthenticationController.sendNotification();
    } else {
      print("Form is not validate");
    }
  }
}

class DropDownModel {
  String titel;
  String number;
  DropDownModel({this.number, this.titel});
}