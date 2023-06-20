import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_kobis_api/kobis_api.dart';
import 'package:accordion/accordion.dart';

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

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "영화 제목 : ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          moviesData?['movieNm'],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "개봉일 : ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          moviesData?['movieNmEn'],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "시청 연령 제한 : ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          moviesData?['audits'][0]["watchGradeNm"],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "개봉일 : ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          moviesData?['openDt'],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Text(
                    "추가정보",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Accordion(
                    maxOpenSections: 2,
                    headerBackgroundColorOpened: Colors.black54,
                    scaleWhenAnimating: true,
                    openAndCloseAnimation: true,
                    headerPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                    sectionClosingHapticFeedback: SectionHapticFeedback.light,
                    children: [
                      AccordionSection(
                        isOpen: false,
                        leftIcon: const Icon(Icons.build, color: Colors.white),
                        header: Text('제작 참여 회사',
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        content: DataTable(
                          sortAscending: true,
                          sortColumnIndex: 1,
                          dataRowHeight: 40,
                          showBottomBorder: false,
                          columns: [
                            DataColumn(
                              label: Text('회사',
                                  style: TextStyle(
                                      color: Color(0xff999999),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700)),
                            ),
                            DataColumn(
                              label: Text('역할',
                                  style: TextStyle(
                                      color: Color(0xff999999),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ],
                          rows: [
                            for (var i in moviesData?['companys'])
                              DataRow(
                                cells: [
                                  DataCell(Text(i['companyNm'],
                                      style: TextStyle(
                                          color: Color(0xff999999),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.right)),
                                  DataCell(Text(i['companyPartNm'],
                                      style: TextStyle(
                                          color: Color(0xff999999),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.right))
                                ],
                              ),
                          ],
                        ),
                      ),
                      AccordionSection(
                        isOpen: false,
                        leftIcon: const Icon(Icons.person, color: Colors.white),
                        header: Text('배우',
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 15,233213232


                                
                                fontWeight: FontWeight.bold)),
                        content: DataTable(
                          sortAscending: true,
                          sortColumnIndex: 1,
                          dataRowHeight: 40,
                          showBottomBorder: false,
                          columns: [
                            DataColumn(
                              label: Text('배역',
                                  style: TextStyle(
                                      color: Color(0xff999999),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700)),
                            ),
                            DataColumn(
                                label: Text('배우 이름',
                                    style: TextStyle(
                                        color: Color(0xff999999),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700))),
                          ],
                          rows: [
                            for (var i in moviesData?['actors'])
                              DataRow(
                                cells: [
                                  DataCell(Text(i['cast'],
                                      style: TextStyle(
                                          color: Color(0xff999999),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700))),
                                  DataCell(Text(i['peopleNm'],
                                      style: TextStyle(
                                          color: Color(0xff999999),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700))),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
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
