import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syri_trip/logic/main/main_cubit.dart';
import 'package:syri_trip/presentation/main/screens/trip_sates.dart';

class CompanyRoutesScreen extends StatelessWidget {
  const CompanyRoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "رحلات الشركة",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          if (state is CompanyRouteLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is CompanyRouteError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          }
          else if (state is CompanyRouteSuccess) {
            final routes = state.routes;

            if (routes.isEmpty) {
              return const Center(child: Text("لا توجد رحلات متاحة حالياً"));
            }

            final dateKeys = routes.keys.toList();

            return ListView.builder(
              itemCount: dateKeys.length,
              itemBuilder: (context, index) {
                final date = dateKeys[index];
                final dayRoutes = routes[date] as List;

                return ExpansionTile(
                  title: Text("📅 التاريخ: $date"),
                  children: dayRoutes.map((r) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TripSeats(routeId: r["id"],),));
                      },
                      title: Text("${r["fromCity"]} → ${r["toCity"]}"),
                      subtitle: Text("السعر: ${r["price"]} ل.س"),
                      trailing: Text(
                        "🕒 ${r["departureTime"].toString().substring(11, 16)}",
                      ),
                    );
                  }).toList(),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
