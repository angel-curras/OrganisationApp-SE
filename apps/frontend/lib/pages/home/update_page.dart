// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:organisation_app/model/task.dart';
// import 'package:organisation_app/services/backend.dart';
//
// // widget class to create stateful new item page
// class UpdateItemPage extends StatefulWidget {
//   final Backend _backend;
//   final http.Client _client;
//   final Item item;
//
//   const UpdateItemPage(this._backend, this._client, this.item);
//
//   @override
//   UpdateItemPageState createState() {
//     return UpdateItemPageState();
//   }
// }
//
// class UpdateItemPageState extends State<UpdateItemPage> {
//
//   // Key to access HTTP Form state
//   final _formKey = GlobalKey<FormState>();
//
//
//   // necessary for mocking (unit and widget tests)
//   late Backend _backend;    // library with functions to access backend
//   late http.Client _client; // REST client proxy
//   late Item item;
//
//   @override
//   void initState() {
//     super.initState();
//     _backend = widget._backend;
//     _client = widget._client;
//     item = widget.item;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   nameController.text = item.name;
//   descriptionController.text = item.description;
//
//   final nameField = TextFormField(
//     key: Key("name"),
//     controller: nameController,
//     keyboardType: TextInputType.text,
//     decoration: InputDecoration (
//       hintText: "Please enter item name"
//     ),
//     validator: (text) {
//       if (text == null || text.isEmpty) {
//         return 'Error: please enter item name';
//       }
//       return null;
//     },
//
//   );
//
//   final descriptionField = TextFormField(
//     key: Key("desc"),
//     controller: descriptionController,
//     keyboardType: TextInputType.multiline,
//     maxLines: 4,
//     decoration: InputDecoration (
//       hintText: "Please enter item description",
//     ),
//     validator: (text) {
//       if (text == null || text.isEmpty) {
//         return 'Error: please enter item description';
//       }
//       return null;
//     },
//   );
//
//
//   final saveButton = ElevatedButton(
//       onPressed: () {
//         if (_formKey.currentState!.validate()) {
//           _backend.updateItem(_client, item.id,  nameController.text, descriptionController.text)
//           .then((value) => Navigator.pop(context));
//         }
//       },
//       child: Text('Update'),
//     );
//
//     return Form(
//       key: _formKey,
//       child: ListView(
//         padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//         children: <Widget>[
//           nameField,
//           descriptionField,
//           saveButton
//         ],
//       ),
//     );
//   }
// }
