import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/database/connect.dart';
import 'package:flutter_app/models/animal_medications.dart';
import 'package:flutter_app/validates/validator_dates.dart';
import 'package:intl/intl.dart';

import '../../../colors.dart';

class TabPage8 extends StatefulWidget {
  final id;
  final medications;
  final dates;
  final list;
  final jsonBloc;

  const TabPage8({Key key, this.id, this.medications, this.dates, this.list, this.jsonBloc}) : super(key: key);
  @override
  _TabPage8State createState() => _TabPage8State();
}

class _TabPage8State extends State<TabPage8> with AutomaticKeepAliveClientMixin<TabPage8> {
  var myController = {};
  Map checkbox = {};
  var jsonBloc;
  Map datesSaved = {};


  void onSaved(value, check){
    if(value == null)datesSaved[check['id']] = widget.dates[check['id']];
    else{
      if(check['value'])datesSaved[check['id']] = value;
    }
    print('');
    jsonBloc.addValue('medications', datesSaved);
  }

  Widget listBuilder(itens){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
          padding: EdgeInsets.only(bottom: 100),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itens.length,
          itemBuilder: (BuildContext context, int index) {
            myController[index] = TextEditingController();
            if(!widget.medications.contains(itens[index].id) && checkbox[index] == null)checkbox[index] = {"id" : itens[index].id, "value" : false};
            else if(checkbox[index] == null) checkbox[index] = {"id" : itens[index].id, "value" : true};
            return Container(
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0, color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0)),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CheckboxListTile(
                                  title: Text(itens[index].name),
                                  onChanged: (bool value) {
                                    if(!value)datesSaved.remove(itens[index].id);
                                    setState(() {
                                      checkbox[index] = {"id" : itens[index].id, "value" : value};
                                    });
                                  },
                                  value: checkbox[index]['value'],
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: checkbox[index]['value'],
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: DateTimePickerFormField(
                              inputType: InputType.date,
                              validator: (dt){
                                return ValidateDates.validateDate(dt, widget.dates[itens[index].id]);
                              },
                              onSaved: (dt) => onSaved(dt, checkbox[index]) ,
                              format: DateFormat("yyyy-MM-dd"),
                              initialDate: widget.medications.contains(itens[index].id) ? widget.dates[itens[index].id] : null,
                              editable: false,
                              resetIcon: Icons.delete,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey, width: 5.0),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  labelText: 'Data da medicação',
                                  hasFloatingPlaceholder: false
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return listBuilder(widget.list);
  }

  @override
  void initState() {
    super.initState();
    jsonBloc = widget.jsonBloc;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}