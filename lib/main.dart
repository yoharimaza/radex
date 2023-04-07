import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radex/dashboard/blocs/current_pokemon_entry/dex_entry_bloc.dart';
import 'package:radex/dashboard/models/pokemon_national_dex.dart';
import 'package:radex/dashboard/pages/home_screen.dart';
import 'package:radex/dashboard/pages/loading_screen.dart';
import 'dashboard/blocs/national_dex_bloc/national_dex_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NationalDexBloc()),
        BlocProvider(create: (_) => DexEntryBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Radex',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoadingScreen(),
      ),
    );
  }
}
