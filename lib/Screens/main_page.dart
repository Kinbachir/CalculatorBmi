import 'package:calculatebmitest/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MainPageView(),
    );
  }
}

class MainPageView extends StatefulWidget {
  MainPageView({Key key}) : super(key: key);

  @override
  _MainPageViewState createState() => _MainPageViewState();
}

GetStorage box = GetStorage();

class _MainPageViewState extends State<MainPageView> {
  double height = box.read("height");
  var minHeight = 100.0;
  var maxHeight = 300.0;
  final TextEditingController nomControllee = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BMI FLUTTER CALCULATOR"),
          backgroundColor: Color.fromRGBO(30, 0, 50, 0.8),
        ),
        backgroundColor: Color.fromRGBO(25, 0, 35, 0.8),
        body: ListView(
          children: [
            TextFormField(
              controller: nomControllee,
              style: souslines,
              validator: (value) {
                if (fullNameValidate(value)) {
                  return 'Please verify your name';
                }
                return null;
              },
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                labelText: "Enter Name",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                genre(context, "male"),
                genre(context, "female"),
              ],
            ),
            //widget du height
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(10.0),
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color.fromRGBO(30, 0, 50, 0.8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'HEIGHT',
                      style: souslines,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("$height",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 50.0)),
                    ),
                    Slider(
                        value: height,
                        min: minHeight,
                        max: maxHeight,
                        activeColor: Colors.red,
                        inactiveColor: Colors.black,
                        onChanged: (double newValue) {
                          setState(() {
                            height = newValue.round().toDouble();
                            box.write("height", height);
                          });
                        },
                        semanticFormatterCallback: (double newValue) {
                          return '$newValue.round()';
                        })
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                plusMoinsValue(context, "Weight"),
                plusMoinsValue(context, "Age"),
              ],
            ),
            Container(
              child: RaisedButton(
                onPressed: () {
                  box.write("name", nomControllee.text);
                  fullNameValidate(box.read("name"))
                      ? Get.toNamed("/resultatPage")
                      : Get.snackbar(
                          "wrong ",
                          "Please verify your name",
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                        );
                },
                color: Colors.red,
                child: Text(
                  "BMI CALCULATE",
                  style: souslines,
                ),
              ),
            )
          ],
        ));
  }

  //widget du age / weight
  plusMoinsValue(BuildContext context, String value) {
    int valeur;
    return Expanded(
      flex: 1,
      child: Container(
        color: Color.fromRGBO(30, 0, 50, 0.8),
        margin: EdgeInsets.all(10.0),
        height: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              value,
              style: souslines,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${box.read(value)}',
                style: souslines,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      valeur = box.read(value);
                      valeur--;
                      if (valeur.isNegative || valeur == 0) valeur = 1;
                      box.write(
                        value,
                        valeur,
                      );
                    });
                  },
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.red),
                    child: Center(
                      child: Text(
                        "-",
                        style: buttonStylePlusMoins,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40.0,
                  width: 40.0,
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.red),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        valeur = box.read(value);
                        valeur++;
                        box.write(
                          value,
                          valeur,
                        );
                      });
                    },
                    child: Center(
                      child: Text(
                        "+",
                        style: buttonStylePlusMoins,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  //widget du genre
  genre(BuildContext context, String imageName) {
    return Expanded(
        flex: 1,
        child: Container(
          margin: EdgeInsets.all(10.0),
          height: MediaQuery.of(context).size.height * 0.25,
          child: RaisedButton(
            onPressed: () {
              box.write("genre", imageName);
            },
            color: Color.fromRGBO(30, 0, 50, 0.8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/$imageName' + '.png',
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  imageName.toUpperCase(),
                  style: souslines,
                )
              ],
            ),
          ),
        ));
  }

  //function validate name
  bool fullNameValidate(String fullName) {
    String patttern = r'^[a-z A-Z]+$';
    RegExp regExp = new RegExp(patttern);
    if (!regExp.hasMatch(fullName)) {
      return false;
    }
    return true;
  }
}
