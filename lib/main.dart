import 'package:chat_app/Models/message.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Chat App'),
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
  List<Message> messages = [
    Message(
        text: "OMG!",
        date: DateTime.now().subtract(const Duration(minutes: 0)),
        isSentByMe: false),
    Message(
        text: "Martha is with me. Don't act surprised!",
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isSentByMe: true),
    Message(
        text: 'waiting for you in the cab!',
        date: DateTime.now().subtract(const Duration(minutes: 2)),
        isSentByMe: true),
    Message(
        text: 'Where are you?',
        date: DateTime.now().subtract(const Duration(minutes: 3)),
        isSentByMe: false),
    Message(
        text: 'Sure! I was waiting for you to ask me.',
        date: DateTime.now().subtract(const Duration(days: 1, minutes: 1)),
        isSentByMe: true),
    Message(
        text: 'Do you wanna come?',
        date: DateTime.now().subtract(const Duration(days: 2, minutes: 1)),
        isSentByMe: false),
    Message(
        text: 'Francis.',
        date: DateTime.now().subtract(const Duration(days: 2, minutes: 1)),
        isSentByMe: false),
    Message(
        text: 'with whom?',
        date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
        isSentByMe: true),
    Message(
        text: "Wow!",
        date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
        isSentByMe: true),
    Message(
        text: 'GodZilla!',
        date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
        isSentByMe: false),
    Message(
        text: 'Which Movie?',
        date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
        isSentByMe: true),
    Message(
        text: 'Nothing much. Planning to go for a movie!',
        date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
        isSentByMe: false),
    Message(
        text: "Great! What's Up?",
        date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
        isSentByMe: true),
    Message(
        text: 'Great! What about you?',
        date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
        isSentByMe: false),
    Message(
        text: 'How are You?',
        date: DateTime.now().subtract(const Duration(days: 4, minutes: 1)),
        isSentByMe: true),
    Message(
        text: 'Hey!',
        date: DateTime.now().subtract(const Duration(days: 4, minutes: 1)),
        isSentByMe: false),
    Message(
        text: 'Hey!',
        date: DateTime.now().subtract(const Duration(days: 4, minutes: 1)),
        isSentByMe: true),
  ].reversed.toList();

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [
        Expanded(
          child: GroupedListView<Message, DateTime>(
            padding: const EdgeInsets.all(8),
            reverse: true,
            order: GroupedListOrder.DESC,
            useStickyGroupSeparators: true,
            floatingHeader: true,
            elements: messages,
            groupBy: (message) => DateTime(
              message.date.year,
              message.date.month,
              message.date.day,
            ),
            groupHeaderBuilder: (Message msg) => SizedBox(
              height: 40,
              child: Center(
                child: Card(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      DateFormat.yMMMd().format(msg.date),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            itemBuilder: (context, Message msg) => Align(
              alignment:
                  msg.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Card(
                elevation: 8,
                color: msg.isSentByMe
                    ? const Color.fromRGBO(52, 183, 241, 1)
                    : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    msg.text,
                    style: msg.isSentByMe
                        ? const TextStyle(color: Colors.white)
                        : const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ),
        // const Divider(
        //   color: Colors.black,
        //   thickness: 1.0,
        // ),
        Row(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: const EdgeInsets.all(12),
                    hintText: 'Type your messages here...',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0),
                      gapPadding: 10,
                      borderRadius: BorderRadius.circular(25),
                    )
                  ),
                  controller: _controller,
                ),
              ),
            ),
            Center(
              child: IconButton(
                onPressed: () {
                  final msg = Message(
                    isSentByMe: true,
                    text: _controller.text,
                    date: DateTime.now(),
                  );
                  setState(() {
                    messages.add(msg);
                    _controller.clear();
                  });
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.lightBlue,
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
