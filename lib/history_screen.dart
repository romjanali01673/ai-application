import 'package:ai_application/helper_method.dart';
import 'package:ai_application/services/user_list.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Users users = Users();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage("https://scontent.fzyl2-2.fna.fbcdn.net/v/t39.30808-6/490295869_1342466350336950_1132803492906371083_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=cBWtCIqEZvQQ7kNvwH_k4t7&_nc_oc=Adn1X_-r_Uh5PzjZN-v_5y_duowUN_VcDvyd9TT0uiWerYG16H2scIvnpTavev9UxI8&_nc_zt=23&_nc_ht=scontent.fzyl2-2.fna&_nc_gid=XoIwul_edtU1UTD9e2j2zA&oh=00_AfYB9H4w0a1ytI_yVsuwDxh8ZFK8g0mfRWGbnwOj_HNC7A&oe=68BF0A87")
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
        
            FutureBuilder(
              future: users.getUserListFromServer(), 
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.connectionState != ConnectionState.done){

                  return Center(child: CircularProgressIndicator(),);
                }
                else{
                  debugPrint(users.getUserList.length.toString());
                  return Expanded(
                    child: ListView.builder(
                      itemCount:users.getUserList.length ,
                      itemBuilder: (context, index){
                        return getCustomTile(
                          firstName: users.getUserList[index]["firstName"], 
                          lastName: users.getUserList[index]["lastName"], 
                          age: users.getUserList[index]["age"].toString(), 
                          phone: users.getUserList[index]["phone"],
                          image: users.getUserList[index]["image"], 
                          birthDate: users.getUserList[index]["birthDate"],
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
                            Icon(Icons.share, color: Colors.blue,),
                            getDividerH(),
                            Icon(Icons.delete_outline, color: Colors.red,)
                          
                          ],
                        ),
                      ),
                    ),
                      
                
                  ],
                ),
              ),
            );
}