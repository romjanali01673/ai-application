import 'package:ai_application/data/model/user_model.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel userModel;
  const ProfileScreen({super.key,required this.userModel});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),  
        actions: [],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("User ID: ${widget.userModel.id}"),
                  Text("User Name: ${widget.userModel.username}"),
                  Text("Name: ${widget.userModel.name}"),
                  Text("Phone: ${widget.userModel.phone}"),
                  Text("Email: ${widget.userModel.email}"),
                  Text("Website: ${widget.userModel.website}"),
                ],
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}