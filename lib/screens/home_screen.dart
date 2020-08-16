import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19/constants.dart';
import 'package:covid19/screens/details_screen.dart';
import 'package:covid19/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: ListView(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 5, top: 0, right: 5, bottom: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.03),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                child: StreamBuilder(
                    stream:
                        Firestore.instance.collection("tocantins").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData) {
                        return Text("Vazio: ${snapshot.hasData}");
                      }

                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return CircularProgressIndicator();
                          break;
                        default:
                          return Center(
                            child: Wrap(
                                runSpacing: 5,
                                spacing: 5,
                                children: snapshot.data.documents
                                    .map<Widget>((DocumentSnapshot doc) {
                                  return Wrap(
                                    children: <Widget>[
                                      InfoCard(
                                        title: "Confirmados",
                                        iconColor: Color(0xFFFF8C00),
                                        effectedNum: doc.data['confirmados'],
                                        press: () {},
                                      ),
                                      InfoCard(
                                          title: "Óbitos",
                                          iconColor: Color(0xFFFF2D55),
                                          effectedNum: doc.data['mortos'],
                                          press: () {}),
                                      InfoCard(
                                          title: "Recuperados",
                                          iconColor: Color(0xFF50E3C2),
                                          effectedNum: doc.data['recuperados'],
                                          press: () {}),
                                      InfoCard(
                                          title: "Ativos",
                                          iconColor: Color(0xFF5856D6),
                                          effectedNum: doc.data['ativos'],
                                          press: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return DetailsScreen();
                                                },
                                              ),
                                            );
                                          }),
                                      // Row(
                                      //   children: <Widget>[
                                      //     Text(
                                      //       "data: ${doc.data['data'].toDate().day}/0${doc.data['data'].toDate().month}/${doc.data['data'].toDate().year}",
                                      //       style:
                                      //           TextStyle(color: Colors.grey),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  );
                                }).toList()),
                          );
                      }
                    })),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Prevenção",
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    buildPrevetionCard(),
                    SizedBox(
                      height: 40,
                    ),
                    buildHelpCard(context)
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Row buildPrevetionCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        PreventionCard(
          svgSrc: "assets/icons/hand_wash.svg",
          title: "Lave as\nMãos",
        ),
        PreventionCard(
          svgSrc: "assets/icons/use_mask.svg",
          title: "Use\nMáscara",
        ),
        PreventionCard(
          svgSrc: "assets/icons/Clean_Disinfect.svg",
          title: "Limpe\nDesinfecte",
        ),
      ],
    );
  }

  Container buildHelpCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 150,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * .4,
              top: 20,
              right: 10,
            ),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFF60BE93),
                  Color(0xFF1B8D59),
                  Color(0xFF1B8DAA),
                ]),
                borderRadius: BorderRadius.circular(20)),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Disque 136\nAjuda Médica!\n",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.white)),
              TextSpan(
                  text: "Se algum sintoma aparecer",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7), fontSize: 12))
            ])),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset("assets/icons/nurse.svg"),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: SvgPicture.asset("assets/icons/virus.svg"),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor.withOpacity(.03),
      title: Row(
        children: <Widget>[
          Text(
            "Covid Tocantins",
            style: TextStyle(color: kPrimaryColor),
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/tocantins.svg"),
            onPressed: null,
            color: kPrimaryColor,
          )
        ],
      ),
      elevation: 0,
      leading: IconButton(
          icon: SvgPicture.asset("assets/icons/menu.svg"), onPressed: () {}),
      actions: <Widget>[
        IconButton(
            icon: SvgPicture.asset("assets/icons/search.svg"), onPressed: () {})
      ],
    );
  }
}

class PreventionCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  const PreventionCard({
    Key key,
    this.svgSrc,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(svgSrc),
        Text(
          title,
          textAlign: TextAlign.center,
          style:
              Theme.of(context).textTheme.body2.copyWith(color: kPrimaryColor),
        )
      ],
    );
  }
}
