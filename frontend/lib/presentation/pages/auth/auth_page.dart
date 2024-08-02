import 'package:agri_connect/gen/assets.gen.dart';
import 'package:agri_connect/presentation/cubits/auth/auth_cubit/auth_cubit.dart';
import 'package:agri_connect/presentation/routes/app_router.gr.dart';
import 'package:agri_connect/presentation/widgets/primary_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

@RoutePage()
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Farmers Corner"),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.router.replaceAll([
              const HomeWrapperRoute(),
            ]);
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.svgs.appLogo.svg(
                            width: 200,
                            height: 200,
                          ),
                          const Gap(20),
                          Text(
                            "Welcome to Farmers Corner",
                            style: Theme.of(context).textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                          ),
                          const Gap(20),
                        ],
                      ),
                    ),
                   Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Expanded(
      child: PrimaryButton(
        child: const Text('Login'),
        onPressed: () => context.router.push(
          const LoginRoute(),
        ),
      ),
    ),
    Expanded(
      child: PrimaryButton(
        child: const Text('Register'),
        onPressed: () => context.router.push(
          const RegisterRoute(),
        ),
      ),
    ),
  ],
),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
