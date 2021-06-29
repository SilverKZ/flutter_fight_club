import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Text(
                "Statistics",
                style: TextStyle(
                  fontSize: 24,
                  color: FightClubColors.darkGreyText,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StatisticsWidget(sharedPreferencesKey: "stats_won", title: "Won"),
                  StatisticsWidget(sharedPreferencesKey: "stats_draw", title: "Draw"),
                  StatisticsWidget(sharedPreferencesKey: "stats_lost", title: "Lost"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SecondaryActionButton(
                onTap: () {
                  Navigator.of(context).pop();
                },
                text: "Back",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticsWidget extends StatelessWidget {
  final String sharedPreferencesKey;
  final String title;

  const StatisticsWidget({
    Key? key,
    required this.sharedPreferencesKey,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
      future: SharedPreferences.getInstance().then(
        (sharedPreferences) => sharedPreferences.getInt(sharedPreferencesKey),
      ),
      builder: (context, snapshot) {
        int value =
            (!snapshot.hasData || snapshot.data == null) ? 0 : snapshot.data!;
        return Text(
          "$title: ${value.toString()}",
          style: TextStyle(fontSize: 16, height: 2.4),
        );
      },
    );
  }
}
