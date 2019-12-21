library flutter_multiselect;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:integration_firbase/setup/selection_modal.dart';

class MultiSelect extends FormField<dynamic> {
  final FirebaseUser user;
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final dynamic value;
  final bool filterable;
  final bool enabeled;
  final List dataSource;
  final String textField;
  final String valueField;
  final Function change;
  final Function open;
  final Function close;
  final Widget leading;
  final Widget trailing;
  final TextEditingController controller;
  MultiSelect(
      {FormFieldSetter<dynamic> onSaved,
      FormFieldValidator<dynamic> validator,
      dynamic initialValue,
      bool autovalidate = false,
      this.user,
      this.titleText = 'Title',
      this.hintText = 'Tap to select one or more...',
      this.required = false,
      this.errorText = 'Please select one or more Type(s)',
      this.value,
      this.leading,
      this.filterable = true,
      this.enabeled = true,
      this.dataSource,
      this.textField,
      this.valueField,
      this.change,
      this.open,
      this.close,
      this.trailing,
      this.controller})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            
            builder: (FormFieldState<dynamic> state) {
              List<Widget> _buildSelectedOptions(dynamic values, state) {
                List<Widget> selectedOptions = [];

                if (values != null) {
                  values.forEach((item) {
                    var existingItem = dataSource.singleWhere(
                        (itm) => itm[valueField] == item,
                        orElse: () => null);
                    if (existingItem != null) {
                      selectedOptions.add(Chip(
                        label: Text(existingItem[textField],
                            overflow: TextOverflow.ellipsis, style: prefix0.TextStyle(fontSize: 18),),
                      ));
                    }
                  });
                }
                return selectedOptions;
              }

              return InkWell(
                  onTap: () async {
                    if (enabeled == true) {
                      var results = await Navigator.push(
                          state.context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => SelectionModal(
                                titleText: titleText,
                                filterable: filterable,
                                valueField: valueField,
                                textField: textField,
                                dataSource: dataSource,
                                user: user,
                                values: state.value ?? []),
                            fullscreenDialog: true,
                          ));

                      if (results != null) {
                        if (results.length > 0) {
                          state.didChange(results);
                        } else {
                          state.didChange(null);
                        }
                      }
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.only(left: 10.0, top: 0.0, right: 10.0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.grey.shade400)),
                      errorText: state.hasError ? state.errorText : null,
                      errorMaxLines: 4,
                    ),
                    isEmpty: state.value == null || state.value == '',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,bottom: 5.5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                titleText,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 30, 110, 160),
                                    fontWeight: FontWeight.bold),
                              )),
                              required
                                  ? Text(
                                      ' *',
                                      style: TextStyle(
                                          color: Colors.red.shade700,
                                          fontSize: 16.0),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                       state.value != null || enabeled == false 
                            ? Wrap(
                                spacing: 8.0, // gap between adjacent chips
                                runSpacing: 1.0, // gap between lines
                                children:
                                    _buildSelectedOptions(state.value, state),
                            )
                            : new Container(),
                            initialValue == null && state.value != null || enabeled == false 
                            ? Wrap(
                                spacing: 8.0, // gap between adjacent chips
                                runSpacing: 1.0, // gap between lines
                          
                            )
                            : new Container(
                                margin:
                                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 6.0),
                                child: Text(
                                  hintText,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              )
                      ],
                    ),
                  ));
            });
}
