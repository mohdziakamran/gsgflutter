import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsgflutter/src/home/home_screen/tid_tab_screen/tid_query_result_screen.dart';
import 'package:gsgflutter/src/model/tid_response_model.dart';
import 'package:gsgflutter/src/utility/backend/api_backend.dart';
import 'package:gsgflutter/src/utility/my_lib.dart';
import 'package:gsgflutter/src/utility/theme.dart';

class TidQueryTab extends StatefulWidget {
  const TidQueryTab({Key? key}) : super(key: key);

  @override
  _TidQueryTabState createState() => _TidQueryTabState();
}

class _TidQueryTabState extends State<TidQueryTab> {
  TextEditingController _textEditingController = TextEditingController();

  Widget searchButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // primary: Colors.green, // background
          primary: myPrimaryColor, // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () {
          print(_textEditingController.text); ///////////////
          tidQUeryAction();
        },
        child: Container(
          // margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
              Text(
                'Search',
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextFormField(
            style: const TextStyle(fontSize: 20),
            controller: _textEditingController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(labelText: 'TID Number'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter TID Number';
              }
              return null;
            },
          ),
          searchButton(),
        ],
      ),
    );
  }

  //on tab Action Method for making Api call for tid query
  Future<void> tidQUeryAction() async {
    String tid = _textEditingController.text;

    if (tid.isEmpty) {
      // MyLib.myToast("Fill above fields");
      MyLib.mySnackbar(context, "Fill above fields");
      return;
    }

    ///-->
    TidQueryResponseModel response;
    try {
      MyLib.myWaitingWidget(context);

      ///Send request to login api
      response = await ApiBackend.sendTidQueryRequest(tid);
      Navigator.pop(context);
    } catch (e) {
      print(e);
      Navigator.pop(context);
      MyLib.mySnackbar(context, 'Invalid TID');
      return;
    }

    ///on sucessfull response
    ///take into the show Ticket screen
    MyLib.myNewPage(
        context,
        TidQueryResultScreen(
          responseModel: response,
        ));
  }
}
