import 'dart:convert';
import 'dart:io';
import 'package:flutter_tdd/core/error/exceptions.dart';
import 'package:flutter_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTrivia> getConcreteNumberTrivia(int number);
  Future<NumberTrivia> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;
  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTrivia> getConcreteNumberTrivia(int number) async {
    final response = await client.get(
      'http://numbersapi.com/$number',
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NumberTrivia> getRandomNumberTrivia() async {
    final response = await client.get(
      'http://numbersapi.com/random',
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
