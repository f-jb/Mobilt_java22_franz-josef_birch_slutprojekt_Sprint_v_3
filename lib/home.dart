import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled_megatron/chat.dart';

class  HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  // Just the general layout of the app
  // has logout button, profile button and the chat widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const SignOutButton(),
          IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute<ProfileScreen>(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.person,
              ))
        ],
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Column(
          children: [
            Expanded(child: ChatWidget(),)
          ],
        ),
      ),
    );
  }
}
