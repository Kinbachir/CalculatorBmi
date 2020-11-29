import 'package:calculatebmitest/Controller/BmiController.dart';
import 'package:calculatebmitest/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ResultatPage extends StatelessWidget {
  const ResultatPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ResultatPageView(),
    );
  }
}

class ResultatPageView extends StatefulWidget {
  ResultatPageView({Key key}) : super(key: key);

  @override
  _ResultatPageViewState createState() => _ResultatPageViewState();
}

class _ResultatPageViewState extends State<ResultatPageView> {
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final BmiController c = Get.put(BmiController());
    return Container(
      child: Scaffold(
        appBar: AppBar(
            title: Text("BMI FLUTTER CALCULATOR"),
            backgroundColor: Color.fromRGBO(30, 0, 50, 0.8)),
        backgroundColor: Color.fromRGBO(25, 0, 53, 0.8),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Your Resultat ${box.read("name")}",
                      style: souslines,
                    ),
                    Card(
                      color: Color.fromRGBO(30, 0, 50, 0.8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          paddingText(c.bmiResult(), headlines),
                          paddingText(c.bmi.toStringAsFixed(1), boldNumber),
                          paddingText('interpretation', souslines)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.offAllNamed("/mainPage");
              },
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                height: MediaQuery.of(context).size.height * 0.1,
                color: Colors.red,
                child: Center(
                  child: Text(
                    'RE-CALCULATE',
                    style: souslines,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  paddingText(String value, TextStyle styletext) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 30, 100, 30),
      child: Text(
        value,
        style: styletext,
      ),
    );
  }
}
