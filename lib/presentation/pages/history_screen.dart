

import 'package:ai_application/data/datasources/local/authentication_data.dart';
import 'package:ai_application/data/datasources/local/user_data.dart';
import 'package:ai_application/data/model/user_model.dart';
import 'package:ai_application/presentation/pages/login_screen.dart';
import 'package:ai_application/presentation/pages/profile_screen.dart';
import 'package:ai_application/presentation/widgets/helper_method.dart';
import 'package:ai_application/presentation/controller/c_user.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_){
      CUser cUser =context.read<CUser>();
      cUser.getUserListFromServer();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        actions: [
          IconButton(
            onPressed: ()async{
              AuthenticationLocalData authLocalData = await AuthenticationLocalData.instance();
              authLocalData.setIsSignined(false);
              Get.offAll(()=>LoginScreen());
            }, 
            icon: Icon(Icons.logout),
          ),
          GestureDetector(
            onTap: () async{
              UserLocalData userLocalData = await UserLocalData.instance();
              UserModel? userModel =await userLocalData.getProfileLocally();
              Get.to(()=>ProfileScreen(userModel : userModel!));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                radius: 20,
                child: Icon(Icons.person),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        
        child:Column(
          children: [

            // search bar 
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                // color: Colors.amber,
                border: Border.all(
                  color: Colors.grey
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
        
              child: TextField(
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                
                
                  hintText: "Search your old result...",
                
                  // search icon
                  prefixIcon: IconButton(
                    onPressed: (){}, 
                    icon: Icon(Icons.search),
                  ),
                  
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: (){}, 
                        icon: Icon(Icons.tune),
                      ),
        
                      IconButton(
                        onPressed: (){}, 
                        icon: Icon(Icons.mic),
                      ),
                    ],
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
        
            Consumer<CUser>(
              // child: ,
              builder: (_, cUser,child){
                if(cUser.isloading){
                  return Expanded(child: Center(child: CircularProgressIndicator(),));
                }
                else{
                  return Expanded(
                    child: ListView.builder(
                      itemCount:cUser.getUserList.length ,
                      itemBuilder: (_, index){
                                return getCustomTile(
                                  firstName: cUser.getUserList[index]["firstName"], 
                                  lastName: cUser.getUserList[index]["lastName"], 
                                  age: cUser.getUserList[index]["age"].toString(), 
                                  phone: cUser.getUserList[index]["phone"],
                                  image: cUser.getUserList[index]["image"], 
                                  birthDate: cUser.getUserList[index]["birthDate"],
                                  deleteAction: () {
                                    cUser.deleteAUser(
                                      context: context,
                                      id : cUser.getUserList[index]["id"], 
                                      // responceMessage: (responceMessage) {
                                        
                                      // }
                                    );
                                  },
                                  updateAction: () {
                                    cUser.updateAUserData(
                                      id : cUser.getUserList[index]["id"],
                                      map: {
                                        "firstName": "Romjan",
                                        "lastName": "Ali"
                                      },
                                      callback: (responceMessage){
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responceMessage)));
                                        // rootScaffoldMessengerKey.currentState?.showSnackBar(
                                        //   SnackBar(content: Text(responceMessage)),
                                        // );
                                      },
                                    ); 
                                  },
                                );
                          }
                        ),
                      );
                    }
                  }
                ),
  
        
         
          ],
        ),
      ),
    );
  }
}


Widget getDividerV(){
  return Container(
    color:Colors.grey,
    // height: 10,
    width: 1,
    margin: EdgeInsets.symmetric(horizontal: 5),
  );
}

Widget getDividerH(){
  return Container(
    color:Colors.grey,
    height: 1,
    // width: 10,
    margin: EdgeInsets.symmetric(vertical: 5),
  );
}


Widget getCustomTile({
  required String firstName,
  required String lastName,
  required String age ,
  required String phone ,
  required String image,
  required String birthDate,
  Function()? deleteAction,
  Function()? updateAction,
}){
  return Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(2),
              width: double.infinity,

              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
                
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                
                
                    // leading 
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 5,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(image),
                        ),
                        Text("Ai Chat")
                      ],
                    ),
                
                    getDividerV(),
                
                    // body
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name : $firstName $lastName",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "Age : $age",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "Phone No : $phone",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            )
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.access_time_sharp),
                              Text("${"12:12 pm"}"),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.date_range),
                              Text(getFormattedDate(birthDate))
                            ],
                          ),
                        ],
                      ),
                    ),
                
                
                    // trealing 
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        
                        color: Colors.purpleAccent.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)
                        
                      ),
                      child: IntrinsicWidth(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 5,
                          children: [
                            GestureDetector(
                              onTap: (){
                                updateAction?.call();
                              },
                              child: Icon(Icons.share, color: Colors.blue,)),
                            getDividerH(),
                            GestureDetector(
                              onTap: (){
                                deleteAction?.call();
                              },
                              child: Icon(Icons.delete_outline, color: Colors.red,))
                          
                          ],
                        ),
                      ),
                    ),
                      
                
                  ],
                ),
              ),
            );
}