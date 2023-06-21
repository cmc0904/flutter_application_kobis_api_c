import 'dart:convert';

import 'package:http/http.dart' as http;

class KobisApi {
  final String apiKey;
  final String SITE = "http://kobis.or.kr/kobisopenapi/webservice/rest";

  KobisApi({required this.apiKey});

  Future<List<dynamic>> getDaliyBoxOffice({required String targetDt}) async {
    String uri = "$SITE/boxoffice/searchDailyBoxOfficeList.json?key=$apiKey&targetDt=$targetDt";

    var res = await http.get(Uri.parse(uri));

    if(res.statusCode == 200) {
      List<dynamic> movies = jsonDecode(res.body)["boxOfficeResult"]["dailyBoxOfficeList"] as List<dynamic>;
      return movies;
    }
    return [];
  }

  Future<Map<String, dynamic>> getMovieDetail({required String movieCd}) async {
    var uri = "$SITE/movie/searchMovieInfo.json?key=$apiKey&movieCd=$movieCd";

    var res = await http.get(Uri.parse(uri));

    if(res.statusCode == 200) {
      Map<String, dynamic> movieInfo = jsonDecode(res.body)["movieInfoResult"]["movieInfo"] as Map<String, dynamic>;
      return movieInfo;
    }
    return {};
  }

    Future<dynamic> getCompanyDetail({required String companyCd}) async {
    var uri = "$SITE/company/searchCompanyInfo.json?key=$apiKey&companyCd=$companyCd";

    var res = await http.get(Uri.parse(uri));

    if(res.statusCode == 200) {
      Map<String, dynamic> movieCompany = jsonDecode(res.body)["companyInfoResult"]["companyInfo"] as dynamic;
      return movieCompany;
    }
    return {};
  }
}