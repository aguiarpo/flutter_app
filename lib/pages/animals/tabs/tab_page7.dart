import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_text_field.dart';

class TabPage7 extends StatefulWidget {
  final jsonBloc;
  final validateCrmv;

  const TabPage7({Key key, this.jsonBloc, this.validateCrmv}) : super(key: key);

  @override
  _TabPage7State createState() => _TabPage7State();
}

class _TabPage7State extends State<TabPage7> with AutomaticKeepAliveClientMixin<TabPage7>{
  DateTime date2;

  var jsonBloc;

  @override
  void initState() {
    super.initState();
    jsonBloc = widget.jsonBloc;
  }

  void onSaved(values){
    jsonBloc.addValueAnimal(values['title'], values['value']);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              MyTextField(
                validate: widget.validateCrmv,
                icon: Icons.person,
                hint: "Veterinário(Crmv)",
                parentAction: onSaved,
                title: 'crmv',
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: TextFormField(
                  onSaved: (value){
                    Map values = {"title" : "comments", "value" : value.trim()};
                    onSaved(values);
                  },
                  maxLines: 5,
                  style: new TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    hintText: "Observações",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}