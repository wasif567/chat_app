import 'package:chat/app/router/router.dart';
import 'package:chat/app/router/router_constant.dart';
import 'package:chat/src/application/auth/auth_bloc.dart';
import 'package:chat/src/application/chats/chats_cubit.dart';
import 'package:chat/src/application/country_bloc/country_bloc.dart';
import 'package:chat/src/application/user/user_bloc.dart';
import 'package:chat/src/infrastructure/auth/auth_repo.dart';
import 'package:chat/src/infrastructure/chat/chat_repo.dart';
import 'package:chat/src/infrastructure/user/user_repo.dart';
import 'package:chat/src/presentation/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChatCubit(ChatRepo())),
        BlocProvider(create: (context) => AuthBloc(AuthRepo())),
        BlocProvider(create: (context) => CountryBloc()),
        BlocProvider(create: (context) => UserBloc(userRepository: UserRepository(), authRepo: AuthRepo())),
      ],
      child: MaterialApp(
        title: 'Chat App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().lightMode,
        initialRoute: RouterConstant.splashRoute,
        onGenerateRoute: AppRouter.generateRoute,
        // locale: value.appLocal,
        supportedLocales: const [
          Locale("en", "US"),
          Locale('ar', ''),
        ],
        // localizationsDelegates: const [
        //   AppLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        // home: const SplashPage(),
      ),
    );
  }
}
