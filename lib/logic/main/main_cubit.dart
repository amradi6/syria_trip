import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http show get;
import 'package:meta/meta.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  double? currentBalance;

  List<dynamic> seats = [];

  Future<void> fetchBalance({required int userid}) async {
    try {
      emit(BalanceLoading());
      final url = Uri.parse("http://10.0.2.2:8080/balance/$userid");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final balance = double.tryParse(response.body) ?? 0.0;
        currentBalance = balance;
        emit(BalanceSuccess(balance));
      } else {
        emit(BalanceError("فشل في جلب الرصيد"));
      }
    } catch (e) {
      emit(BalanceError(e.toString()));
    }
  }

  String from = "";

  String to = "";

  void setFrom(String value) {
    from = value;
    emit(MainFromChanged(value));
  }

  void setTo(String value) {
    to = value;
    emit(MainToChanged(value));
  }

  Future<void> fetchCompany() async {
    if (from.isEmpty || to.isEmpty) return;

    emit(CompanyLoading());
    try {
      final url = Uri.parse(
        "http://10.0.2.2:8080/routes/companies?from=$from&to=$to",
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emit(CompanySuccess(data));
      } else {
        emit(CompanyError("خطأ في جلب البيانات"));
      }
    } catch (e) {
      emit(CompanyError(e.toString()));
    }
  }

  Future<void> fetchRouteByCompany({
    required int companyId,
    required String from,
    required String to,
  }) async {
    emit(CompanyRouteLoading());
    try {
      final url = Uri.parse(
        "http://10.0.2.2:8080/routes/by-company?companyId=$companyId&from=$from&to=$to",
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emit(CompanyRouteSuccess(data));
      } else {
        emit(CompanyRouteError("حدث خطأ أثناء جلب البيانات"));
      }
    } catch (e) {
      emit(CompanyError(e.toString()));
    }
  }

  Future<void> fetchSeats({required int routeId}) async {
    emit(SeatsLoading());
    try {
      final url = Uri.parse(
        "http://10.0.2.2:8080/seats/by-trip?routeId=$routeId",
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emit(SeatsSuccess(data));
      } else {
        emit(SeatsError("فشل في تحميل المقاعد"));
      }
    } catch (e) {
      emit(SeatsError(e.toString()));
    }
  }

  void selectSeat(int seatId) {
    if (state is SeatsSuccess) {
      final seats = List<Map<String, dynamic>>.from(
        (state as SeatsSuccess).seats,
      );

      final updatedSeats = seats.map((s) {
        if (s['id'] == seatId && (s['booked'] == false)) {
          return {...s, 'selected': !(s['selected'] ?? false)};
        }
        return s;
      }).toList();

      emit(SeatsSuccess(updatedSeats));
    }
  }
}
