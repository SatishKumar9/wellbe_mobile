import 'dart:convert';
import 'package:flutter/material.dart';
import '../helper/functions.dart';
import 'home_page.dart';
import 'package:http/http.dart';
import 'drawer.dart';

class UserRegistrationPage extends StatefulWidget {
	final String phone_no;
	UserRegistrationPage(this.phone_no, {Key key}): super(key: key);
	@override
	UserRegistrationPageState createState() => UserRegistrationPageState();
}

class UserRegistrationPageState extends State<UserRegistrationPage> {
	String phone_no = "";

	String gender = "F";
	bool error = false;
	String error_msg;
	TextEditingController _name = TextEditingController();
	TextEditingController _adnum = TextEditingController();
	TextEditingController _ad1 = TextEditingController();
	TextEditingController _ad2 = TextEditingController();
	TextEditingController _lm = TextEditingController();
	TextEditingController _area = TextEditingController();
	TextEditingController _city = TextEditingController();
	TextEditingController _dist = TextEditingController();
	TextEditingController _state = TextEditingController();
	TextEditingController _pcd = TextEditingController();
	bool en_otp = false;

	Future<void> register_user() async{
		print(phone_no);
		String url = "https://po6acdlwta.execute-api.us-east-1.amazonaws.com/test";
		_name.text;
		final headers = {'Content-Type': 'application/json'};
		Map<String, dynamic> body = {
			"name": _name.text,
			"phone_no": phone_no,
			"date_of_birth": _date.toString(),
			"aadhar_no": _adnum.text,
			"gender": gender,
			"lane1": _ad1.text,
			"lane2": _ad2.text,
			"area": _area.text,
			"landmark": _lm.text,
			"city": _city.text,
			"district": _dist.text,
			"state": _state.text,
			"pincode": int.parse(_pcd.text)
		};
		print(body);
		Response response = await post(
			url,
			headers: headers,
			body: jsonEncode(body),
		);

		var resp = jsonDecode(response.body);
		print(resp);
		showDialog(
			context: context,
			builder: (BuildContext context) {
				return new AlertDialog(
					title: new Text("Registration Sucess"),
					content: new Text("Your registration was successful"),
					actions: <Widget>[
						new FlatButton(
							onPressed: (){
								Navigator.push(
									context, 
									new MaterialPageRoute(builder: (context) => HomePage())
								);
							}, 
							child: new Text("Close"))
					],
				);
			} 
		);
	// Navigator.push(context, new MaterialPageRoute(builder: (context) => TutorialHome()));
	}

	DateTime _date = DateTime.now();

	decor(text, _validate){
		return InputDecoration(
      border: InputBorder.none,
			labelText: text,
			filled: true,
			// labelStyle: TextStyle(
			// 	color: Colors.grey,
			// ) ,
			errorStyle: TextStyle(
				color: Colors.red,
			),
			errorBorder: OutlineInputBorder(
				borderSide: const BorderSide(color: Colors.white, width: 1.0),
				borderRadius: BorderRadius.circular(10.0),
			),
			focusedBorder: OutlineInputBorder(
				borderSide: const BorderSide(color: Colors.blue, width: 2.0),
				borderRadius: BorderRadius.circular(10.0),
			),
		);
	}

	@override 
	Widget build(BuildContext context){
		phone_no = widget.phone_no;
		final _formKey = GlobalKey<FormState>();
		return Scaffold(
			appBar: AppBar(
				title: Text("Sign Up"),
			),
			drawer: AppDrawer(),
			body: SafeArea(
				child: Container(
					child: Form(
						key: _formKey,
						child: ListView(
							padding: EdgeInsets.symmetric(horizontal: 24.0),
							children: <Widget>[
								SizedBox(height: 30.0),
								Text(
									"User Registration",
									textAlign: TextAlign.center,
									style: TextStyle(
										fontSize: 30,
										color: Colors.blue,
									),
								),
								SizedBox(height: 20.0),
								error ? 
									SizedBox(
										height: 40.0,
										child: Text(error_msg)
									) : 
								SizedBox(height: 1.0),
								new TextFormField(
									controller: _name,
									validator: (value){
										if (value.isEmpty){
											return "Empty Name";
										}
										return null;
									},
									decoration: decor("Name", _name.text.isNotEmpty),
									// style: TextStyle(color: Colors.white),
								),
								SizedBox(height: 12.0),
								new TextFormField(
									controller: _adnum,
									validator: (value){
										if (value.isEmpty || (int.tryParse(value) == null) || (value.length != 12)){
											return "Invalid Aadhar Number";
										}
										return null;
									},
									decoration: decor("Aadhar Number", _adnum.text.isNotEmpty),
									// style: TextStyle(color: Colors.white),
								),
								SizedBox(height: 12.0),
								Container(
									child: Row(children: <Widget>[
											SizedBox(width: 10.0),
											Text(
												'Gender: ',
												style: TextStyle(
													// color: Colors.white,
												),
											),
											SizedBox(width: 20.0),
											new DropdownButton<String>(
												items: <String>['Male', 'Female'].map((String value) {
													return new DropdownMenuItem<String>(
													value: value,
													child: new Text(value),
													);
												}).toList(),
												onChanged: (_) {
													if(_ == "Male"){
														gender = "M";
													}
												}
											),
										],
									),
									color: Colors.grey[200],
								),
								SizedBox(height: 12.0),
								Text(
									"Date of Birth",
									style: TextStyle(
										color: Colors.black,
										// fontSize: 20.0,
									),
								),
								SizedBox(height: 7.5),
								Container(
									child: Column(
										children: <Widget>[
											DatePicker(
												selectedDate: _date,
												onChanged: ((DateTime date) {
													setState(() {
														_date = date;
													});
												})
											),
										],
										mainAxisAlignment: MainAxisAlignment.center,
									), 
									
									color: Colors.grey[200],
								),
								SizedBox(height: 20.0),
								Text(
									"Address",
									style: TextStyle(
										// color: Colors.white,
										fontSize: 20.0,
									),
								),
								SizedBox(height: 7.5),
								new TextFormField(
									controller: _ad1,
									validator: (value){
										if (value.isEmpty){
											return "Empty Address Lane 1";
										}
										return null;
									},
									decoration: decor("Address Lane 1", _ad1.text.isNotEmpty),
									// style: TextStyle(color: Colors.white),
								),
								SizedBox(height: 12.0),
								new TextFormField(
									controller: _ad2,
									validator: (value){
										if (value.isEmpty){
											return "Empty Address Lane 2";
										}
										return null;
									},
									decoration: decor("Address Lane 2", _ad2.text.isNotEmpty),
									// style: TextStyle(color: Colors.white),
								),
								SizedBox(height: 12.0),
								new TextFormField(
									controller: _lm,
									validator: (value){
										if (value.isEmpty){
											return "Empty Landmark";
										}
										return null;
									},
									decoration: decor("Land Mark", _lm.text.isNotEmpty),
									// style: TextStyle(color: Colors.white),
								),
								SizedBox(height: 12.0),
								new TextFormField(
									controller: _area,
									validator: (value){
										if (value.isEmpty){
											return "Empty Area";
										}
										return null;
									},
									decoration: decor("Area", _area.text.isNotEmpty),
									// style: TextStyle(color: Colors.white),
								),
								SizedBox(height: 12.0),
								new TextFormField(
									controller: _city,
									validator: (value){
										if (value.isEmpty){
											return "Empty City";
										}
										return null;
									},
									decoration: decor("City", _city.text.isNotEmpty),
									// style: TextStyle(color: Colors.white),
								),
								SizedBox(height: 12.0),
								new TextFormField(
									controller: _dist,
									validator: (value){
										if (value.isEmpty){
											return "Empty District";
										}
										return null;
									},
									decoration: decor("District", _dist.text.isNotEmpty),
									// style: TextStyle(color: Colors.white),
								),
								SizedBox(height: 12.0),
								new TextFormField(
									controller: _state,
									validator: (value){
										if (value.isEmpty){
											return "Empty State";
										}
										return null;
									},
									decoration: decor("State", _state.text.isNotEmpty),
									// style: TextStyle(color: Colors.white),
								),
								SizedBox(height: 12.0),
								new TextFormField(
									controller: _pcd,
									validator: (value){
										if (value.isEmpty || (int.tryParse(value) == null) || (value.length != 6)){
											return "Invalid Pin Code";
										}
										return null;
									},
									decoration: decor("Pin Code", _pcd.text.isNotEmpty),
									// style: TextStyle(color: Colors.white),
								),
								SizedBox(height: 12.0),
								ButtonBar(
									children: <Widget>[
										RaisedButton(
											child: Text(
												"Register",
												style: TextStyle(color: Colors.white),
											),
											padding: EdgeInsets.symmetric(
												horizontal: 10.0,
												vertical: 7.5
											),
											// borderSide: BorderSide(color: Colors.white),
											// shape: StadiumBorder(),
                      color: Colors.blue,
											onPressed: () {
												print(_formKey.currentState.validate());
												(_formKey.currentState.validate()) ? register_user() : null;
											},
										)
									],
									alignment: MainAxisAlignment.center,
								)
							],
						),
						autovalidate: true,
					),
					// decoration: BoxDecoration(
					// 	gradient: LinearGradient(
					// 		begin: Alignment.topRight,
					// 		end: Alignment.bottomLeft,
					// 		colors: [Colors.blue, Colors.teal]
					// 	)
					// ),

				),
			),
		);
	}
}
