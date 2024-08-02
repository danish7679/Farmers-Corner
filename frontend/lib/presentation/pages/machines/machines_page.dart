import 'package:agri_connect/data/models/crop.dart';
import 'package:agri_connect/di/get_it.dart';
import 'package:agri_connect/domain/entites/params/get_machines_params.dart';
import 'package:agri_connect/presentation/pages/machines/widgets/machine_card.dart';
import 'package:agri_connect/presentation/widgets/app_error_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/machines/get_machines_cubit/get_machines_cubit.dart';

@RoutePage()
class MachinesPage extends StatelessWidget implements AutoRouteWrapper {
  final Crop crop;

  const MachinesPage({super.key, required this.crop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Machines"),
      ),
      body: BlocBuilder<GetMachinesCubit, GetMachinesState>(
        builder: (context, state) {
          if (state is GetMachinesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetMachinesError) {
            return Center(
              child: AppErrorWidget(
                error: state.error,
                onRetry: () {
                  context
                      .read<GetMachinesCubit>()
                      .getMachines(GetMachinesParams(cropName: crop.name));
                },
              ),
            );
          }
          if (state is GetMachinesLoaded) {
            return GridView.builder(
              itemCount: state.machines.length,
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) => MachineCard(
                machine: state.machines[index],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GetMachinesCubit>()
        ..getMachines(GetMachinesParams(cropName: crop.name)),
      child: this,
    );
  }
}
