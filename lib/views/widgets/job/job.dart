import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:provider/provider.dart';

class singelJob extends StatefulWidget {
  singelJob(this.jobData, this.jobId);
  final jobData;
  final jobId;
  @override
  _singelJobState createState() => _singelJobState();
}

class _singelJobState extends State<singelJob> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);

    authServices.getDataById(firebaseAuth.currentUser.uid);
    var userDetails = authServices.storage.getItem("clickedDetails");
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
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 20,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                        SizedBox(width: 20),
                        SizedBox(width: 20)
                      ],
                    ),
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
                        InkWell(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection('users-details')
                                .doc(firebaseAuth.currentUser.uid)
                                .collection('appliedJobs')
                                .doc(widget.jobId)
                                .set({
                              'closingDate': widget.jobData['closingDate'],
                              'company': {
                                'ar': widget.jobData['company']['ar'],
                                'en': widget.jobData['company']['en']
                              },
                              'companyLogoAvatar':
                                  widget.jobData['companyLogoAvatar'],
                              'description': {
                                'ar': widget.jobData['description']['ar'],
                                'en': widget.jobData['description']['en']
                              },
                              'employmentType': {
                                'ar': widget.jobData['employmentType']['ar'],
                                'en': widget.jobData['employmentType']['en']
                              },
                              'location': {
                                'ar': widget.jobData['location']['ar'],
                                'en': widget.jobData['location']['en']
                              },
                              'position': {
                                'ar': widget.jobData['position']['ar'],
                                'en': widget.jobData['position']['en']
                              },
                              'postedDate': widget.jobData['postedDate'],
                              'seniorityLevel': {
                                'ar': widget.jobData['seniorityLevel']['ar'],
                                'en': widget.jobData['seniorityLevel']['en']
                              },
                              'worksFrom': {
                                'ar': widget.jobData['worksFrom']['ar'],
                                'en': widget.jobData['worksFrom']['en']
                              }
                            });
                            FirebaseFirestore.instance
                                .collection('jobs')
                                .doc(widget.jobId)
                                .collection('appliedUsers')
                                .doc(firebaseAuth.currentUser.uid)
                                .set({
                              'about': userDetails['about'],
                              'avatar': userDetails['avatar'],
                              'avatarCover': userDetails['avatarCover'],
                              'branch': userDetails['branch'],
                              'experiences': userDetails['experiences'],
                              'firstName': userDetails['firstName'],
                              'jobTitle': userDetails['jobTitle'],
                              'lastName': userDetails['lastName'],
                              'nationalID': userDetails['nationalID'],
                              'scholarshipDuration':
                                  userDetails['scholarshipDuration'],
                              'track': userDetails['track']
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
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
                        ),
                        InkWell(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection('users-details')
                                .doc(firebaseAuth.currentUser.uid)
                                .collection('savedJobs')
                                .doc(widget.jobId)
                                .set({
                              'closingDate': widget.jobData['closingDate'],
                              'company': {
                                'ar': widget.jobData['company']['ar'],
                                'en': widget.jobData['company']['en']
                              },
                              'companyLogoAvatar':
                                  widget.jobData['companyLogoAvatar'],
                              'description': {
                                'ar': widget.jobData['description']['ar'],
                                'en': widget.jobData['description']['en']
                              },
                              'employmentType': {
                                'ar': widget.jobData['employmentType']['ar'],
                                'en': widget.jobData['employmentType']['en']
                              },
                              'location': {
                                'ar': widget.jobData['location']['ar'],
                                'en': widget.jobData['location']['en']
                              },
                              'position': {
                                'ar': widget.jobData['position']['ar'],
                                'en': widget.jobData['position']['en']
                              },
                              'postedDate': widget.jobData['postedDate'],
                              'seniorityLevel': {
                                'ar': widget.jobData['seniorityLevel']['ar'],
                                'en': widget.jobData['seniorityLevel']['en']
                              },
                              'worksFrom': {
                                'ar': widget.jobData['worksFrom']['ar'],
                                'en': widget.jobData['worksFrom']['en']
                              }
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
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
