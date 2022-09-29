import 'package:flutter_tdd/core/platform/network_info.dart';
import 'package:flutter_tdd/features/number_trivia/data/datascources/number_trivia_local_data_source.dart';
import 'package:flutter_tdd/features/number_trivia/data/datascources/number_trivia_remote_data_source.dart';
import 'package:flutter_tdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
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

  setUp(() {
    mockRemoteDataScource = MockRemoteDataScource();
    mockLocalDataScource = MockLocalDataScource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
        localDataSource: mockLocalDataScource,
        remoteDataSource: mockRemoteDataScource,
        networkInfo: mockNetworkInfo);
  });
}
