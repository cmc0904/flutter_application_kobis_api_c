import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';

class MoviedetailViewS extends StatelessWidget {
  var moviesData;

  MoviedetailViewS({super.key, required this.moviesData});


  @override
  Widget build(BuildContext context) {
    
    var grade = moviesData['audits'][0]["watchGradeNm"].toString();
    Map<String, dynamic> gradeStyle = {};

    if(grade == "15세이상관람가") {
      gradeStyle['color']= Colors.blue;
      gradeStyle['text'] = '15';
    }
    return Column(
      children: [
        Text(moviesData['movieNm']),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: gradeStyle['color']
              ),
            ),
            Container(
              child: Center(child: Text(gradeStyle['text'])),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white
        
              ),
            )
          ],
        )
      ],
    );
  }
}
