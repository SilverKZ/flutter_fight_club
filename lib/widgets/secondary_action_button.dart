import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';

class SecondaryActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const SecondaryActionButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: FightClubColors.darkGreyText,
          ),
          color: Colors.transparent,
        ),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: FightClubColors.darkGreyText,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
