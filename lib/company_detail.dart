import 'package:flutter/material.dart';

import 'kobis_api.dart';

class CompanyDialog extends StatelessWidget {
  final String companyCd;
  CompanyDialog({super.key, required this.companyCd});
  final kobisApi = KobisApi(apiKey: '5f591c41f4efbb8d272b60244907e9bd');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: kobisApi.getCompanyDetail(companyCd: companyCd),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var companyData = snapshot.data;
          print(companyData);

          return AlertDialog(
            title: Center(child: Text("영화 회사 상세 정보")),
            actions: [TextButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text("끄기"))],
            content: Container(
              width: 500,
              height: 500,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "회사 이름 : ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          companyData?['companyNm'],
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "회사 영문 이름 : ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          companyData?['companyNmEn'] == null
                              ? "제공 정보 없음"
                              : companyData?['companyNmEn'],
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "대표자 이름 : ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          companyData['ceoNm'] == null? "제공된 정보 없음" : companyData['ceoNm'],
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "파트 : ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            for (var i in companyData['parts'])
                              Text(i['companyPartNm'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Text(
                    "활동 이력 (5개만)",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  DataTable(
                    sortAscending: true,
                    sortColumnIndex: 1,
                    dataRowHeight: 40,
                    showBottomBorder: false,
                    columns: [
                      DataColumn(
                        label: Text('영화 제목',
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
                      for (var i in companyData?['filmos'].sublist(0, 5))
                        DataRow(
                          cells: [
                            DataCell(
                              Text(i['movieNm'],
                                  style: TextStyle(
                                      color: Color(0xff999999),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.right),
                            ),
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
                ],
              ),
            ),
          );
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.pink,
          ));
        }
      },
    );

    // return Dialog(

    //   child: Container(
    //     width: 100,
    //     height: 100,
    //     child: Column(
    //       children: [
    //         Text("회사 이름 : "),
    //         Text("회사 영문 :")
    //       ],
    //     ),
    //   ),
    // );
  }
}
