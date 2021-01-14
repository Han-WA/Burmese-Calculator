import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  Map<String, dynamic> myanToeng = {
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
  }; //Assign String burmese to eng value

  List<dynamic> engStored =
      new List<dynamic>(); // Store button press Eng value for calculation
  List<dynamic> myanStored = new List<dynamic>(); // Show Burmese Number for UI

  List<String> operators = []; // Store Operation
  List<String> calculatenumber = []; // List while calculation
  String currentnumber = '';
  double result = 0;
  int global_index = 0;

  Map<dynamic, String> myanNumbers = {
    '0': "၀",
    '1': "၁",
    '2': "၂",
    '3': "၃",
    '4': "၄",
    '5': "၅",
    '6': "၆",
    '7': "၇",
    '8': "၈",
    '9': "၉",
    ".": ".",
    "-": "-",
  }; //this map is used to assign string eng to string myanmar for the result

  void clearNumber() {
    setState(() {
      engStored.clear();
      myanStored.clear();
      operators.clear();
      calculatenumber.clear();
      result = 0;
      currentnumber = '';
      global_index = 0;
    });
  } // Clearing pressed button number

  void removeNumber() {
    if (myanStored.length != 0) {
      setState(() {
        //TODO: Need to fix about decimal value, removing means entirly removing 1.2 not 2 only and left with 1.
        engStored.clear();
        myanStored.removeLast();
      });
    }
  } // Removing Last Number for Delete button

  void calculation() {
    for (int c = global_index; c < operators.length; c++) {
      if (operators[c] == "+") {
        setState(() {
          result = double.parse(calculatenumber[c]) +
              double.parse(calculatenumber[c + 1]);
          calculatenumber[c + 1] = result.toString(); //
          //currentnumber = result.toString();
          global_index = c + 1;
        });
      } else if (operators[c] == "-") {
        setState(() {
          result = double.parse(calculatenumber[c]) -
              double.parse(calculatenumber[c + 1]);
          calculatenumber[c + 1] = result.toString();
          global_index = c + 1;
          //currentnumber = result.toString();
        });
      } else if (operators[c] == "x") {
        setState(() {
          result = double.parse(calculatenumber[c]) *
              double.parse(calculatenumber[c + 1]);
          calculatenumber[c + 1] = result.toString();
          global_index = c + 1;
          //currentnumber = result.toString();
        });
      } else if (operators[c] == "/") {
        setState(() {
          result = double.parse(calculatenumber[c]) /
              double.parse(calculatenumber[c + 1]);
          calculatenumber[c + 1] = result.toString();
          global_index = c + 1;
          //currentnumber = result.toString();
        });
      }
    }

    print(calculatenumber);
    setState(() {
      myanStored.clear(); //clear everything on display
      engStored.clear(); // required to remove the old numbers  
    });

    //The code below extract every single character from a sequence of characters of
    //a string, convert them to single character code, map to respective burmese digits
    //and add it to the display( myanStored)
    result.toString().runes.forEach((int rune) {
      var character = new String.fromCharCode(rune);
      myanStored.add(myanNumbers[character]);
    });
  }

  void buttonClick(String key) {
    if (key == 'အစ') {
      clearNumber();
    } else if (key == "=") {
      for (int i = 0; i < engStored.length; i++) {
        if (i == 0 &&
            (engStored[i] == "+" ||
                engStored[i] == "-" ||
                engStored[i] == "x" ||
                engStored[i] == "/")) {
          print('operator is the first input');
          operators.add(engStored[i]);
        } else if (engStored[i] == "+" ||
            engStored[i] == "-" ||
            engStored[i] == "x" ||
            engStored[i] == "/") {
          setState(() {
            operators.add(engStored[i]); // Adding +-*/ to operators list
            if (currentnumber != null) {
              print("Current Number is $currentnumber");
              // In case calcuatenumber holds the previous operated result
              calculatenumber.add(
                  currentnumber); // Adding currentnumber variable with number to calculatenumber
              currentnumber = "";
            }
          });
        } else {
          currentnumber += engStored[i]
              .toString(); // Adding numbers to currentnumber variable
        }
      }

      //The last remaining number to be put into calculatenumber list.
      if (currentnumber != '') {
        setState(() {
          calculatenumber.add(currentnumber);
          currentnumber = ''; // required to clear the old number
        });
      }
      calculation(); // Calculation all the function
    } else {
      //This is for adding user inputs into the engstored list and mapping respective
      // into the myanstored for display ( operators and + included)
      setState(() {
        engStored.add(myanToeng[key]);
        myanStored.add(key);
      });
    }
  }

  Widget commonOutlineButton(String number) {
    return Expanded(
      child: OutlineButton(
        onPressed: () {
          print('Pressed $number');
          buttonClick(number);
        },
        splashColor: Colors.greenAccent,
        padding: EdgeInsets.all(25),
        child: Text(
          number,
          style: TextStyle(
            color: Colors.greenAccent,
            fontFamily: "Tagu",
            fontWeight: FontWeight.w300,
            fontSize: 25,
          ),
        ),
      ),
    );
  } // Method for Button widget

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
                  children: myanStored
                      .map(
                        (e) => Text(
                          e.toString(),
                          style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontFamily: 'Tagu',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ), //Calculation Result Number
            Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: removeNumber,
                  icon: Icon(
                    Icons
                        .add_circle, //the original Icons was not running on my machine
                    size: 40,
                    color: Colors.deepOrangeAccent,
                  ),
                )), // Delete Icon & Remove Function
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
