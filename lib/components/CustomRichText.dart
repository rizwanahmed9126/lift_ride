import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textColor, iconColor;

  const CustomRichText({
    this.icon,
    this.text,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Icon(icon,size: 19,color: iconColor,),
            ),
          ),
          TextSpan(text: text,style: TextStyle(color: textColor,)),
        ],
      ),
    );
  }
}
