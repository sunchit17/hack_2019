import 'package:flutter/material.dart';
import './api.dart';
import './repo.dart';
import './item.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import './search.dart';
import './color_loader_4.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Repo> _repos = List();
  bool _isFetching = false;
  String _error;

  @override
  void initState() {
    super.initState();
    loadTrendingRepos();
  }

  void loadTrendingRepos() async {
    setState(() {
      _isFetching = true;
      _error = null;
    });

    final repos = await Api.getTrendingRepositories();
    setState(() {
      _isFetching = false;
      if (repos != null) {
        this._repos = repos;
      } else {
        _error = 'Error fetching repos';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          LineAwesomeIcons.github,
          size: 40.0,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Container(
            margin: EdgeInsets.only(top: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Github',
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .apply(color: Colors.white)),
                Text('Recent Flutter Repos',
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .apply(color: Colors.white))
              ],
            )),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchList(),
                    ));
              }),
        ],
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    if (_isFetching) {
      return Container(
        alignment: Alignment.center,
        child: ColorLoader4(
          dotOneColor: Colors.black,
          dotTwoColor: Colors.black,
          dotThreeColor: Colors.black,
        ),
      );
    } else if (_error != null) {
      return Container(
          alignment: Alignment.center,
          child: Text(
            _error,
            style: Theme.of(context).textTheme.headline,
          ));
    } else {
      return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          itemCount: _repos.length,
          itemBuilder: (BuildContext context, int index) {
            return GithubItem(_repos[index]);
          });
    }
  }
}
