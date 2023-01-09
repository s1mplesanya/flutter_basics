import 'package:flutter/material.dart';
import 'package:lesson3/domain/api_client/api_client.dart';
import 'package:lesson3/domain/entity/movie_details_credits.dart';
import 'package:lesson3/ui/navigator/main_navigator.dart';
import 'package:lesson3/ui/widgets/movie_details/movie_details_model.dart';

import '../../../library/widgets/inherited/notifier_provider.dart';
import '../elements/radial_percent_widget.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _TopPosters(),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: _MovieNameWidget(),
        ),
        _ScoreWidget(),
        _SummaryWidget(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: _OverViewWidget(),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: _DescriptionWidget(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: _PeopleWidget(),
        ),
      ],
    );
  }
}

class _OverViewWidget extends StatelessWidget {
  const _OverViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Overview',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    return Text(
      model?.movieDetails?.overview ?? '',
      style: const TextStyle(color: Colors.white),
    );
  }
}

class _TopPosters extends StatelessWidget {
  const _TopPosters({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final backdropPath = model?.movieDetails?.backdropPath;
    final posterPath = model?.movieDetails?.posterPath;
    ApiClient.imageUrl(backdropPath ?? '');
    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(ApiClient.imageUrl(backdropPath))
              : const SizedBox.shrink(),
          const SizedBox(height: 150, child: Placeholder()),
          Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: SizedBox(
              width: 80,
              height: 120,
              child: posterPath != null
                  ? Image.network(ApiClient.imageUrl(posterPath))
                  : const SizedBox.shrink(),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              icon: Icon(model?.isFavorite == true
                  ? Icons.favorite
                  : Icons.favorite_outline),
              onPressed: () => model?.toggleFavorite(),
            ),
          )
        ],
      ),
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final year = model?.movieDetails?.releaseDate?.year.toString() ?? '';
    return Center(
      child: RichText(
        maxLines: 3,
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
              text: model?.movieDetails?.title ?? '',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 21)),
          TextSpan(
              text: ' ($year)',
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400)),
        ]),
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final movieDetails =
        NotifierProvider.watch<MovieDetailsModel>(context)?.movieDetails;
    final voteAverage = NotifierProvider.watch<MovieDetailsModel>(context)
            ?.movieDetails
            ?.voteAverage ??
        0;

    final videos = movieDetails?.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'Youtube');
    final trailerKey = videos?.isNotEmpty == true ? videos?.first.key : null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: RadialPercentWidget(
                  percent: voteAverage / 10,
                  fillColor: const Color.fromARGB(255, 10, 23, 25),
                  lineColor: const Color.fromARGB(255, 37, 203, 103),
                  freeColor: const Color.fromARGB(255, 25, 54, 31),
                  lineWeight: 3,
                  child: Text(
                    (voteAverage * 10).toStringAsFixed(0),
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text('Score'),
            ],
          ),
        ),
        Container(
          width: 1,
          height: 15,
          color: Colors.grey,
        ),
        trailerKey != null
            ? TextButton(
                onPressed: () => Navigator.of(context).pushNamed(
                    MainNavigationRoutesName.movieTrailer,
                    arguments: trailerKey),
                child: Row(
                  children: const [
                    Icon(Icons.play_arrow),
                    Text('Play Trayler'),
                  ],
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    if (model == null) return const SizedBox.shrink();

    var texts = <String>[];
    final releaseDate = model.movieDetails?.releaseDate;
    if (releaseDate != null) {
      texts.add(model.stringFromDate(releaseDate));
    }
    final productionCountries = model.movieDetails?.productionCountries;
    if (productionCountries != null && productionCountries.isNotEmpty) {
      texts.add('(${productionCountries.first.iso})');
    }
    final runtime = model.movieDetails?.runtime ?? 0;
    final duration = Duration(minutes: runtime);
    texts.add('${duration.inHours}h ${duration.inMinutes}m');

    final genres = model.movieDetails?.genres;
    if (genres != null && genres.isNotEmpty) {
      final genresNames = <String>[];
      for (var gern in genres) {
        genresNames.add(gern.name);
      }
      texts.add(genresNames.join(', '));
    }
    return ColoredBox(
      color: const Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(
          texts.join(),
          style: const TextStyle(
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
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var crew = model?.movieDetails?.credits.crew;
    if (crew == null || crew.isEmpty) return const SizedBox.shrink();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;

    var crewChunks = <List<Employee>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChunks
          .add(crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2));
    }

    return Column(
        children: crewChunks
            .map((chunk) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _PeopleWidgetRow(
                    employes: chunk,
                  ),
                ))
            .toList());
  }
}

class _PeopleWidgetRow extends StatelessWidget {
  final List<Employee> employes;
  const _PeopleWidgetRow({super.key, required this.employes});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        children: employes
            .map((employee) => _PeopleWidgetRowItem(
                  employee: employee,
                ))
            .toList());
  }
}

class _PeopleWidgetRowItem extends StatelessWidget {
  final Employee employee;
  const _PeopleWidgetRowItem({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    const peoplesTextStyle = TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400);
    const jobTitleTextStyle = TextStyle(
        color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            employee.name,
            style: peoplesTextStyle,
          ),
          Text(
            employee.job,
            style: jobTitleTextStyle,
          ),
        ],
      ),
    );
  }
}
