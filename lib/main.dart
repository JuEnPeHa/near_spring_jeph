import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:near_spring_jeph/utils/rpcFun.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JEPH NEAR Spring',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController _nameController;
  final String suffix = "_near";
  var name = "";
  var helloNEAR = "";
  var country = "";
  bool isFetched = false;

  @override
  void initState() {
    _nameController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello NEAR Spring!',
              style: Theme.of(context).textTheme.headline6,
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Please input your name",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              textAlign: TextAlign.center,
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            Text(
              'Please choose a language:',
            ),
            DropdownButtonFormField<String>(
                hint: Text('Select a language'),
                items: const [
                  DropdownMenuItem<String>(
                    value: 'spanish',
                    child: Text('Espa??ol'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'english',
                    child: Text('English'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'bonjour',
                    child: Text('French'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'russian',
                    child: Text('Russian'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'ukrainian',
                    child: Text('Ukrainian'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'italian',
                    child: Text('Italian'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'turkish',
                    child: Text('Turkish'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'chinise',
                    child: Text('Chinese'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'portuguese',
                    child: Text('Portuguese'),
                  ),
                ],
                onChanged: (value) {
                  print(value);
                  if (value != null) {
                    setState(() {
                      country = value;
                    });
                  }
                }),
            Text(
              '',
              style: Theme.of(context).textTheme.headline4,
            ),
            CupertinoButton.filled(
                onPressed: (country == "" || suffix == ""
                    ? null
                    : () {
                        rpcFunction(
                                nameForHelloWorld: _nameController.text,
                                methodName: country + suffix)
                            .then((value) {
                          helloNEAR = resolveData(
                              value['result']['result'] as List<dynamic>);
                          isFetched = true;
                          //helloNEAR = helloNEAR.replaceAll("\n", "\n\n");
                          setState(() {});
                          //helloNEAR = "";
                        });
                      }),
                child: Text('fetch data')),
            SizedBox(height: 20),
            !isFetched ? Text('Please click the button') : Text(helloNEAR),
          ],
        ),
      ),
    );
  }
}
