import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class singelJob extends StatefulWidget {
  singelJob(this.jobData);
  final jobData;
  @override
  _singelJobState createState() => _singelJobState();
}

class _singelJobState extends State<singelJob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor("801818"),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 28,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 20,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: InkWell(
                              child: Icon(Icons.arrow_back),
                              onTap: () {
                                Navigator.pop(context);
                              }),
                        ),
                      ),
                      SizedBox(width: 20),
                      SizedBox(width: 20)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.jobData['companyLogoAvatar']),
                      radius: 50.0,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    (widget.jobData['company'] as Map)['en'],
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    (widget.jobData['company'] as Map)['ar'],
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 1,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Apply",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HexColor("801818"),
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Save",
                              style: TextStyle(color: HexColor("801818")),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                              color: HexColor("801818"),
                              width: 1,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: <Widget>[
                      Expanded(child: Divider()),
                      Text(
                        "Description",
                        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                      ),
                      Expanded(child: Divider()),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.jobData['description']['en']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: <Widget>[
                      Expanded(child: Divider()),
                      Text(
                        "EmploymentType",
                        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                      ),
                      Expanded(child: Divider()),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 1),
                        Text(widget.jobData['employmentType']['en']),
                        SizedBox(width: 1),
                        SizedBox(width: 1),
                        SizedBox(width: 1),
                        Text(widget.jobData['employmentType']['ar']),
                        SizedBox(width: 1)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: <Widget>[
                      Expanded(child: Divider()),
                      Text(
                        "Location",
                        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                      ),
                      Expanded(child: Divider()),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 1),
                        Text(widget.jobData['location']['en']),
                        SizedBox(width: 1),
                        SizedBox(width: 1),
                        SizedBox(width: 1),
                        Text(widget.jobData['location']['ar']),
                        SizedBox(width: 1)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: <Widget>[
                      Expanded(child: Divider()),
                      Text(
                        "Position",
                        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                      ),
                      Expanded(child: Divider()),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 1),
                        Text(widget.jobData['position']['en']),
                        SizedBox(width: 1),
                        SizedBox(width: 1),
                        SizedBox(width: 1),
                        Text(widget.jobData['position']['ar']),
                        SizedBox(width: 1)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: <Widget>[
                      Expanded(child: Divider()),
                      Text(
                        "SeniorityLevel",
                        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                      ),
                      Expanded(child: Divider()),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 1),
                        Text(widget.jobData['seniorityLevel']['en']),
                        SizedBox(width: 1),
                        SizedBox(width: 1),
                        SizedBox(width: 1),
                        Text(widget.jobData['seniorityLevel']['ar']),
                        SizedBox(width: 1)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: <Widget>[
                      Expanded(child: Divider()),
                      Text(
                        "WorksFrom",
                        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                      ),
                      Expanded(child: Divider()),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 1),
                        Text(widget.jobData['worksFrom']['en']),
                        SizedBox(width: 1),
                        SizedBox(width: 1),
                        SizedBox(width: 1),
                        Text(widget.jobData['worksFrom']['ar']),
                        SizedBox(width: 1)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
