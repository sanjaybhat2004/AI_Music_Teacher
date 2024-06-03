import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
// Import 'package:flutter_svg/flutter_svg.dart';.
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'landing_page.dart';
import 'score_display.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

  String token = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjY3NGRiYmE4ZmFlZTY5YWNhZTFiYzFiZTE5MDQ1MzY3OGY0NzI4MDMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiNjE4MTA0NzA4MDU0LTlyOXMxYzRhbGczNmVybGl1Y2hvOXQ1Mm4zMm42ZGdxLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXVkIjoiNjE4MTA0NzA4MDU0LTlyOXMxYzRhbGczNmVybGl1Y2hvOXQ1Mm4zMm42ZGdxLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTAzMzY0OTQzMjQxMDYwOTE2OTEyIiwiZW1haWwiOiJzYW5qdWJoYXQyMDA0QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiZ0Z6NVBvb3JPeEJTUE9LSTh4ME5UdyIsIm5iZiI6MTcxNzQ0NjYyOCwiaWF0IjoxNzE3NDQ2OTI4LCJleHAiOjE3MTc0NTA1MjgsImp0aSI6ImQwMjg0NzUyZWI0NWJhMmEyZGJiY2EzYmI1YmEwOTVkZTA4MmI2NWMifQ.Wj0bpADFt7ENXmIUXCEYSss2HU5wC4Z1Dggf_GCH3_nz4FO_nWA9FJQPnENq6FTFVfbj5hR0tKW8hsl9FSa8haNpTYpyqgbvRqzDzj05snLE4ea4fIXNuMRzbRV_XUKDOe6X6QnPsxLm0_oKrNJ9uot101xPK4UFt1LjbeIotBu4nWiHVo4nWuRtfdQgC4TP-pi3yx03g4PxZ0XMLISufzHbQp7sob7Ai1AZBfnEaBDqTPVshQJuPhDPU5SIoxjDyXphIS6pEmRFo249T_B5rBgtquClyAsE1q2q0b2gSZ7tzFQ3nmroTOkLg2WCyuUJcT8rWNP_l3ijCHJYhiv7Zw";
  const password = 
 "ya29.a0AXooCgt_kBLpfMmDu397UApa9WkO-KbCohFTQspYXXg0mQjaZF1_AkWipwGxKrQu4SjmGwYEC5_m1DQI2KQNwjqSXtpfwnyPkZXppgV-qLqgoUNbhELKtFFzP1sH8nKAPADySFDfymEha0GKb1bBmu1xiOFmvvGmF6sQnF4dbGKWZelplVtekV5Ix0Xzl2LSXinInrK1A15Xrweja98jvumyBSoDSECR6fHikdrgW8GoMVlEqKtG1TsN4lQAJ1lmff1p0GGHYwHxvhCsG_79NEWnr_Qa-7y6SIg9bfbfV4snsCN0vBHdffLdLkq2hQUT5XZizABApd8jLJ1DVbORDFo60eDJZ-iQ2PXf65a7hv4JR8qhrr2Nd7a-jDWNQ4b9aIZChc-52nX56PBslRg6hYWb2tLohdZ_aCgYKAfESARASFQHGX2Mi7R5CvT7AXHFuOlshsKKbmw0423";
 
 class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My App',
        home: LandingPage(),
      );
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );
  final _agent = const types.User(
    id: 'f8b8f3b0-6b6b-4b7b-8b3b-3b6b6b8f8b8f',
  );
  int _userScore = 0;

  @override
  void initState() {
    super.initState();
    // _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

   void _handleSendPressedInvisible(String message) async {
    // final textMessage = types.TextMessage(
    //   author: _user,
    //   createdAt: DateTime.now().millisecondsSinceEpoch,
    //   id: const Uuid().v4(),
    //   text: message.text,
    // );

    // _addMessage(textMessage);
  // password at the top
     final response = await http.post(
      Uri.parse(
        'https://global-dialogflow.googleapis.com/v3/projects/maximal-codex-424206-f2/locations/global/agents/3aaf65f9-e794-44f6-9916-6781890a71c9/sessions/newtest20:detectIntent',
      ),
      headers: {
        'Authorization': 'Bearer $password',
        'x-goog-user-project': 'maximal-codex-424206-f2',
      },
      body: jsonEncode({
        'queryInput': {
          'text': {
            'text': message,
          },
          'languageCode': 'en',
        },
        'queryParams': {
          'timeZone': 'America/Los_Angeles',
        },
      }),
    );

    final data = jsonDecode(response.body);

    if (data['queryResult'] == null) {
      print('error');
    } else {
      final agentResponse = data['queryResult']['responseMessages'][0]['text']['text'][0];
      final textMessageAgent = types.TextMessage(
        author: _agent,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: agentResponse,
      );

      _addMessage(textMessageAgent);

      if( agentResponse.toLowerCase().contains(' correct') ) {
        setState(() {
        _userScore += 10;
      });
      }else if( agentResponse.toLowerCase().contains(' incorrect') ) {
        setState(() {
        _userScore -= 5;
      });
      }
    }
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleMediaSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Audio'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 
  

  Future<void> _handleMediaSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      final file = result.files.first;
      final bytes = file.bytes as List<int>;
      final base64String = base64Encode(bytes);

      // print(base64String);
      print("got base64");

      // _handleSendPressed("sddsd");

      final url = Uri.parse("https://us-central1-maximal-codex-424206-f2.cloudfunctions.net/function-1"); // Replace with your actual URL
      final body = jsonEncode({'audio': base64String});

      final response = await http.post(
        url,
        headers: {'Authorization': 'bearer $token', 'Content-Type': 'application/json'},
        body: body,
      );

      // Handle response
      if (response.statusCode == 200) {
        print('POST request successful!');
        print(response.body);

         final textMessage = types.TextMessage(
          author: _agent,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: "The notes you played were: " + response.body,
        );

        _addMessage(textMessage);
        _handleSendPressedInvisible(response.body);
        

      } else {
        print('POST request failed. Status code: ${response.statusCode}');
      }
    }
  }


  
  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  } 

  // _handleSendPressedInvisible("DETECT NOTE");




  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);

    // password at the top

    final response = await http.post(
      Uri.parse(
        'https://global-dialogflow.googleapis.com/v3/projects/maximal-codex-424206-f2/locations/global/agents/3aaf65f9-e794-44f6-9916-6781890a71c9/sessions/newtest20:detectIntent',
      ),
      headers: {
        'Authorization': 'Bearer $password',
        'x-goog-user-project': 'maximal-codex-424206-f2',
      },
      body: jsonEncode({
        'queryInput': {
          'text': {
            'text': message.text,
          },
          'languageCode': 'en',
        },
        'queryParams': {
          'timeZone': 'America/Los_Angeles',
        },
      }),
    );

    final data = jsonDecode(response.body);

    if (data['queryResult'] == null) {
      print('error');
    } else {
      final agentResponse = data['queryResult']['responseMessages'][0]['text']['text'][0];
      final textMessageAgent = types.TextMessage(
        author: _agent,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: agentResponse,
      );

      _addMessage(textMessageAgent);

      if( agentResponse.toLowerCase().contains(' correct') ) {
        setState(() {
        _userScore += 10;
      });
      }else if( agentResponse.toLowerCase().contains(' incorrect') ) {
        setState(() {
        _userScore -= 5;
      });
      }
    }
  }

  // void _loadMessages() async {
  //   final response = await rootBundle.loadString('assets/messages.json');
  //   final messages = (jsonDecode(response) as List)
  //       .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
  //       .toList();

  //   setState(() {
  //     _messages = messages;
  //   });
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
        children: [
        Chat(
          messages: _messages,
          onAttachmentPressed: _handleAttachmentPressed,
          onMessageTap: _handleMessageTap,
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
        ),
         ScoreDisplay(score: _userScore),
          ],
    ),
  );
}
