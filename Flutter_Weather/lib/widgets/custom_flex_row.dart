import 'package:flutter/material.dart';

class CustomFlexRow extends StatelessWidget {
  final int flex1;
  final Widget child1;
  final int flex2;
  final Widget child2;
  final int flex3;
  final Widget child3;
  final int flex4;
  final Widget child4;

  const CustomFlexRow({
    Key? key,
    required this.flex1,
    required this.child1,
    required this.flex2,
    required this.child2,
    required this.flex3,
    required this.child3,
    required this.flex4,
    required this.child4,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: SizedBox(height: 40, child: child1),
          flex: flex1,
        ),
        Expanded(
          child:  SizedBox(height: 40, child: child2),
          flex: flex2,
        ),
        Expanded(
          child:  SizedBox(height: 40, child: child3),
          flex: flex3,
        ),
        Expanded(
          child:  SizedBox(height: 40, child: child4),
          flex: flex4,
        ),
      ],
    );
  }
}
