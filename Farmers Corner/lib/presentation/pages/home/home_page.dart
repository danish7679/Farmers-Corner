import 'package:agri_connect/presentation/routes/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../data/models/user.dart';
import '../../cubits/auth/auth_cubit/auth_cubit.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final user = context.watch<AuthCubit>().state.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Farmers Corner"),
        actions: [
          IconButton(
            onPressed: () {
              context.router.push(const NotificationsRoute());
            },
            icon: const Icon(Icons.notifications, color: Colors.black,),
          ),
          IconButton(
            onPressed: () {
              context.read<AuthCubit>().unauthenticated();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: user == null
          ? const SizedBox.shrink()
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Welcome ${user.name}",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Gap(40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _OptionButtons(
                                icon: Icons.camera,
                                label: 'Scan Crop',
                                onPressed: () {
                                  context.router.push(const ScanCropRoute());
                                },
                              ),
                              _OptionButtons(
                                icon: Icons.agriculture,
                                label: 'View Crops',
                                onPressed: () {
                                  context.router.push(const CropsRoute());
                                },
                              ),
                            ],
                          ),
                          const Gap(40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _OptionButtons(
                                icon: Icons.shopping_cart_rounded,
                                label: 'Orders',
                                onPressed: () {
                                  context.router.push(const OrdersRoute());
                                },
                              ),
                              _OptionButtons(
                                icon: Icons.account_circle,
                                label: 'Profile',
                                onPressed: () {
                                  context.router.push(const ProfileRoute());
                                },
                              ),
                            ],
                          ),

                          const Gap(40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (user.type == UserType.admin)
                                _OptionButtons(
                                  icon: Icons.add,
                                  label: 'Add Machine',
                                  onPressed: () {
                                    context.router
                                        .push(const AddMachineRoute());
                                  },
                                )
                              else
                                _OptionButtons(
                                  icon: Icons.agriculture,
                                  label: 'Rent',
                                  onPressed: () {
                                    context.router
                                        .push(const RentMachineRoute());
                                  },
                                ),                                
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  'Powered by Farmers Corner',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Gap(4),
              ],
            ),
    );
  }
}

class _OptionButtons extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _OptionButtons({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card(
        color: Color.fromARGB(255, 111, 207, 208),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(200), // Make it a circle
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(50), // Make it a circle
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 50,
                  color: Colors.black,
                ),
                const Gap(16),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
