// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> getResponse(String message) async {
  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/engines/davinci-codex/completions'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer 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',
    },
    body: jsonEncode(
      {
        'prompt':
            'The following is a conversation with an AI assistant. The assistant is helpful, creative, clever, and very friendly.\n\nUser: $message\n',
        'temperature': 0.5,
        'max_tokens': 20,
        'top_p': 1,
        'frequency_penalty': 0,
        'presence_penalty': 0
      },
    ),
  );

  final responseBody = jsonDecode(response.body);
  if (responseBody.containsKey('error')) {
    print(responseBody['error']);
    return 'Sorry, there was an error with the AI chatbot. Please try again later.';
  }

  final completions = responseBody['choices'][0]['text'];
  final textBeforeNewline = completions.split('\n')[0];

  return textBeforeNewline;
}
