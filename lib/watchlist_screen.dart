import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:watchlist_flutter_app/bloc/watchlistbloc.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trading Watchlist'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Symbol') {
                context.read<WatchlistBloc>().add(SortWatchlistBySymbol());
              } else if (value == 'Price') {
                context.read<WatchlistBloc>().add(SortWatchlistByPrice());
              } else if (value == 'Change') {
                context.read<WatchlistBloc>().add(SortWatchlistByChange());
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: 'Symbol', child: Text('Sort by Symbol')),
              const PopupMenuItem(value: 'Price', child: Text('Sort by Price')),
              const PopupMenuItem(
                  value: 'Change', child: Text('Sort by Change')),
            ],
          )
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      "Watch List",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(
                          DateFormat('dd MMMM yyyy').format(DateTime.now()),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat().add_jm().format(DateTime.now()),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: BlocBuilder<WatchlistBloc, WatchlistState>(
                  builder: (context, state) {
                    if (state is WatchlistLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is WatchlistLoaded) {
                      return ListView.builder(
                        itemCount: state.stocks.length,
                        itemBuilder: (context, index) {
                          final stock = state.stocks[index];
                          bool isChgNegative = true;

                          if (stock.change > 0) {
                            isChgNegative = false;
                          }
                          return ListTile(
                            contentPadding: EdgeInsets.all(10),
                            title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(stock.symbol,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500)),
                                  Text(stock.symbol,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20))
                                ]),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "\$${stock.price}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: 75,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: isChgNegative
                                          ? Colors.red
                                          : Colors.green),
                                  child: Text(
                                    "${stock.change}%",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else if (state is WatchlistError) {
                      return Center(child: Text(state.message));
                    }
                    return const Center(child: Text('No data'));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
