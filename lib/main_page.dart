import 'package:flutter/material.dart';
import 'kobis_api.dart';
import 'movie_detail.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final kobisApi = KobisApi(apiKey: '5f591c41f4efbb8d272b60244907e9bd');
  String selectedDate = "날짜를 입력 해주세요";
  dynamic bodyPage = null;
  void showCal() async {
    var dt = await showDatePicker(context: context, 
    initialDate: DateTime.now().subtract(const Duration(days: 1)), 
    firstDate: DateTime(2022), 
    lastDate: DateTime.now().subtract(const Duration(days: 1))
    );
    if(dt !=null){
      //2022-02-02 00:00:00
      var targetDt = dt.toString().split(' ')[0].replaceAll('-', '');
      var movies = kobisApi.getDaliyBoxOffice(targetDt: targetDt);
      showList(movies, dt.toString().split(' ')[0]);
    }
  }

  void showList(Future<List<dynamic>> movies, String date) { //결과를 보여줄 곳
    setState(() {
      selectedDate = date;
      bodyPage = FutureBuilder(future: movies , builder: (context, snapshot) {
        if(snapshot.hasData) {
          //데이터가 넘어옴
          var moviesData = snapshot.data;
        
          return ListView.separated(
            itemBuilder: (context, index) {
              var rankColor = Colors.black;
              if(index==0){
                rankColor = Colors.red;
              }else if (index==1){
                rankColor = Colors.blue;
              }else if (index==2){
                rankColor = Colors.green;
              }
              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(moviesData[index]['rank'], style: TextStyle(fontSize: 15, color: Colors.white),),
                  decoration: BoxDecoration(color: rankColor, borderRadius: BorderRadius.circular(8)),
                ),
                title: Text(moviesData[index]['movieNm']),
                subtitle: Text('${moviesData[index]['openDt']}'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap:() => Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => MovieDetail(movieCd: moviesData[index]['movieCd']),
                  )
                ),
              );
            }, 
            separatorBuilder: (context, index) => Divider(), 
            itemCount: moviesData!.length
          );
        }else{
          //loading...
          return Center(child: CircularProgressIndicator(color: Colors.pink,));
        }
      },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Icon(
              Icons.search,
              color: Colors.black12,
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              flex: 1,
              child: SizedBox(
                child: Text(
                  selectedDate,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                width: 2000,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            TextButton(
              onPressed: () {
                showCal();
              },
              child: const Text('검색'),
            ),
          ],
        ),
      ),

      body: bodyPage,
    );
  }
}