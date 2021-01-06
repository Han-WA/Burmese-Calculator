import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  Map<String, dynamic> calNumbers = {
    "၀": 0,
    "၁": 1,
    "၂": 2,
    "၃": 3,
    "၄": 4,
    "၅": 5,
    "၆": 6,
    "၇": 7,
    "၈": 8,
    "၉": 9,
    "အစ": "Start Over",
    "+": "+",
    "-": "-",
    "x": "x",
    "/": "/",
    "=": "=",
  };

  List<dynamic> NumStore = new List<dynamic>(); // Eng word for calculation

  List<dynamic> KeyStore = new List<dynamic>(); // Myanmar word for UI

  void removeNumStore() {
    setState(() {
      NumStore.clear();
      KeyStore.clear();
    });
  }

  void deleteNum() {
    if (NumStore.isNotEmpty) {
      setState(() {
        NumStore.removeLast();
        KeyStore.removeLast();
      });
    }
  }

  void buttonClick(String key) {
    if (key == 'အစ') {
      removeNumStore();
    } else if (key == "=") {
      String operator;
      String result;

      for (int j = 0; j < NumStore.length; j++) {
        String numstring = NumStore.join("");
        List numlist = numstring.split("+", "-", "x", "/");

        setState(() {});
      }
    } else {
      setState(() {
        NumStore.add(calNumbers[key]);
        KeyStore.add(key);
      });
    }
  }

  Widget commonOutlineButton(String number) {
    return Expanded(
      child: OutlineButton(
        splashColor: Colors.greenAccent,
        onPressed: () => buttonClick(number),
        padding: EdgeInsets.all(25),
        child: Text(
          number,
          style: TextStyle(
            color: Colors.greenAccent,
            fontFamily: 'Tagu',
            fontWeight: FontWeight.w300,
            fontSize: 25,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "မြန်မာဂဏန်းတွက်စက်",
          style: TextStyle(
            fontFamily: 'Waso',
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.all(10),
                child: Wrap(
                  children: KeyStore.map(
                    (e) => Text(
                      e.toString(),
                      style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontFamily: 'Tagu',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ).toList(),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: deleteNum,
                icon: Icon(
                  Icons.backspace_rounded,
                  size: 40,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    commonOutlineButton('၇'),
                    commonOutlineButton('၈'),
                    commonOutlineButton('၉'),
                    commonOutlineButton('+'),
                  ],
                ),
                Row(
                  children: [
                    commonOutlineButton('၄'),
                    commonOutlineButton('၅'),
                    commonOutlineButton('၆'),
                    commonOutlineButton('-'),
                  ],
                ),
                Row(
                  children: [
                    commonOutlineButton('၁'),
                    commonOutlineButton('၂'),
                    commonOutlineButton('၃'),
                    commonOutlineButton('x'),
                  ],
                ),
                Row(
                  children: [
                    commonOutlineButton('အစ'),
                    commonOutlineButton('၀'),
                    commonOutlineButton('='),
                    commonOutlineButton('/'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
