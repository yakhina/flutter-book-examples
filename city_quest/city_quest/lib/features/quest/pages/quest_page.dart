import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:city_quest/features/quest/bloc/quest_bloc.dart';
import 'package:get_it/get_it.dart';

class QuestPage extends StatelessWidget {
  const QuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              GetIt.instance<QuestBloc>()
                ..add(const QuestLoadRequested())
                ..add(const QuestLoadCities()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Квесты по городам")),
        body: BlocBuilder<QuestBloc, QuestState>(
          builder: (context, state) {
            if (state is QuestLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is QuestError) {
              return Center(child: Text(state.message));
            }

            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Блок общей статистики
                  if (state is QuestLoaded) Text("Пройдено: ${state.completed} из ${state.total}"),

                  const SizedBox(height: 20),

                  // Список городов
                  BlocBuilder<QuestBloc, QuestState>(
                    buildWhen: (_, s) => s is QuestCitiesLoaded,
                    builder: (context, s) {
                      if (s is! QuestCitiesLoaded) return Container();

                      return Expanded(
                        child: ListView.builder(
                          itemCount: s.cities.length,
                          itemBuilder: (_, i) {
                            final c = s.cities[i];

                            return ListTile(
                              title: Text(c.name),
                              subtitle: Text("Пройдено ${c.completed} из ${c.total}"),
                            );
                          },
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 8),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/map");
                      },
                      child: const Text("Квесты рядом на карте"),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
