import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_club_colors.dart';
import 'package:flutter_fight_club/fight_club_icons.dart';
import 'package:flutter_fight_club/fight_club_images.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.pressStart2pTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const maxLives = 5;

  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  BodyPart whatEnemyAttacks = BodyPart.random();
  BodyPart whatEnemyDefends = BodyPart.random();

  int yourLives = maxLives;
  int enemyLives = maxLives;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            FightersInfo(
              maxLivesCount: maxLives,
              yourLivesCount: yourLives,
              enemysLivesCount: enemyLives,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                child: ColoredBox(
                  color: FightClubColors.backgroundPanel,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: Text(
                        "",//_getTextFightersInfo(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: FightClubColors.darkGreyText,
                          fontSize: 10,
                          height: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ControlsWidget(
              defendingBodyPart: defendingBodyPart,
              attackingBodyPart: attackingBodyPart,
              selectDefendingBodyPart: _selectDefendingBodyPart,
              selectAttackingBodyPart: _selectAttackingBodyPart,
            ),
            SizedBox(height: 14),
            GoButton(
              onTap: _onGoButtonClicked,
              color: _getGoButtonColor(),
              text: yourLives == 0 || enemyLives == 0 ? "Start new game" : "Go",
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _selectDefendingBodyPart(final BodyPart value) {
    if (yourLives == 0 || enemyLives == 0) {
      return;
    }
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectAttackingBodyPart(final BodyPart value) {
    if (yourLives == 0 || enemyLives == 0) {
      return;
    }
    setState(() {
      attackingBodyPart = value;
    });
  }

  Color _getGoButtonColor() {
    if (yourLives == 0 || enemyLives == 0) {
      return FightClubColors.blackButton;
    } else if (defendingBodyPart == null || attackingBodyPart == null) {
      return FightClubColors.greyButton;
    } else {
      return FightClubColors.blackButton;
    }
  }

  void _onGoButtonClicked() {
    if (yourLives == 0 || enemyLives == 0) {
      setState(() {
        yourLives = maxLives;
        enemyLives = maxLives;
      });
    }
    if (defendingBodyPart != null && attackingBodyPart != null) {
      setState(() {
        final bool enemyLoseLife = attackingBodyPart != whatEnemyDefends;
        final bool youLoseLife = defendingBodyPart != whatEnemyAttacks;
        if (enemyLoseLife) {
          enemyLives--;
        }
        if (youLoseLife) {
          yourLives--;
        }

        whatEnemyDefends = BodyPart.random();
        whatEnemyAttacks = BodyPart.random();

        defendingBodyPart = null;
        attackingBodyPart = null;
      });
    }
  }

  String _getTextFightersInfo() {
    String text = "";
    setState(() {
      if (yourLives == 0 && enemyLives == 0) {
        text = "Draw";
      } else if (yourLives > 0 && enemyLives == 0) {
        text = "You won";
      } else if (yourLives == 0 && enemyLives > 0) {
        text = "You lost";
      } else {
        if (attackingBodyPart == whatEnemyDefends) {
          text = "Your attack was blocked.\n";
        } else {
          text = "You hit enemy’s ${whatEnemyDefends.toString().toLowerCase()}.\n";
        }
        if (defendingBodyPart == whatEnemyAttacks) {
          text += "Enemy’s attack was blocked.";
        } else {
          text += "Enemy hit your ${whatEnemyAttacks.toString().toLowerCase()}.";
        }
      }
  });
    return text;
  }
}

class InfoPanel extends StatelessWidget {
  final String text;

  const InfoPanel({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        child: ColoredBox(
          color: FightClubColors.backgroundPanel,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: FightClubColors.darkGreyText,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GoButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const GoButton({
    Key? key,
    required this.onTap,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 40,
          child: ColoredBox(
            color: color,
            child: Center(
              child: Text(
                text.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: FightClubColors.whiteText,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FightersInfo extends StatelessWidget {
  final int maxLivesCount;
  final int yourLivesCount;
  final int enemysLivesCount;

  const FightersInfo({
    Key? key,
    required this.maxLivesCount,
    required this.yourLivesCount,
    required this.enemysLivesCount,
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
              child: ColoredBox(
                color: FightClubColors.backgroundEnemyInfo,
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
            Padding(
              padding: const EdgeInsets.only(
                top: 27,
              ),
              child: LivesWidget(
                overllLivesCount: maxLivesCount,
                currentLivesCount: yourLivesCount,
              ),
            ),
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
            ColoredBox(
              color: Colors.green,
              child: SizedBox(
                width: 44,
                height: 44,
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
            Padding(
              padding: const EdgeInsets.only(
                top: 27,
              ),
              child: LivesWidget(
                overllLivesCount: maxLivesCount,
                currentLivesCount: enemysLivesCount,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class ControlsWidget extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectDefendingBodyPart;
  final ValueSetter<BodyPart> selectAttackingBodyPart;

  const ControlsWidget(
      {Key? key,
      required this.defendingBodyPart,
      required this.attackingBodyPart,
      required this.selectDefendingBodyPart,
      required this.selectAttackingBodyPart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              Text(
                "Defend".toUpperCase(),
                style: TextStyle(
                  color: FightClubColors.darkGreyText,
                ),
              ),
              SizedBox(height: 13),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: defendingBodyPart == BodyPart.head,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: defendingBodyPart == BodyPart.torso,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: defendingBodyPart == BodyPart.legs,
                bodyPartSetter: selectDefendingBodyPart,
              ),
            ],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              Text(
                "Attack".toUpperCase(),
                style: TextStyle(
                  color: FightClubColors.darkGreyText,
                ),
              ),
              SizedBox(height: 13),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: attackingBodyPart == BodyPart.head,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: attackingBodyPart == BodyPart.torso,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: attackingBodyPart == BodyPart.legs,
                bodyPartSetter: selectAttackingBodyPart,
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}

class LivesWidget extends StatelessWidget {
  final int overllLivesCount;
  final int currentLivesCount;

  const LivesWidget({
    Key? key,
    required this.overllLivesCount,
    required this.currentLivesCount,
  })  : assert(overllLivesCount >= 1),
        assert(currentLivesCount >= 0),
        assert(currentLivesCount <= overllLivesCount),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(overllLivesCount, (index) {
        if (index < currentLivesCount) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Image.asset(
              FightClubIcons.heartFull,
              width: 18,
              height: 18,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Image.asset(
              FightClubIcons.heartEmpty,
              width: 18,
              height: 18,
            ),
          );
        }
      }),
    );
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._("Head");
  static const torso = BodyPart._("Torso");
  static const legs = BodyPart._("Legs");

  @override
  String toString() {
    return '$name';
  }

  static const List<BodyPart> _values = [head, torso, legs];

  static BodyPart random() {
    return _values[Random().nextInt(_values.length)];
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton({
    Key? key,
    required this.bodyPart,
    required this.selected,
    required this.bodyPartSetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: ColoredBox(
          color: selected
              ? FightClubColors.blueButton
              : FightClubColors.greyButton,
          child: Center(
            child: Text(
              bodyPart.name.toUpperCase(),
              style: TextStyle(
                color: selected
                    ? FightClubColors.whiteText
                    : FightClubColors.darkGreyText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
