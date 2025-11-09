import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syri_trip/logic/main/main_cubit.dart';

class Seats extends StatelessWidget {
  final dynamic seat;

  const Seats({super.key, required this.seat});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MainCubit>();
    final available = !(seat['booked'] ?? true);
    final selected = seat['selected'] ?? false;

    return GestureDetector(
      onTap: available ? () => cubit.selectSeat(seat['id']) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        width: seat['type'] == 'DOUBLE' ? 55 : 45,
        height: 55,
        decoration: BoxDecoration(
          color: !available
              ? Colors.red.shade400
              : selected
              ? Colors.green.shade700
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              seat['type'] == 'DOUBLE' ? Icons.event_seat : Icons.chair,
              color: !available
                  ? Colors.white
                  : selected
                  ? Colors.white
                  : Colors.black54,
              size: 26,
            ),
            Text(
              seat['seatNumber'].toString(),
              style: TextStyle(
                color: !available
                    ? Colors.white
                    : selected
                    ? Colors.white
                    : Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}