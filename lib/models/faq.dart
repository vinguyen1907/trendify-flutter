// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FAQ {
  final String question;
  final String answer;

  FAQ({
    required this.question,
    required this.answer,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'answer': answer,
    };
  }

  factory FAQ.fromMap(Map<String, dynamic> map) {
    return FAQ(
      question: map['question'] as String,
      answer: map['answer'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FAQ.fromJson(String source) =>
      FAQ.fromMap(json.decode(source) as Map<String, dynamic>);
}
