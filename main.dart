import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Enter Your Data'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  String? email;
  String? gender;
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          onSaved: (newValue) => firstName = newValue,
                          onChanged: (value) {
                            firstName = value;
                          },
                          validator: (value) {},
                          decoration: InputDecoration(
                            labelText: "First Name",
                            hintText: "Enter your first name",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          onSaved: (newValue) => lastName = newValue,
                          onChanged: (value) {
                            lastName = value;
                          },
                          decoration: InputDecoration(
                            labelText: "Last Name",
                            hintText: "Enter your last name",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          onSaved: (newValue) => phoneNumber = newValue,
                          onChanged: (value) {
                            phoneNumber = value;
                          },
                          validator: (value) {},
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            hintText: "Enter your phone number",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (newValue) => email = newValue,
                          onChanged: (value) {
                            email = value;
                          },
                          validator: (value) {},
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Enter your email",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          keyboardType: TextInputType.datetime,
                          // onSaved: (newValue) => birthday = newValue,
                          // onChanged: (value) {},
                          // validator: (value) {},
                          onTap: () => _selectDate(context),
                          decoration: InputDecoration(
                            labelText: "Birthday",
                            hintText: "${selectedDate.toLocal()}".split(' ')[0],
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(height: 30),
                        DropdownButtonFormField(
                          items: ['Male', 'Female', 'Prefer not to say']
                              .map((String category) {
                            return new DropdownMenuItem(
                                value: category,
                                child: Row(
                                  children: <Widget>[
                                    Text(category),
                                  ],
                                ));
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() => gender = newValue as String?);
                          },
                          value: gender,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Gender",
                            hintText: "Gender",
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          keyboardType: TextInputType.streetAddress,
                          onSaved: (newValue) => address = newValue,
                          onChanged: (value) {
                            address = value;
                          },
                          validator: (value) {},
                          decoration: InputDecoration(
                            labelText: "Address",
                            hintText: "Enter your phone address",
                            // If  you are using latest version of flutter then lable text and hint text shown like this
                            // if you r using flutter less then 1.20.* then maybe this is not working properly
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(height: 30),
                        SaveButton(
                          text: "Save",
                          press: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DisplayDetails(
                                    email: email,
                                    firstname: firstName,
                                    lastname: lastName,
                                    gender: gender,
                                    phoneNumber: phoneNumber,
                                    address: address,
                                    birthday: "${selectedDate.toLocal()}"
                                        .split(' ')[0],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DisplayDetails extends StatefulWidget {
  final String? email;
  final String? firstname;
  final String? lastname;
  final String? gender;
  final String? phoneNumber;
  final String? address;
  final String? birthday;
  DisplayDetails({
    this.email,
    this.firstname,
    this.lastname,
    this.gender,
    this.phoneNumber,
    this.address,
    this.birthday,
  });

  @override
  _DisplayDetailsState createState() => _DisplayDetailsState();
}

class _DisplayDetailsState extends State<DisplayDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Preview Data",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        body: Container(
          margin: new EdgeInsets.fromLTRB(0, 50, 0, 0),
          width: double.infinity,
          // height: ,
          padding: new EdgeInsets.all(10.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            // color: Colors.red,
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.album, size: 25),
                  title: Text('First Name - ${widget.firstname}',
                      style: TextStyle(fontSize: 18.0)),
                  subtitle: Text("", style: TextStyle(fontSize: 18.0)),
                ),
                ListTile(
                  leading: Icon(Icons.album, size: 25),
                  title: Text('Last Name - ${widget.lastname}',
                      style: TextStyle(fontSize: 18.0)),
                  subtitle: Text('', style: TextStyle(fontSize: 18.0)),
                ),
                ListTile(
                  leading: Icon(Icons.album, size: 25),
                  title: Text('Email - ${widget.email}',
                      style: TextStyle(fontSize: 18.0)),
                  subtitle: Text("", style: TextStyle(fontSize: 18.0)),
                ),
                ListTile(
                  leading: Icon(Icons.album, size: 25),
                  title: Text('Phone Number - ${widget.phoneNumber}',
                      style: TextStyle(fontSize: 18.0)),
                  subtitle: Text('', style: TextStyle(fontSize: 18.0)),
                ),
                ListTile(
                  leading: Icon(Icons.album, size: 25),
                  title: Text('Birthday - ${widget.birthday}',
                      style: TextStyle(fontSize: 18.0)),
                  subtitle: Text('', style: TextStyle(fontSize: 18.0)),
                ),
                ListTile(
                  leading: Icon(Icons.album, size: 25),
                  title: Text('Gender - ${widget.gender}',
                      style: TextStyle(fontSize: 18.0)),
                  subtitle: Text("", style: TextStyle(fontSize: 18.0)),
                ),
                ListTile(
                  leading: Icon(Icons.album, size: 25),
                  title: Text('Address - ${widget.address}',
                      style: TextStyle(fontSize: 18.0)),
                  subtitle: Text("", style: TextStyle(fontSize: 18.0)),
                ),
              ],
            ),
          ),
        ));
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          primary: Colors.white,
          backgroundColor: Colors.blue,
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
