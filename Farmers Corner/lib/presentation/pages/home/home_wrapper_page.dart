import 'package:agri_connect/presentation/cubits/auth/auth_cubit/auth_cubit.dart';
import 'package:agri_connect/presentation/routes/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeWrapperPage extends StatelessWidget {
  const HomeWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          context.router.replace(const AuthRoute());
        }
      },
      child: const AutoRouter(),
    );
  }
}
