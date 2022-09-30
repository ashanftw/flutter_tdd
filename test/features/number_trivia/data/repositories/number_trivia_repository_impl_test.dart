import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/core/platform/network_info.dart';
import 'package:flutter_tdd/features/number_trivia/data/datascources/number_trivia_local_data_source.dart';
import 'package:flutter_tdd/features/number_trivia/data/datascources/number_trivia_remote_data_source.dart';
import 'package:flutter_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataScource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataScource extends Mock implements NumberTriviaLocalDataSource {
}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImpl repository;
  MockRemoteDataScource mockRemoteDataScource;
  MockLocalDataScource mockLocalDataScource;
  MockNetworkInfo mockNetworkInfo;

  //setUp(() {
  mockRemoteDataScource = MockRemoteDataScource();
  mockLocalDataScource = MockLocalDataScource();
  mockNetworkInfo = MockNetworkInfo();
  repository = NumberTriviaRepositoryImpl(
      localDataSource: mockLocalDataScource,
      remoteDataSource: mockRemoteDataScource,
      networkInfo: mockNetworkInfo);
  //});

  const tNumber = 1;
  const tNumberTriviaModel = NumberTriviaModel(number: tNumber, text: 'Test');
  const NumberTrivia tNumberTrivia = tNumberTriviaModel;

  group('getConcreteNumberTrivia', () {
    test('should cheeck if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      await repository.getConcreteNumberTrivia(tNumber);
      // assert
      verify(mockNetworkInfo.isConnected);
    });
  });

  group('device Is Online', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test(
        'should return remote data when the call to remote data source is successfull',
        () async {
      // arrange
      when(mockRemoteDataScource.getConcreteNumberTrivia(tNumber))
          .thenAnswer((_) async => tNumberTrivia);
      // act
      final result = await repository.getConcreteNumberTrivia(tNumber);
      // assert
      verify(mockRemoteDataScource.getConcreteNumberTrivia(tNumber));
      expect(result, equals(const Right(tNumberTrivia)));
    });
  });
  group('device Is Offline', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });
  });
}
