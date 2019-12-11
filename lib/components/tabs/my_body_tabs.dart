import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/request/request_my_body_tabs.dart';
import '../../colors.dart';
import '../buttons/my_raise_button.dart';
import 'my_tab_page_selector.dart';

class MyBodyTabs extends StatefulWidget {
  final int requestNumber;
  final List kIcons;
  final jsonSchemaBloc;
  final scaffold;
  final id;

  const MyBodyTabs({Key key, this.kIcons, this.jsonSchemaBloc, this.requestNumber, this.scaffold, this.id}) : super(key: key);

  @override
  _MyBodyTabsState createState() => _MyBodyTabsState();
}

class _MyBodyTabsState extends State<MyBodyTabs> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _requestNumber;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool disabledButton = false;
  int _maxPage = 0;

  Future formValidate(int value)async{
      if(_formKey.currentState.validate()){
            formSaved();
            Map valuesMap = widget.jsonSchemaBloc.getValue;
            if(valuesMap['password'] == null && valuesMap['confirmPassword'] == null){
              await optionsButtons(value);
            }else{
              if(comparePasswords(valuesMap['password'], valuesMap['confirmPassword'])){
                await optionsButtons(value);
              }
        }
      }else{
        showTabs({'page' : _maxPage, 'currentPage' : _tabController.index});
      }
  }

  Future formSaved()async{
    FocusScope.of(context).requestFocus(new FocusNode());
   _formKey.currentState.save();
  }

  bool comparePasswords(String password, String confirmPassword){
    if(password == confirmPassword){
      return true;
    }else{
      final snackBar = SnackBar(content: Text('Senhas não coincidem'));
      Scaffold.of(context).showSnackBar(snackBar);
      return false;
    }
  }

  Future optionsButtons(value) async {
    if(value == _tabController.length ){
      RequestMyBodyTabs requestMyBodyTabs = RequestMyBodyTabs();
      requestMyBodyTabs.id = widget.id;
      requestMyBodyTabs.context = context;
      await requestMyBodyTabs.request(disabledOrEnabledButton, widget.jsonSchemaBloc, _requestNumber);
    }
    else showTabs({'page' : value, 'currentPage' : _tabController.index});
  }

  void showTabs(Map value){
    if(_maxPage  < value['page'])_maxPage = value['page'];
    _tabController.animateTo(value['page']);
    setState(() {});
  }

  void disabledOrEnabledButton(bool value){
    disabledButton = value;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _requestNumber = widget.requestNumber;
    _tabController = TabController(
      length: widget.kIcons.length,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: MyTabPageSelector(
                color: Colors.white,
                controller: _tabController,
                indicatorSize: 9,
                selectedColor: ColorsUsed.blueColor,
              ),
            ),
              Container(
                height: MediaQuery.of(context).size.height - 130,
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 510,
                            child: IconTheme(
                              data: IconThemeData(
                                size: 128.0,
                                color: Theme.of(context).accentColor,
                              ),
                              child: TabBarView(
                                controller: _tabController,
                                children: widget.kIcons,
                                physics: NeverScrollableScrollPhysics(),
                              ),
                            ),
                          ),
                          MyRaiseButton(
                            color: disabledButton ? Colors.grey.shade400 : null,
                            tabController: _tabController,
                            continueButton: disabledButton ? (value){} : (value) async {await formValidate(value);},
                            backButton : disabledButton ? (value){} : showTabs
                          ),
                        ],
                      ),
                    ),
                  ),
              ),
          ],
        ),
      ),
    );
  }
}