import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:mobile_number/mobile_number.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';


final storage = FlutterSecureStorage();

// Future<String> fillMobileNumber() async {
// 	final String mobileNumber = await MobileNumber.mobileNumber;
// 	return mobileNumber.replaceAll("91", "");
// }

Future<void> localWrite(String _key, String _value) async{
	await storage.write(key: _key, value: _value);
}


Future<String> localRead(String _key) async{
	String value = await storage.read(key: _key);
	// print(value);
	return value;
}

Future<void> localDelete(String _key) async{
	await storage.delete(key: _key);
}

Future<void> validateEmpLogin() async{
	String _user = await storage.read(key: "emp_user");
	String _token = await storage.read(key: "emp_token");
	// final uri = 'https://9h3f0xzrg5.execute-api.us-east-1.amazonaws.com/prod;
	// final headers = {'Content-Type': 'application/json'};
	// Map<String, dynamic> body = {
	// 	"user_name": _user,
	// 	"token": _token
	// };
	// Response response = await post(
	// 	uri,
	// 	headers: headers,
	// 	body: jsonEncode(body),
	// );
}

void showdialog(context, title, content, newPage, end){
		showDialog(
		context: context,
		builder: (BuildContext context) {
			return new AlertDialog(
				title: new Text(title),
				content: new Text(content),
				actions: <Widget>[
					new FlatButton(
						onPressed: (){
							Navigator.push(
								context, 
								new MaterialPageRoute(builder: (context) => newPage())
							);
						}, 
						child: new Text(end))
				],
			);
		} 
	);
}

class DatePicker extends StatelessWidget {
	static const _YEAR = 365;
	const DatePicker({Key key, this.selectedDate, this.onChanged})
		: super(key: key);
	final DateTime selectedDate;
	final ValueChanged<DateTime> onChanged;

	Future<Null> _selectDate(BuildContext context) async {
		FocusScope.of(context).requestFocus(FocusNode());
		await Future.delayed(Duration(milliseconds: 100));
		final DateTime picked = await showDatePicker(
			context: context,
			initialDate: selectedDate,
			firstDate: DateTime.now().subtract(Duration(days: _YEAR * 100)),
			lastDate: DateTime.now().add(Duration(days: _YEAR * 100)),
	    );
    	if (picked != null && picked != selectedDate) {
			onChanged(picked);
		}
	}

	@override
	Widget build(BuildContext context) {
	return Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
		Expanded(
			child: InkWell(
				onTap: () => _selectDate(context),
				child: InputDecorator(
					decoration: InputDecoration(
						border: OutlineInputBorder(
							borderSide: const BorderSide(color: Colors.white, width: 2.0),
							borderRadius: BorderRadius.circular(20.0),
						),
					),
					child: Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						// mainAxisSize: MainAxisSize.min,
						children: <Widget>[
						Padding(
							padding: const EdgeInsets.only(left: 10.0),
							child: Text(
								DateFormat.yMMMMEEEEd().format(selectedDate),
								style: TextStyle(
									// fontSize: 48,
									color: Colors.white,
								),
							)),
						Padding(
							padding: const EdgeInsets.only(left: 12.0, right: 12.0),
							child: Icon(
								Icons.today,
								color: Colors.white,
								size: 18.0,
								),
							)
						])
					)
				)
			)
		]);
	}
}