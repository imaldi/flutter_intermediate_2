import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intermediate_2/db_helper.dart';
import 'package:flutter_intermediate_2/model_pegawai.dart';

class FormPegawai extends StatefulWidget {
  final ModelPegawai modelPegawai;
  FormPegawai(this.modelPegawai);
  @override
  _FormPegawaiState createState() => _FormPegawaiState();
}

class _FormPegawaiState extends State<FormPegawai> {
  DatabaseHelper db = new DatabaseHelper();

  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _mobileNoController;
  TextEditingController _emailIdController;

  @override
  void initState() {
    super.initState();
    _firstNameController = new TextEditingController(text: widget.modelPegawai.firstname);
    _lastNameController = new TextEditingController(text: widget.modelPegawai.lastname);
    _mobileNoController = new TextEditingController(text: widget.modelPegawai.mobilenumber);
    _emailIdController = new TextEditingController(text: widget.modelPegawai.emailid);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form pegawai'),
        backgroundColor: Colors.green,),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last name'),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            TextField(
              controller: _mobileNoController,
              decoration: InputDecoration(labelText: 'Mobile No'),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            TextField(
              controller: _emailIdController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            RaisedButton(
              child: (widget.modelPegawai.id != null) ?
              Text('Update') : Text('Add'),
              onPressed: (){
                if(widget.modelPegawai.id != null){
                  db.updatePegawai(ModelPegawai.fromMap({
                    'id': widget.modelPegawai.id,
                    'firstname': _firstNameController.text,
                    'lastname': _lastNameController.text,
                    'mobileno': _mobileNoController.text,
                    'emailid': _emailIdController.text
                  })).then((_){
                    Navigator.pop(context,'update');
                  });
                } else {
                  db.savePegawai(
                      ModelPegawai(
                          _firstNameController.text,
                          _lastNameController.text,
                          _mobileNoController.text,
                          _emailIdController.text))
                      .then((_){
                    Navigator.pop(context,'save');
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
