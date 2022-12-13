import 'package:flutter/material.dart';

import '../elements/radial_percent_widget.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _TopPosters(),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: _MovieNameWidget(),
        ),
        const _ScoreWidget(),
        const _SummaryWidget(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: _overViewWidget(),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: _descriptionWidget(),
        ),
        const _PeopleWidget(),
      ],
    );
  }

  Text _descriptionWidget() {
    return const Text(
      'Жил да был в сказочном государстве большой зеленый великан по имени Шрэк. Жил он в гордом одиночестве в лесу, на болоте, которое считал своим. Но однажды злобный коротышка — лорд Фаркуад, правитель волшебного королевства, безжалостно согнал на Шрэково болото всех сказочных обитателей. \nИ беспечной жизни зеленого великана пришел конец. Но лорд Фаркуад пообещал вернуть Шрэку болото, если великан добудет ему прекрасную принцессу Фиону, которая томится в неприступной башне, охраняемой огнедышащим драконом.',
      style: TextStyle(color: Colors.white),
    );
  }

  Text _overViewWidget() {
    return const Text(
      'Overview',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}

class _TopPosters extends StatelessWidget {
  const _TopPosters({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        // Image(image: AssetImage(AppImages.topHeader))
        SizedBox(height: 150, child: Placeholder()),
        Positioned(
          top: 20,
          left: 20,
          bottom: 20,
          child: SizedBox(
            width: 80,
            height: 120,
            child: Placeholder(),
          ),
        ),
      ],
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 3,
      textAlign: TextAlign.center,
      text: const TextSpan(children: [
        TextSpan(
            text: 'Шрэк',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21)),
        TextSpan(
            text: ' [2001]',
            style: TextStyle(
                color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400)),
      ]),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: const [
              SizedBox(
                width: 40,
                height: 40,
                child: RadialPercentWidget(
                  percent: 0.72,
                  fillColor: Color.fromARGB(255, 10, 23, 25),
                  lineColor: Color.fromARGB(255, 37, 203, 103),
                  freeColor: Color.fromARGB(255, 25, 54, 31),
                  lineWeight: 3,
                  child: Text(
                    '72',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text('Score'),
            ],
          ),
        ),
        Container(
          width: 1,
          height: 15,
          color: Colors.grey,
        ),
        TextButton(
          onPressed: () {},
          child: Row(
            children: const [
              Icon(Icons.play_arrow),
              Text('Play Trayler'),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
        child: Text(
          'R, 31 октября 2001 1ч 49мин Мультфильм, фэнтези, мелодрама, комедия, приключения, семейный',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
          maxLines: 3,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _PeopleWidget extends StatelessWidget {
  const _PeopleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const peoplesTextStyle = TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400);
    const jobTitleTextStyle = TextStyle(
        color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400);
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Майк Маерс',
                  style: peoplesTextStyle,
                ),
                Text(
                  'Актер',
                  style: jobTitleTextStyle,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Эдди Мерфи',
                  style: peoplesTextStyle,
                ),
                Text(
                  'Актер',
                  style: jobTitleTextStyle,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Майк Маерс',
                  style: peoplesTextStyle,
                ),
                Text(
                  'Актер',
                  style: jobTitleTextStyle,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Эдди Мерфи',
                  style: peoplesTextStyle,
                ),
                Text(
                  'Актер',
                  style: jobTitleTextStyle,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
