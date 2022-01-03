import 'package:flutter/material.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Constants/colors.dart';

class MyTextField extends StatefulWidget {
  // const MyTextField({Key key}) : super(key: key);
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final Function validator;
  final bool isNumberField;
  final bool isPass;
  //final bool isPassword;
  MyTextField(
      {this.isPass,
      this.hintText,
      this.icon,
      this.controller,
      this.isNumberField,
      this.validator});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _showPass = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // padding: const EdgeInsets.fromLTRB(12, 4, 4, 4),
      //decoration: BoxDecoration(
      // border: Border.all(color: MyColors.input_border),
      ///borderRadius: BorderRadius.circular(10.0)),
      child: TextFormField(
          validator: widget.validator ??
              (value) => value == null || value.isEmpty ? 'Required' : null,
          controller: widget.controller,
          keyboardType:
              widget.isNumberField ? TextInputType.number : TextInputType.text,
          autofocus: false,
          obscureText: !_showPass && widget.isPass,

          //obscureText: isPassword,
          decoration: InputDecoration(
              suffixIcon: Icon(
                widget.icon,
                color: MyColors.primary,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 2, color: MyColors.input_border)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 2, color: MyColors.input_border)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      width: 2.0, color: MyColors.input_border)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 2, color: MyColors.input_border)),

              //  widget.isPass
              //     ? GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             _showPass = !_showPass;
              //           });
              //         },
              //         child: Icon(
              //           Icons.remove_red_eye,
              //           color: _showPass ? Colors.pink : Colors.grey,
              //         ),
              //       )
              //     : null,
              // suffixIcon: Icon(
              //   widget.icon,
              //   size: 8 * SizeConfig.imageSizeMultiplier,
              //   color: Colors.grey.withOpacity(0.2),
              // ),
              //border: InputBorder.none,
              hintStyle: const TextStyle(color: MyColors.hint),
              hintText: widget.hintText),
          onChanged: (value) {}),
    );
  }
}

class MypassWordField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final Function validator;
  final bool isNumberField;
  final bool isPass;
  //final bool isPassword;
  MypassWordField(
      {this.isPass,
      this.hintText,
      this.icon,
      this.controller,
      this.isNumberField,
      this.validator});

  // const MypassWordField({ Key key }) : super(key: key);

  @override
  _MypassWordFieldState createState() => _MypassWordFieldState();
}

class _MypassWordFieldState extends State<MypassWordField> {
  bool _showPass = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
          validator: widget.validator ??
              (value) => value == null || value.isEmpty ? 'Required' : null,
          controller: widget.controller,
          keyboardType:
              widget.isNumberField ? TextInputType.number : TextInputType.text,
          autofocus: false,
          obscureText: !_showPass && widget.isPass,

          //obscureText: isPassword,
          decoration: InputDecoration(
              suffixIcon: widget.isPass
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          print("press");

                          _showPass = !_showPass;
                        });
                      },
                      child: Icon(
                        Icons.remove_red_eye,
                        color: _showPass ? Colors.grey : MyColors.primary,
                      ),
                    )
                  : null,
              // suffixIcon: Icon(
              //   widget.icon,
              //   size: 8 * SizeConfig.imageSizeMultiplier,
              //   color: Colors.grey.withOpacity(0.2),
              // ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 2, color: MyColors.input_border)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 2, color: MyColors.input_border)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      width: 2.0, color: MyColors.input_border)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 2, color: MyColors.input_border)),
              hintStyle: const TextStyle(color: MyColors.hint),
              hintText: widget.hintText),
          onChanged: (value) {}),
    );
  }
}
