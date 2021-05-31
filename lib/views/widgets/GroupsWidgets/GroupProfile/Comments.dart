import 'package:flutter/material.dart';
import 'package:iti_community_flutter/app_localizations.dart';
import 'package:iti_community_flutter/services/GroupsService.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:iti_community_flutter/views/pages/profile/profile.dart';
import 'package:provider/provider.dart';

class Comments extends StatefulWidget {
  final String id;
  final data;
  final String pID;
  final user;
  final uRole;
  Comments(this.id, this.pID, this.data, this.uRole, this.user);
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final controlCommentBody = TextEditingController();
    void handleClick(String value) {
      switch (value) {
        case 'Edit':
          controlCommentBody.text = widget.data['Body'];
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  insetPadding: EdgeInsets.zero,
                  content: Stack(
                    children: <Widget>[
                      Positioned(
                        // right: -40.0,
                        top: -40.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close),
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 280,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('EditingComment'),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[450],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 200,
                                        child: TextFormField(
                                          maxLines: null,
                                          keyboardType: TextInputType.multiline,
                                          decoration: InputDecoration.collapsed(
                                              hintText: AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      'TypeYourEditCommentHere')),
                                          // ignore: missing_return
                                          validator: (value) {
                                            value.isEmpty;
                                            // ignore: unnecessary_statements
                                            value.length > 3;
                                          },
                                          controller: controlCommentBody,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Material(
                                        color: Colors.blue[400],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        child: InkWell(
                                          highlightColor: Colors.blue[100],
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.edit),
                                                Text(
                                                  AppLocalizations.of(context)
                                                      .translate('EditComment'),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            final String body =
                                                controlCommentBody.text;
                                            if (body != null ||
                                                body.length > 3) {
                                              GroupService.editComment(
                                                  widget.pID, widget.id, body);
                                              Navigator.of(context).pop();
                                            }
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
          break;
        case 'Delete':
          GroupService.deleteComment(widget.pID, widget.id);
          break;
      }
    }

    final authServices = Provider.of<AuthServices>(context);
    final userid = authServices.storage.getItem('uid');

    return Column(children: [
      Card(
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
            // boxShadow: [
            //   BoxShadow(
            //       color: Colors.black54, spreadRadius: 100, blurRadius: 100),
            // ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      minVerticalPadding: 0,
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: 50,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.data['User']['avatar']),
                            radius: 35,
                          ),
                        ),
                      ),
                      title: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Profile(widget.data['User']['id'])));
                        },
                        child: Row(
                          children: [
                            Text(
                              widget.data['User']['firstName'],
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              widget.data['User']['lastName'],
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ),
                      subtitle: Text(
                        widget.data['User']['jobTitle'],
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6), fontSize: 12),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                    ),
                  ),
                  if (userid == widget.data['User']['id'] ||
                      widget.user['Role'] == 1)
                    PopupMenuButton<String>(
                      onSelected: handleClick,
                      itemBuilder: (BuildContext context) {
                        return {'Edit', 'Delete'}.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(
                                AppLocalizations.of(context).translate(choice)),
                          );
                        }).toList();
                      },
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data['Body'],
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6), fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
