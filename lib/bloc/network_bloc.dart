import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc() : super(NetworkInitial()) {
    on<GetData>(_onGetData);
  }

  _onGetData(GetData event, Emitter emit)async{
    try{
      emit(Loading());
      var client = http.Client();
      var res = await client.get(Uri.parse("https://firebasestorage.googleapis.com/v0/b/jill-soap-6a1ac.appspot.com/o/maps.json?alt=media&token=bfd28b0f-06d7-4d25-8d45-e218466c7449"));
      var parsed = jsonDecode(utf8.decode(res.bodyBytes)) as Map;
      if(parsed["routes"]!=null && (parsed["routes"] as List).isNotEmpty){
        emit(DataFetched(bounds: parsed["routes"][0]["bounds"]?.toString() ?? "", legs: parsed["routes"][0]["legs"]?.toString() ?? ""));
      }else{
        emit(DataFetched(
          bounds: "", 
          legs: ""
        ));
      }
      
    }catch(e){
      emit(Error());
    }
  }

}