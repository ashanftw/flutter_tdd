import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTrivia> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTrivia triviaToCache);
}
