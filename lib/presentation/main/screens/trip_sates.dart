import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syri_trip/logic/main/main_cubit.dart';
import 'package:syri_trip/presentation/main/widgets/seats.dart';

class TripSeats extends StatefulWidget {
  final int routeId;

  const TripSeats({super.key, required this.routeId});

  @override
  State<TripSeats> createState() => _TripSeatsState();
}

class _TripSeatsState extends State<TripSeats> {
  @override
  void initState() {
    super.initState();
    context.read<MainCubit>().fetchSeats(routeId: widget.routeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("اختيار المقعد"), centerTitle: true),
      body: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          if (state is SeatsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is SeatsError) {
            return Center(child: Text(state.message));
          }
          else if (state is SeatsSuccess) {
            final seats = state.seats;

            final rows = <List<dynamic>>[];
            for (int i = 0; i < seats.length; i += 3) {
              rows.add(seats.skip(i).take(3).toList());
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: rows.length,
                      itemBuilder: (context, rowIndex) {
                        final row = rows[rowIndex];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: row.take(2).map((seat) {
                                  return Seats(seat: seat);
                                }).toList(),
                              ),
                              const SizedBox(width: 30), // ممر
                              if (row.length > 2) Seats(seat: row[2]),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final selected = seats
                          .where((s) => s['selected'] == false)
                          .toList();
                      if (selected.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("يرجى اختيار مقعد أولاً"),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "تم اختيار ${selected.length} مقعد(ات): ${selected.map((e) => e['seatNumber']).join(', ')}",
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "تأكيد الاختيار",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}