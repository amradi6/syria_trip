import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syri_trip/logic/auth/auth_cubit.dart';
import 'package:syri_trip/logic/main/main_cubit.dart';
import 'package:syri_trip/presentation/main/screens/company_routes.dart';
import 'package:syri_trip/presentation/main/widgets/column_for_dropdown.dart';

class ShowCompany extends StatefulWidget {
  const ShowCompany({super.key});

  @override
  State<ShowCompany> createState() => _ShowCompanyState();
}

class _ShowCompanyState extends State<ShowCompany> {
  @override
  void initState() {
    super.initState();

    final authCubit = context.read<AuthCubit>();

    authCubit.getUserId().then((userId) {
      if (userId != null) {
        context.read<MainCubit>().fetchBalance(userid: userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        centerTitle: true,
        elevation: 1,
        title: const Text(
          "ابحث عن رحلتك",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.019),
            child: BlocBuilder<MainCubit, MainState>(
              builder: (context, state) {
                final cubit = context.read<MainCubit>();
                final balance = cubit.currentBalance;
                if (state is BalanceLoading && balance == null) {
                  return const Center(
                    child: Text(
                      "جارِ تحميل الرصيد...",
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                }
                if (balance != null) {
                  return Center(
                    child: Text(
                      "رصيدك: ل.س ${balance.toStringAsFixed(0)}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                if (state is BalanceError) {
                  return Center(
                    child: Text(
                      "خطأ في تحميل الرصيد",
                      style: TextStyle(
                        color: Colors.red.shade400,
                        fontSize: 14,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.019),
            child: FutureBuilder(
              future: context.read<AuthCubit>().getName(),
              builder: (context, snapshot) {
                return Center(
                  child: Text(
                    snapshot.hasData ? "أهلاً ${snapshot.data}" : "",
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: () => context.read<AuthCubit>().getUserId().then((userId) {
          if (userId != null) {
            context.read<MainCubit>().fetchBalance(userid: userId);
          }
        }),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.036),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.012),

                ColumnForDropdown(
                  text: "من",
                  labelText: "اختر نقطة الانطلاق",
                  isFrom: true,
                ),

                SizedBox(height: size.height * 0.012),

                ColumnForDropdown(
                  text: "الى",
                  labelText: "اختر نقطة الوصول",
                  isFrom: false,
                ),

                SizedBox(height: size.height * 0.02),

                BlocBuilder<MainCubit, MainState>(
                  builder: (context, state) {
                    if (state is CompanyLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is CompanySuccess) {
                      if (state.companies.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Center(
                            child: Text(
                              "لا توجد شركات متاحة حالياً لهذه المحافظات.\nنشكر تفهمكم ❤️",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        );
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.companies.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.9,
                            ),
                        itemBuilder: (context, index) {
                          final company = state.companies[index];
                          final logoUrl = company["logoUrl"];

                          return GestureDetector(
                            onTap: () {
                              final from = context.read<MainCubit>().from;
                              final to = context.read<MainCubit>().to;
                              final companyId = company["id"];

                              context.read<MainCubit>().fetchRouteByCompany(
                                companyId: companyId,
                                from: from,
                                to: to,
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CompanyRoutesScreen(),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    if (logoUrl != null && logoUrl.isNotEmpty)
                                      Image.network(
                                        logoUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Container(
                                                color: Colors.grey.shade300,
                                                child: const Icon(
                                                  Icons.business,
                                                  size: 60,
                                                  color: Colors.grey,
                                                ),
                                              );
                                            },
                                      )
                                    else
                                      Container(
                                        color: Colors.grey.shade300,
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.business,
                                          size: 60,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black54,
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              company['name'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              "الهاتف: ${company['phone']}",
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }

                    if (state is CompanyError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),

                SizedBox(height: size.height * 0.02),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<MainCubit>().fetchCompany();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      fixedSize: Size(size.width * 0.9, size.height * 0.06),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "ابحث",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
