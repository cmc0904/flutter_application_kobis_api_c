import 'package:flutter/material.dart';
import 'package:flutter_application_kobis_api/kobis_api.dart';

class MovieDetail extends StatelessWidget {
  final String movieCd;
  MovieDetail({super.key, required this.movieCd});
  final kobisApi = KobisApi(apiKey: '5f591c41f4efbb8d272b60244907e9bd');

  @override
  Widget build(BuildContext context) {
    print(kobisApi.getMovieDetail(movieCd: movieCd));

    return Scaffold(
      body: Text("ㅎㅇ"),
    );
  }
}