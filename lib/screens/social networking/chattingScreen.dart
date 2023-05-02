import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import '../../constants/modifiedCards.dart';
import '../../constants/FirebaseConstants.dart';
import '../../constants/chatBubble.dart';
import '../../constants/const.dart';
import '../../constants/mediaquery.dart';
import '../../constants/models/messageChatModel.dart';
import '../../providers/encryption.dart';

class ChattingScreen extends StatefulWidget {
  ChattingScreen({Key? key, required this.uid}) : super(key: key);
  static const String id = 'chatting_screen';
  final String uid;
  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {

  String groupChatId = "";
  String currentUserId = "";
  String peerId = ""; //peer means the person current user is talking to

  generateGroupId() {
    currentUserId = FirebaseAuth.instance.currentUser!.uid;
    peerId = widget.uid;

    if (currentUserId.compareTo(peerId) > 0) {
      groupChatId = '$currentUserId-$peerId';
    } else {
      groupChatId = '$peerId-$currentUserId';
    }
    updateDataFirestore(
      FirestoreConstants.pathUserCollection,
      currentUserId,
      {FirestoreConstants.chattingWith: peerId},
    );
  }
  Future<void> updateDataFirestore(String collectionPath, String docPath, Map<String, dynamic> dataNeedUpdate) {
    return FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(docPath)
        .update(dataNeedUpdate);
  }

  sendChat({required String message}) async {
    final String encmess =
    Encryption().encryption(message, "1234567891234567");
    MessageChat chat = MessageChat(
        content: encmess,
        idFrom: currentUserId,
        idTo: peerId,
        timestamp: Timestamp.now().toString());

    await FirebaseFirestore.instance
        .collection("groupMessages")
        .doc(groupChatId)
        .collection("messages")
        .add(chat.toJson());

    _messageController.text = "";
    //
  }

  @override
  void initState() {
    generateGroupId();
    _scrollDown();
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _controller = ScrollController();

  void _scrollDown() {
    if (_controller.hasClients) {
      _controller.jumpTo(_controller.position.maxScrollExtent);
    }
  }

  Future<bool> onBackPress() {
    updateDataFirestore(
      FirestoreConstants.pathUserCollection,
      currentUserId,
      {FirestoreConstants.chattingWith: null},
    );
    Navigator.pop(context);

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        backgroundColor: backgroundcolor1,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                onBackPress();
              }),
          title: const Text("Your Chats"),
          centerTitle: true,
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            height: 60,
            width: media(context).width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      // pickImage();
                    },
                    icon: Icon(Icons.image)),
                IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                Container(
                  width: media(context).width / 2,
                  child: TextField(
                    decoration: InputDecoration(label: Text("Enter message")),
                    controller: _messageController,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      sendChat(message: _messageController.text);
                      _messageController.text = "";
                      //_scrollDown();
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    icon: Icon(Icons.send))
              ],
            ),
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("groupMessages")
                .doc(groupChatId)
                .collection("messages")
                .orderBy(FirestoreConstants.timestamp, descending: true)
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  controller: _controller,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    MessageChat chat =
                    MessageChat.fromDocument(snapshot.data!.docs[index]);
                    final String message =
                    Encryption().decrypted(chat.content, "1234567891234567");
                    return ChatBubble(
                        text: message,
                        isCurrentUser:
                        chat.idFrom == currentUserId ? true : false);
                  },
                ),
              );
            }),
      ),
    );
  }
}

