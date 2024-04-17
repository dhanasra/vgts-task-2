import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/network_bloc.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFF3b6cf2),
    statusBarIconBrightness: Brightness.light,
  ));
  
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    var bloc = NetworkBloc();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BlocBuilder<NetworkBloc, NetworkState>(
          bloc: bloc,
          builder: (_, state) {

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey
                        )
                      ),
                      child: state is Loading 
                        ? const CircularProgressIndicator()
                        : state is DataFetched 
                        ? SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Bounds", style:  Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 8,),
                              Text(state.bounds),
                              const Divider(height: 36,),
                              Text("Legs", style:  Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 8,),
                              Text(state.legs)
                            ],
                          ),
                        ) 
                        : state is Error
                        ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Error", style:  Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 8,),
                            Text(state.e)
                          ],
                        ) : const SizedBox.shrink(),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  ElevatedButton(
                    onPressed: ()=>bloc.add(GetData()), 
                    child: const Text("Fetch Data"))
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}