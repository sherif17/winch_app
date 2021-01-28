import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:winch_app/screens/login_screens/file_upload/confirmationcode.dart';
import 'package:winch_app/widgets/rounded_button.dart';

class StepperBody extends StatefulWidget {
  @override
  _StepperBodyState createState() => _StepperBodyState();
}

class _StepperBodyState extends State<StepperBody> {
  String title = 'Stepper';
  int _currentstep = 0;
  /*List<Item> _data = generateItems(10);

  Widget _BuildListPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
            headerBuilder: (BuildContext, bool isExpanded) {
              return ListTile(
                title: Text("sherif"),
              );
            },
            body: ListTile(
              title: Text(item.expandedValue),
              trailing: Icon(Icons.keyboard_arrow_down_rounded),
              subtitle: Text("hi hi"),
              onTap: () {
                setState(() {});
              },
            ),
            isExpanded: item.isExpanded);
      }).toList(),
      dividerColor: Colors.indigo,
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 5),
        child: Column(
          children: [
            Expanded(
              flex: 17,
              child: Container(
                child: Stepper(
                  steps: _stepper(),
                  type: StepperType.horizontal,
                  //  physics: ClampingScrollPhysics(),
                  currentStep: this._currentstep,
                  onStepTapped: (step) {
                    setState(() {
                      _currentstep = step;
                    });
                  },
                  controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) {
                    return Row(
                      children: <Widget>[
                        Container(
                          child: null,
                        ),
                        Container(
                          child: null,
                        ),
                      ],
                    );
                  },
                  /* onStepContinue: () {
                    setState(() {
                      if (this._currentstep < _stepper().length - 1) {
                        this._currentstep = this._currentstep + 1;
                      } else {
                        print('complete');
                      }
                    });
                  },*/
                  /* onStepCancel: () {
                    setState(() {
                      if (this._currentstep > 0) {
                        this._currentstep = this._currentstep - 1;
                      } else {
                        this._currentstep = 0;
                      }
                    });
                  },*/
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: RoundedButton(
                text: "Next",
                color: Colors.indigoAccent,
                textColor: Colors.white,
                press: () {
                  setState(() {
                    if (this._currentstep < _stepper().length - 1) {
                      this._currentstep = this._currentstep + 1;
                    } else {
                      print('complete');
                    }
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Step> _stepper() {
    List<Step> _steps = [
      Step(
        title: Text(""),
        subtitle: Center(
          child: Text(
            "CaptionType",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 10.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        content: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 40.0,
                right: 5.0,
              ),
              child: Text(
                'Please Choose The Way you\nwant to join us :',
                style: TextStyle(
                  fontSize: 29.0,
                  color: Colors.blue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                width: 380.0,
                height: 150.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        right: 120.0,
                        bottom: 10.0,
                      ),
                      child: Text('Join us as individual',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 28.0,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 10.0,
                        right: 140.0,
                      ),
                      child: Text('if you have your own\npersonal winch',
                          style: TextStyle(
                            color: Colors.blue.withOpacity(0.3),
                            fontSize: 25.0,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: 380.0,
                height: 150.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        right: 110.0,
                        bottom: 10.0,
                      ),
                      child: Text('Join us as office work',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 27.0,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 10.0,
                        right: 130.0,
                      ),
                      child: Text(
                          'if you have an office which\nown a group of winches',
                          style: TextStyle(
                            color: Colors.blue.withOpacity(0.3),
                            fontSize: 20.0,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: 380.0,
                height: 150.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        right: 190.0,
                        bottom: 10.0,
                      ),
                      child: Text('Help Request',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 28.0,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 10.0,
                        right: 130.0,
                      ),
                      child: Text(
                          'if you have any questions\nyou can contact us her',
                          style: TextStyle(
                            color: Colors.blue.withOpacity(0.3),
                            fontSize: 21.0,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        isActive: true,
        state: StepState.indexed,
      ),
      Step(
        title: Text(""),
        subtitle: Text(
          "Required Files",
          style: TextStyle(
              color: Colors.blue, fontSize: 10.0, fontWeight: FontWeight.bold),
        ),
        content: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                  //_BuildListPanel(),
                  child: Column(
                children: [
                  BuildFileUpload('Personal Photo', "Please upload clear photo",
                      "assets/icons/profile.png", true),
                  BuildFileUpload(
                      'Driver License',
                      "Please upload your licence ",
                      "assets/icons/profile.png",
                      true),
                  BuildFileUpload(
                      'Winch License : Front',
                      "upload your winch licence,front image",
                      "assets/icons/profile.png",
                      true),
                  BuildFileUpload(
                      'Winch License : Back ',
                      "upload your winch licence,back image",
                      "assets/icons/profile.png",
                      true),
                  BuildFileUpload(
                      'Criminal Record',
                      "upload Criminal record about you",
                      "assets/icons/profile.png",
                      true),
                  BuildFileUpload(
                      'Drugs Analysis',
                      "upload Drug analysis report form X Laboratory",
                      "assets/icons/profile.png",
                      true),
                  BuildFileUpload(
                      'Winch Check Report',
                      "upload your winch check Report,from X Center",
                      "assets/icons/profile.png",
                      true)
                ],
              )),
            ),
          ],
        ),
        isActive: _currentstep >= 2,
        state: StepState.indexed,
      ),
      Step(
        title: Text(""),
        subtitle: Text("Confirmation Code",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 10.0)),
        content: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 80.0,
                left: 10.0,
                bottom: 20.0,
              ),
              child: Text(
                'Please Enter Your Confirmation Code\nProvided by the administration',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.blue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.5),
              child: Text(
                'These process of confirmation may take\nfrom 1 to 3 weeks to check your files',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue.withOpacity(0.4),
                ),
              ),
            ),
            confirmationcode(),
            Padding(
              padding: const EdgeInsets.only(
                top: 100.0,
                left: 10.0,
              ),
              child: FlatButton(
                onPressed: () {
                  /*...*/
                },
                child: Text(
                  "Confirm ->",
                  style: TextStyle(fontSize: 25),
                ),
                color: Colors.blue,
                textColor: Colors.white,
                height: 55.0,
                minWidth: 390.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.blue)),
              ),
            )
          ],
        ),
        isActive: _currentstep >= 3,
        state: StepState.indexed,
      ),
      Step(
          title: Text(""),
          subtitle: Text(
            "Get Started",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 6.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(top: 60.0, left: 10.0, bottom: 10.0),
                child: Text(
                  'Please Watch this Tutorial How to\nuse our App to start Earring Money',
                  style: TextStyle(
                    fontSize: 23.0,
                    color: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 50.0,
                  left: 10.0,
                ),
                child: Container(
                  height: 250.0,
                  width: 380.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0, top: 20.0),
                    child: Container(
                      child: FlatButton(
                        onPressed: () {
                          /*...*/
                        },
                        child: Image.asset('assets/new.png'),
                        height: 60.0,
                        minWidth: 60.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 140.0, left: 10.0),
                child: FlatButton(
                  onPressed: () {
                    /*...*/
                  },
                  child: Text(
                    "Get started",
                    style: TextStyle(fontSize: 20),
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
                  height: 45.0,
                  minWidth: 360.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.blue)),
                ),
              ),
            ],
          ),
          isActive: _currentstep >= 4,
          state: StepState.indexed),
    ];
    return _steps;
  }

  Card BuildFileUpload(title, content, imgSrc, isExpanded) {
    bool x = false;
    return Card(
      elevation: 0,
      semanticContainer: true,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.indigo),
          gapPadding: 100),
      borderOnForeground: true,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.01,
      ),
      child: ExpansionTile(
        title: Text(title, style: Theme.of(context).textTheme.headline2),
        backgroundColor: Colors.white,
        //trailing: Icon(x ? Icons.copyright_rounded : Icons.height),
        children: [
          Container(
            color: Colors.indigo[100],
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.04),
                            child: Text(
                              content,
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent, fontSize: 17),
                            ))),
                    Expanded(
                        flex: 1,
                        child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Image.asset(imgSrc)))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.25),
                  child: FlatButton(
                    height: MediaQuery.of(context).size.height *
                        0.05, //minWidth: MediaQuery.of(context).size.width * 0.05,
                    color: Colors.indigo,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Upload"),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03),
                        SvgPicture.asset(
                          "assets/icons/upload-cloud.svg",
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width * 0.035,
                          height: MediaQuery.of(context).size.height * 0.03,
                        )
                      ],
                    ),
                    onPressed: () {
                      x = true;
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  String expandedValue;
  String headerValue;
  bool isExpanded;
  Item({this.expandedValue, this.headerValue, this.isExpanded = false});
}

List<Item> generateItems(int numOfItems) {
  return List.generate(numOfItems, (index) {
    return Item(
      headerValue: "Panel $index",
      expandedValue: "this is item number $index",
    );
  });
}