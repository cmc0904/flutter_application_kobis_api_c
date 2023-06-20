import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_kobis_api/kobis_api.dart';
import 'package:accordion/accordion.dart';
import 'movie_detail_view.dart';

class MovieDetail extends StatelessWidget {
  final String movieCd;
  MovieDetail({super.key, required this.movieCd});
  final kobisApi = KobisApi(apiKey: '5f591c41f4efbb8d272b60244907e9bd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("영화 상세 정보"), centerTitle: true),
      body: FutureBuilder(
          future: kobisApi.getMovieDetail(movieCd: movieCd),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var moviesData = snapshot.data;
              return MoviedetailView(moviesData: moviesData);
            } else {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.pink,
              ));
            }
          }),
    );
  }
}
