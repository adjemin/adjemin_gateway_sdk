import 'package:flutter/material.dart';

class CustomProgressWidget extends StatelessWidget {

  const CustomProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Container(
          color: Colors.white,
        ),
        const Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );

  }

}
