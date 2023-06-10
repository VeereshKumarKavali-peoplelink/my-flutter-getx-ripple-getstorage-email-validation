import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init(); //initialize storage driver 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  var emailEditingController = TextEditingController();
  var storage = GetStorage();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetSttorage & Email Validation',
      theme: ThemeData(
       
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("GetStorage & Email Validation")),
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Padding(padding: const  EdgeInsets.all(16.0), child: TextField(controller: emailEditingController,)),
            const SizedBox(height: 8),
            Padding(padding: const EdgeInsets.all(16.0), child: ElevatedButton(onPressed: (){
              if (GetUtils.isEmail(emailEditingController.text)){
                storage.write("email", emailEditingController.text);
                emailEditingController.text = "";

              }else{
                Get.snackbar("Incorrect Email", "Provide Email in Valid Format", colorText: Colors.white, backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);

              }
            }, child: const Text("Store / Write"))),

            Padding(padding: const EdgeInsets.all(16.0), child: ElevatedButton(onPressed: () {
              emailEditingController.text = storage.read("email");
              //print("The Email is ${storage.read("email")}");
            }, child: const Text("Read")))
          ],
        ))

        
      ),
    );
  }
}

/*
GetStorage is used for persistent key/value storage.
can store String, int, double, Map and List 


//To Listen for changes 
    var listen = storage.listen((){print("Email Changed");})

    //when subscribed to listen event, it should be disposed by 
    storage.removeListen(listen);

    //to listen for changes in key 
    storage.listenKey("email", (value){
      print("new key is $value");
    });


    //Remove a key
    storage.remove("email");

    //erase the container 
    storage.erase();


    //create a container with a name 
    GetStorage g = GetStorage("MyStorage");
    await GetStorage.init("MyStorage"); //initialize






*/
