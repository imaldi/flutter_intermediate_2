import 'package:flutter/material.dart';
import 'package:flutter_intermediate_2/model_pegawai.dart';
import 'package:flutter_intermediate_2/db_helper.dart';
import 'package:flutter_intermediate_2/ui/form_pegawai.dart';

class ListPegawai extends StatefulWidget {
  @override
  _ListPegawaiState createState() => _ListPegawaiState();
}

class _ListPegawaiState extends State<ListPegawai> {
  List<ModelPegawai> items = new List();
  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();

    db.getAllPegawai().then((pegawais) {
      setState(() {
        pegawais.forEach((pegawai) {
          items.add(ModelPegawai.fromMap(pegawai));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Pegawai Apps',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Data Pegawai Apps'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(
                      height: 10.0,
                    ),
                    ListTile(
                      title: Text(
                        '${items[position].emailid}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      subtitle: Text(
                        '${items[position].lastname}',
                        style: new TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      leading: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 15.0,
                            child: Text(
                              '${items[position].id}',
                              style: TextStyle(
                                  fontSize: 22.0, color: Colors.white),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              _deletePegawai(
                                  context, items[position], position);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        _navigateToPegawai(context, items[position]);
                      },
                    )
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _createNewPegawai(context);
          },
        ),
      ),
    );
  }

  void _deletePegawai(
      BuildContext context, ModelPegawai pegawai, int position) async {
    db.deleteDataPegawai(pegawai.id).then((pegawais) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToPegawai(BuildContext context, ModelPegawai pegawai) async {
    String result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FormPegawai(pegawai);
    }));

    if (result == 'update') {
      db.getAllPegawai().then((pegawais) {
        setState(() {
          items.clear();
          pegawais.forEach((pegawai) {
            items.add(ModelPegawai.fromMap(pegawai));
          });
        });
      });
    }
  }

  void _createNewPegawai(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FormPegawai(ModelPegawai('', '', '', ''))),
    );

    if (result == 'save') {
      db.getAllPegawai().then((pegawais) {
        setState(() {
          items.clear();
          pegawais.forEach((pegawai) {
            items.add(ModelPegawai.fromMap(pegawai));
          });
        });
      });
    }
  }
}
