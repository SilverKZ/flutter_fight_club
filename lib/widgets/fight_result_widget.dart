import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';

import '../fight_result.dart';

class FightResultWidget extends StatelessWidget {
  // final FightResult? fightResult;

  const FightResultWidget({
    Key? key,
    // required this.fightResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ColoredBox(
                color: FightClubColors.backgroundYourInfo,
                child: SizedBox(
                  height: double.infinity,
                ),
              ),
            ),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, FightClubColors.darkPurple],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ColoredBox(
                color: FightClubColors.darkPurple,
                child: SizedBox(
                  height: double.infinity,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SizedBox(height: 16),
                Text(
                  "You",
                  style: TextStyle(
                    color: FightClubColors.darkGreyText,
                  ),
                ),
                SizedBox(height: 12),
                Image.asset(
                  FightClubImages.youAvatar,
                  width: 92,
                  height: 92,
                ),
              ],
            ),
            SizedBox(
              width: 44,
              height: 44,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: FightClubColors.blueButton,
                ),
                child: Center(
                  child: Text(
                    "vs",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 16),
                Text(
                  "Enemy",
                  style: TextStyle(
                    color: FightClubColors.darkGreyText,
                  ),
                ),
                SizedBox(height: 12),
                Image.asset(
                  FightClubImages.enemyAvatar,
                  width: 92,
                  height: 92,
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
