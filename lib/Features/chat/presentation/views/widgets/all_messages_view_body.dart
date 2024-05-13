import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/chat/services/chat_service.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:graduation_project/generated/assets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllMessagesViewBody extends StatefulWidget {
  const AllMessagesViewBody({Key? key});

  @override
  State<AllMessagesViewBody> createState() => _AllMessagesViewBodyState();
}

class _AllMessagesViewBodyState extends State<AllMessagesViewBody> {
  String username = '';
  Map<String, dynamic>? userMap;
  bool isLoading = false;

  final TextEditingController _search = TextEditingController();

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    setState(() {
      isLoading = true;
    });
    await _firestore
        .collection("users")
        .where("name", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final name = await prefs.getString('username');

    username = name!;
    print(username);
    return username;
  }

  @override
  void initState() {
    getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('users')
          .where('role', isEqualTo: "FarmOwner")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final users = snapshot.data!.docs;

        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 24, top: 13, bottom: 13),
                          child: Image.asset(Assets.iconsBack),
                        )),
                  ],
                ),
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        TextField(
                          controller: _search,
                          decoration: InputDecoration(
                              hintText: "Search",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        ElevatedButton(
                            onPressed: onSearch, child: Text("Search")),
                        userMap != null
                            ? ListTile(
                                onTap: () {},
                                title: Text(userMap!["name"]),
                                subtitle: Text(userMap!["message"]),
                                trailing: Icon(Icons.chat),
                              )
                            : Container()
                      ],
                    ),
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final userData =
                        users[index].data() as Map<String, dynamic>;
                    final DateTime? userTime = userData['time']?.toDate();

                    final formattedTime = userTime != null
                        ? DateFormat.jm().format(userTime)
                        : '';
                    String subtitleText = '';
                    if (userData['type'] == 'text') {
                      subtitleText = userData['message'] ?? '';
                    } else if (userData['type'] == 'img') {
                      subtitleText = 'An image is sent';
                    }

                    return ListTile(
                      title: Text(
                        userData['name'] ?? 'No username',
                        style: Styles.textStyle16(context).copyWith(
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w500,
                            color: Color(0xff080707)),
                      ),
                      subtitle: Text(
                        subtitleText,
                        style: Styles.textStyle14(context).copyWith(
                            fontFamily: "Open Sans", color: Color(0xff747881)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(
                        formattedTime,
                        style: Styles.textStyle12(context)
                            .copyWith(fontFamily: "Open Sans"),
                      ),
                      onTap: () async {
                        String roomId = await ChatService.generateChatRoomId(
                            [username, userData['name']]);
                        context.push(
                          AppRoutes.kRealTimeChatView2,
                          extra: {
                            "userName": userData['name'],
                            "roomName": roomId,
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
