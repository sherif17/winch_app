import 'package:flutter/material.dart';

class FileUpload extends StatelessWidget {
  static String routeName = '/fileUpload';

  String title = 'Stepper';
  int _currentstep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
        child: Stepper(
          steps: _stepper(),
          physics: ClampingScrollPhysics(),
          currentStep: this._currentstep,
          onStepTapped: (step) {
            setState(() {
              _currentstep = step;
            });
          },
          onStepContinue: () {
            setState(() {
              if (this._currentstep < _stepper().length - 1) {
                this._currentstep = this._currentstep + 1;
              } else {
                print('complete');
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (this._currentstep > 0) {
                this._currentstep = this._currentstep - 1;
              } else {
                this._currentstep = 0;
              }
            });
          },
          type: StepperType.horizontal,
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
            style: TextStyle(color: Colors.blue, fontSize: 10.0, fontWeight: FontWeight.bold),
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
                      child: Text('if you have an office which\nown a group of winches',
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
                      child: Text('if you have any questions\nyou can contact us her',
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
          style: TextStyle(color: Colors.blue, fontSize: 10.0, fontWeight: FontWeight.bold),
        ),
        content: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 40.0,
                left: 10.0,
              ),
              child: Container(
                width: 380.0,
                height: 60.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 90.0, top: 10.0),
                      child: Container(
                        width: 150.0,
                        height: 30,
                        child: Text('Personal Photo',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0, left: 40.0),
                      child: Container(
                        width: 40.0,
                        height: 10.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_right,
                          ),
                          iconSize: 30,
                          color: Colors.blue,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 10.0,
              ),
              child: Container(
                width: 380.0,
                height: 60.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 90.0,
                      ),
                      child: Container(
                        width: 150.0,
                        height: 30,
                        child: Text('Driver License',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0, left: 40.0),
                      child: Container(
                        width: 40.0,
                        height: 10.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_right,
                          ),
                          iconSize: 30,
                          color: Colors.blue,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 10.0,
              ),
              child: Container(
                width: 380.0,
                height: 60.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 90.0,
                        top: 10.0,
                      ),
                      child: Container(
                        width: 150.0,
                        height: 30,
                        child: Text('Winch License:Front',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16.0,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0, left: 40.0),
                      child: Container(
                        width: 40.0,
                        height: 10.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_right,
                          ),
                          iconSize: 30,
                          color: Colors.blue,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 10.0,
              ),
              child: Container(
                width: 380.0,
                height: 60.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 90.0, top: 10.0),
                      child: Container(
                        width: 150.0,
                        height: 30,
                        child: Text('Winch License:Back',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16.0,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0, left: 40.0),
                      child: Container(
                        width: 40.0,
                        height: 10.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_right,
                          ),
                          iconSize: 30,
                          color: Colors.blue,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 10.0,
              ),
              child: Container(
                width: 380.0,
                height: 60.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 90.0, top: 10.0),
                      child: Container(
                        width: 150.0,
                        height: 30,
                        child: Text('Criminal Record',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0, left: 40.0),
                      child: Container(
                        width: 40.0,
                        height: 10.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_right,
                          ),
                          iconSize: 30,
                          color: Colors.blue,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 10.0,
              ),
              child: Container(
                width: 380.0,
                height: 60.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 90.0, top: 10.0),
                      child: Container(
                        width: 150.0,
                        height: 30,
                        child: Text('Drugs Analysis',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0, left: 40.0),
                      child: Container(
                        width: 40.0,
                        height: 10.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_right,
                          ),
                          iconSize: 30,
                          color: Colors.blue,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 10.0,
              ),
              child: Container(
                width: 380.0,
                height: 60.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 90.0, top: 10.0),
                      child: Container(
                        width: 150.0,
                        height: 30,
                        child: Text('Winch Check Report',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16.0,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0, left: 40.0),
                      child: Container(
                        width: 40.0,
                        height: 10.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_right,
                          ),
                          iconSize: 30,
                          color: Colors.blue,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 40.0,
                left: 10.0,
              ),
              child: FlatButton(
                onPressed: () {
                  /*...*/
                },
                child: Text(
                  "Next->",
                  style: TextStyle(fontSize: 30.0),
                ),
                color: Colors.blue,
                textColor: Colors.white,
                height: 55.0,
                minWidth: 390.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.blue)),
              ),
            ),
          ],
        ),
        isActive: _currentstep >= 2,
        state: StepState.indexed,
      ),
      Step(
        title: Text(""),
        subtitle: Text("Confirmation Code",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 10.0)),
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
                padding: const EdgeInsets.only(top: 60.0, left: 10.0, bottom: 10.0),
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
}
