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
  
  String token = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjY3NGRiYmE4ZmFlZTY5YWNhZTFiYzFiZTE5MDQ1MzY3OGY0NzI4MDMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiNjE4MTA0NzA4MDU0LTlyOXMxYzRhbGczNmVybGl1Y2hvOXQ1Mm4zMm42ZGdxLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXVkIjoiNjE4MTA0NzA4MDU0LTlyOXMxYzRhbGczNmVybGl1Y2hvOXQ1Mm4zMm42ZGdxLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTAzMzY0OTQzMjQxMDYwOTE2OTEyIiwiZW1haWwiOiJzYW5qdWJoYXQyMDA0QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiaW50Q09FbXRtUEFqZXdsTUFzYWcxdyIsIm5iZiI6MTcxNzQwNzE3MSwiaWF0IjoxNzE3NDA3NDcxLCJleHAiOjE3MTc0MTEwNzEsImp0aSI6ImIzYzlhY2U3ZjhjODI2OWVkYmNhYTk2ZDYwZWY3ZTQ3Yjk1MzY3ZjMifQ.MVfudYDhJtyemDTbK3MjcG3IyQ9ug1UTywPWUcD_ptn9f383cbV3Ed6fa77YPO9T6Xr-qc3LgNuE0I9n5KWuKPNebTYnOkyeMzOKI7OfrPdj3XSxwFaBYOOh3DFcboIp4BcUVseT7T6PuU7iCYDBXwc9okR4Ftmvi-gMxn-16Fzqbxra1ZZR4dlErYUJP-rNnPRp_u9y8hxnwLZ8HEgyynBtLNn53IJ3cBLob6hg4Ux3C4-DCN0EjjOCKuCtyc8imTq-nFzpiq3HaXAmeIvEkR7Ogfeh1S6N-rBMDMdeeEhBxFyJQtmXRwy1q0qd9-10bPNrg8Oux_tfsZe9smvBpQ";

  Future<void> _handleMediaSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      final file = result.files.first;
      final bytes = file.bytes as List<int>;
      final base64String = base64Encode(bytes);

      // print(base64String);

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

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);

    const password =
        'ya29.a0AXooCgvKrgxqZzFxE5I7fB1oDmlSmTKN6sfwxaZvR9FtLn6ySWjfBIHWkvZFrFJP5c_H4g8gzMBJbk2Q_1mHT9h4HIp750dTg74fbr-zpUWMJZGNOd-kQM6PX5Jr-Y0wAMLz74MeeyWFApyCBOOez9mLXU1iVVpIlq6aWGVu7K12U-T6lI8AS9UNkRfpHgNblDRzOc9QKqS-elPrmtM4iMPt_Jp8hXo-mPWxXQDYRy5kkew76AiOyyAunkA0NBtCgVrguwPsaKjmwt0cE0yQW2GbkgmjbkxY4zX58-q7N4Q7wljbr8W6xLB2dxZhmksST5febBPQRR_f0tT291Vov-PO2rxdJ36phOCQ2E1Db36D_WBbNL6tdIC_0ix5btUSxJOfuxva2Ia9wUGx1qQlBQ_b7QYvjvVKaCgYKAbYSARASFQHGX2MiLxFBl_gYtaV1v5WHci_jFg0423';
    final response = await http.post(
      Uri.parse(
        'https://global-dialogflow.googleapis.com/v3/projects/maximal-codex-424206-f2/locations/global/agents/3aaf65f9-e794-44f6-9916-6781890a71c9/sessions/newtest2:detectIntent',
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
