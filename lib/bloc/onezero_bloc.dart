import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pixez/models/onezero_response.dart';
import 'package:pixez/network/api_client.dart';
import 'package:pixez/network/onezero_client.dart';
import './bloc.dart';

class OnezeroBloc extends Bloc<OnezeroEvent, OnezeroState> {
  final OnezeroClient onezeroClient;

  OnezeroBloc(this.onezeroClient);
  @override
  OnezeroState get initialState => InitialOnezeroState();

  @override
  Stream<OnezeroState> mapEventToState(
    OnezeroEvent event,
  ) async* {
    if (event is FetchOnezeroEvent) {
      try {
        OnezeroResponse onezeroResponse =
            await onezeroClient.queryDns(ApiClient.BASE_API_URL_HOST);
        yield DataOnezeroState(onezeroResponse);
      } catch (e) {
        print(e);
        yield FailOnezeroState();
      }
    }
  }
}
