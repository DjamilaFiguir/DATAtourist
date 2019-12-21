import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SelectionModal extends StatefulWidget {
  @override
  _SelectionModalState createState() => _SelectionModalState();

  final List dataSource;
  final List values;
  final bool filterable;
  final String titleText;
  final String textField;
  final String valueField;
  final FirebaseUser user;
  SelectionModal(
      {this.titleText,
      this.filterable,
      this.dataSource,
      this.values,
      this.textField,
      this.valueField,
      @required this.user})
      : super();
}

class _SelectionModalState extends State<SelectionModal> {
  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  bool _isSearching;
  List _localDataSourceWithState = [];
  List _searchresult = [];
  var selectedValues;

  _SelectionModalState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
        });
      } else {
        setState(() {
          _isSearching = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    selectedValues = [];

    widget.dataSource.forEach((item) {
      var newItem = {
        'value': item[widget.valueField],
        'text': item[widget.textField],
        'checked': widget.values.contains(item[widget.valueField])
      };
      _localDataSourceWithState.add(newItem);
    });

    _searchresult = List.from(_localDataSourceWithState);
    _isSearching = false;
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: Container(),
      elevation: 1.5,
      title: Text(
        widget.titleText,
        style: TextStyle(fontSize: 20),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.close,
            size: 25.0,
          ),
          onPressed: () {
            Navigator.pop(context, null);
          },
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          widget.filterable ? _buildSearchText() : new SizedBox(),
          Expanded(
            child: _optionsList(),
          ),
          _currentlySelectedOptions(),
          Container(
            color: Color.fromARGB(120, 30, 110, 160),
            child: ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ButtonTheme(
                    height: 50.0,
                    child: RaisedButton.icon(
                      label: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color.fromARGB(255, 30, 110, 160),
                          fontSize: 20
                        ),
                      ),
                      icon: Icon(
                        Icons.cancel,
                        size: 25.0,
                        color: Color.fromARGB(255, 30, 110, 160),
                      ),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context, null);
                      },
                    ),
                  ),
                  ButtonTheme(
                    height: 50.0,
                    child: RaisedButton.icon(
                      label: Text('Save',style: TextStyle(fontSize: 20),),
                      icon: Icon(
                        Icons.add_box,
                        size: 25.0,
                      ),
                      color: Color.fromARGB(255, 30, 110, 160),
                      textColor: Colors.white,
                      onPressed: () {
                        var selectedValuesObjectList = _localDataSourceWithState
                            .where((item) => item['checked'])
                            .toList();
                        selectedValuesObjectList.forEach((item) {
                          selectedValues.add(item['value']);
                        }); // widget.titleText,
                        addPreferenceType(selectedValues, widget.titleText);
                        Navigator.pop(context, selectedValues);
                      },
                    ),
                  )
                ]),
          )
        ],
      ),
    );
  }

  Map<String, dynamic> preferenceType = new Map<String, dynamic>();
  void addPreferenceType(dynamic value, String champ) async {
    preferenceType[champ] = value;
    try {
      DocumentReference currentUid = Firestore.instance
          .collection("Preference")
          .document('${widget.user.uid}');
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(currentUid, preferenceType);
      });
    } catch (e) {
      print(e.message);
    }
  }

  Widget _currentlySelectedOptions() {
    List<Widget> selectedOptions = [];

    var selectedValuesObjectList =
        _localDataSourceWithState.where((item) => item['checked']).toList();
    var selectedValues = [];
    selectedValuesObjectList.forEach((item) {
      selectedValues.add(item['value']);
    });
    selectedValues.forEach((item) {
      var existingItem = _localDataSourceWithState
          .singleWhere((itm) => itm['value'] == item, orElse: () => null);

      selectedOptions.add(Chip(
        label: Text(existingItem['text'], overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20),),
        deleteButtonTooltipMessage: 'Tap to delete this item',
        deleteIcon: Icon(Icons.cancel),
        deleteIconColor: Color.fromARGB(150, 30, 110, 160),
        onDeleted: () {
          existingItem['checked'] = false;
          setState(() {});
        },
      ));
    });
    return selectedOptions.length > 0
        ? Container(
            padding: EdgeInsets.all(10.0),
            color: Color.fromARGB(150, 30, 110, 160),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Text(
                  'Currently selected items (tap to remove)',
                  style: TextStyle(
                    fontSize: 18,
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 0.4, // gap between lines
                  alignment: WrapAlignment.start,
                  children: selectedOptions,
                ),
              ],
            ),
          )
        : new Container();
  }

  ListView _optionsList() {
    List<Widget> options = [];
    _searchresult.forEach((item) {
      options.add(ListTile(
          title: Text(
            item['text'],
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          leading: Transform.scale(
            child: Icon(
              item['checked'] ? Icons.check_box : Icons.check_box_outline_blank,
              color: Color.fromARGB(255, 30, 110, 160),
              size: 25,
            ),
            scale: 1,
          ),
          onTap: () {
            item['checked'] = !item['checked'];
            setState(() {});
          }));
      options.add(new Divider(height: 0));
    });
    return ListView(children: options);
  }

  Widget _buildSearchText() {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: TextField(
              controller: _controller,
              onChanged: searchOperation,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(6.0),
                    ),
                  ),
                  filled: true,
                  hintText: "Search...",
                  fillColor: Colors.white,
                  suffix: SizedBox(
                      height: 25.0,
                      child: IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Color.fromARGB(255, 30, 110, 160),
                        ),
                        onPressed: () {
                          _controller.clear();
                          searchOperation('');
                        },
                        padding: EdgeInsets.all(0.0),
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: globalKey,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  void searchOperation(String searchText) {
    _searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _localDataSourceWithState.length; i++) {
        String data =
            '${_localDataSourceWithState[i]['value']} ${_localDataSourceWithState[i]['text']}';
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          _searchresult.add(_localDataSourceWithState[i]);
        }
      }
    }
  }
}
