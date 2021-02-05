import 'package:flutter/material.dart';

class WatchTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding:
          const EdgeInsets.only(top: 60.0, left: 10.0, bottom: 10.0),
          child: Text(
            'Please Watch this Tutorial How to use our App to start Earring Money',
            style: Theme.of(context).textTheme.headline1,
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
                border:
                Border.all(color: Theme.of(context).primaryColorDark),
                color: Theme.of(context).accentColor,
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
      ],
    );
  }
}
