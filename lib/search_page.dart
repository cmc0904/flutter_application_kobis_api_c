import 'package:flutter/material.dart';
import 'package:flutter_application_kobis_api/kobis_api.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  var _searchType = "movieNm";
  var kobis = KobisApi(apiKey: "5f591c41f4efbb8d272b60244907e9bd");

  void getMoveList() async {
    var movies = await kobis.getSearchMovieList(searchType: _searchType, searchValue: controller.text);

    for(var movie in movies) {
      print(movie);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          DropdownButton(
            items: [
              DropdownMenuItem(child: Text("영화제목"), value: "movieNm"),
              DropdownMenuItem(child: Text("감독명"), value: "directorNm"),
            ],
            onChanged: (value) {
              print(value);
              _searchType = value.toString();
            },
          ),

          Expanded(
            child: TextFormField(
              autofocus: true,
              controller: controller,
            ),
          ),

          ElevatedButton(onPressed: getMoveList, child: Text("검색"))
        ],
      ),
    );
  }
}