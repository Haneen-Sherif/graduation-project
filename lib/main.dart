import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:graduation_project/Features/chat/presentation/manager/providers/chat_provider.dart';
import 'package:graduation_project/Features/chat/presentation/manager/providers/models_provider.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/manager/equipments_cubit/equipments_cubit.dart';
import 'package:graduation_project/Features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => const MyApp(),
      enabled: true,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit(),
          ),
          BlocProvider(create: (context) => AuthCubit()),
          BlocProvider(create: (context) => EquipmentsCubit()),
        ],
        child: MaterialApp.router(
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          routerConfig: AppRoutes.router,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: const ColorScheme.light().copyWith(
              background: kSecondaryColor,
            ),
            fontFamily: "Poppins",
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}
