import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';

import '../fight_result.dart';

class FightResultWidget extends StatelessWidget {
  final FightResult fightResult;

  const FightResultWidget({
    Key? key,
    required this.fightResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
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
                    fontSize: 14,
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
            Container(
              height: 44,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: _getResultBgColor(),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Center(
                child: Text(
                  fightResult.result.toLowerCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
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
                    fontSize: 14,
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

  Color _getResultBgColor() {
    if (fightResult.result == "Won") {
      return FightClubColors.wonButton;
    } else if (fightResult.result == "Lost") {
      return FightClubColors.lostButton;
    } else {
      return FightClubColors.drawButton;
    }
  }
}
