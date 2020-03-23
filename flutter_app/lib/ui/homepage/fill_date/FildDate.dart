import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';

import '../HomePageViewModel.dart';

class FillDate extends StatefulWidget {
  var title, fromDate, toDate;
  HomePageViewModel _viewModel;

  @override
  _FillDateState createState() => _FillDateState();

  FillDate(this._viewModel, {this.title, this.fromDate, this.toDate});
}

class _FillDateState extends State<FillDate> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        width: Common.widthOfScreen - 100,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.title,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${widget.fromDate}   -   ${widget.toDate}",
                        style: TextStyle(fontSize: 13),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.date_range,
              color: Colors.grey[400],
            )
          ],
        ),
      ),
    );
  }
}
