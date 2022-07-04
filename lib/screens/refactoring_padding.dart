import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({Key? key,required this.onTap,required this.title,required this.color}) : super(key: key);
  final String title;
  final Function() onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: color,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: onTap,
                  minWidth: 200.0,
                  height: 42.0,
                  child:Text(title,style: const TextStyle(color: Colors.white),),
                ),
              ),
            );
  }
}