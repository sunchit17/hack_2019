import 'package:flutter/material.dart';
import './repo.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubItem extends StatefulWidget {
  final Repo repo;

  GithubItem(this.repo);

  @override
  _GithubItemState createState() => _GithubItemState();
}

class _GithubItemState extends State<GithubItem> {
   bool _saved = true;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          onTap: () {
            _launchURL(widget.repo.htmlUrl);
          },
          highlightColor: Colors.grey,
          splashColor: Colors.black,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        (widget.repo.name != null) ? widget.repo.name : '-',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        child: Icon(
                        _saved ? Icons.bookmark_border : Icons.bookmark,
                        ),
                        onTap: ()
                        {
                          setState(() {
                            if(_saved==true)
                              _saved=false;
                            else
                              _saved=true;
                          });
                        },
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.0),
                    child: Text(
                      widget.repo.description != null
                          ? widget.repo.description
                          : 'No desription',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Raleway',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                child: Image.network(widget.repo.avatarUrl),
                                radius: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  (widget.repo.owner != null)
                                      ? widget.repo.owner
                                      : '',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Colors.black,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4.0),
                                child: Text(
                                  (widget.repo.watchersCount != null)
                                      ? '${widget.repo.watchersCount} '
                                      : '0 ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            (widget.repo.language != null)
                                ? widget.repo.language
                                : '',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          )),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
