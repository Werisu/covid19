import 'dart:ui';

import 'package:covid19/constants.dart';
import 'package:covid19/widgets/weeklyChart_Card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildDetailAppBar(context),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 21),
                        blurRadius: 53,
                        color: Colors.black.withOpacity(0.05)
                      )
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildTitleWithMore(),
                      SizedBox(height: 15,),
                      buildCasesNumber(context),
                      SizedBox(height: 15,),
                      Text(
                        "De Secretarias Estaduais de Saúde",
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: kTextMediumColor,
                          fontSize: 16
                        ),
                      ),
                      SizedBox(height: 15,),
                      WeeklyChart(),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          buildInfoTextWithPercentage(
                            title: "Semana Passada",
                            percentage: "6.43"
                          ),
                          buildInfoTextWithPercentage(
                            title: "Taxa de Recuperação",
                            percentage: "9.43"
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                        BoxShadow(
                        offset: Offset(0,21),
                        blurRadius: 54,
                        color: Colors.black.withOpacity(0.05)
                      )
                    ]
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Mapa Global",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          SvgPicture.asset("assets/icons/more.svg")
                        ],
                      ),
                      SizedBox(height: 20,),
                      SvgPicture.asset("assets/icons/map.svg")
                    ],
                  ),
                )
              ],
            ),
            ),
        ],
      ),
    );
  }

  RichText buildInfoTextWithPercentage({String title, String percentage}) {
    return RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "$percentage%\n",
                            style: TextStyle(
                              fontSize: 20,
                              color: kPrimaryColor
                            ),
                          ),
                          TextSpan(
                            text: title,
                            style: TextStyle(
                              color: kTextMediumColor,
                              height: 1.5
                            ),
                          )
                        ]
                      )
                    );
  }

  Row buildCasesNumber(BuildContext context) {
    return Row(
                  children: <Widget>[
                    Text(
                      "547",
                      style: Theme.of(context).textTheme.display3.copyWith(color: kPrimaryColor),
                    ),
                    Text(
                      "5,9% ",
                      style: TextStyle(
                        color: kPrimaryColor
                      ),
                    ),
                    SvgPicture.asset("assets/icons/increase.svg")
                  ],
                );
  }

  Row buildTitleWithMore() {
    return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Novos Casos",
                      style: TextStyle(
                        color: kTextMediumColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/icons/more.svg"
                    )
                  ],
                );
  }

  AppBar buildDetailAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: kPrimaryColor,
        ), 
        onPressed: (){
          Navigator.pop(context);
        }
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"), 
          onPressed: (){}
        )
      ],
      title: Text("Detalhes"),
    );
  }
}