import 'package:flutter/material.dart';

class Tab1Data extends StatefulWidget {
  const Tab1Data({Key key}) : super(key: key);

  @override
  State<Tab1Data> createState() => _Tab1DataState();
}

class _Tab1DataState extends State<Tab1Data> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          myWidget(
              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual "),
          myWidget(
              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual "),
          myWidget(
              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual "),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black54,
            ),
            child: const Text(
              "Confirm",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget myWidget(String text) {
    return Container(
      alignment: Alignment.center,
      height: 70,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(blurRadius: 10, color: Colors.black12),
          ]),
      child: Text(text),
    );
  }
}
