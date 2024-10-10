import '../model/stock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class WatchlistEvent {}

class LoadWatchlist extends WatchlistEvent {}

class SortWatchlistBySymbol extends WatchlistEvent {}

class SortWatchlistByPrice extends WatchlistEvent {}

class SortWatchlistByChange extends WatchlistEvent {}


abstract class WatchlistState {}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistLoaded extends WatchlistState {
  final List<Stock> stocks;
  WatchlistLoaded(this.stocks);
}

class WatchlistError extends WatchlistState {
  final String message;
  WatchlistError(this.message);
}


class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(WatchlistInitial()) {
    on<LoadWatchlist>(_onLoadWatchlist);
    on<SortWatchlistBySymbol>(_onSortBySymbol);
    on<SortWatchlistByPrice>(_onSortByPrice);
    on<SortWatchlistByChange>(_onSortByChange);
  }

  void _onLoadWatchlist(LoadWatchlist event, Emitter<WatchlistState> emit) {
    emit(WatchlistLoading());
    try {
      final stocks = [
        Stock(symbol: 'AAPL', company: 'Apple', price: 150.0, change: 1.2),
        Stock(symbol: 'GOOGL', company: 'Google', price: 2800.0, change: -0.8),
        Stock(symbol: 'AMZN', company: 'Amazon', price: 3300.0, change: 0.5),
        Stock(symbol: 'MSFT', company: 'Microsoft', price: 299.0, change: 1.1),
        Stock(symbol: 'TSLA', company: 'Tesla', price: 750.0, change: -2.3),
        Stock(symbol: 'FB', company: 'Facebook', price: 350.0, change: 0.9),
        Stock(symbol: 'NFLX', company: 'Netflix', price: 610.0, change: -1.5),
        Stock(symbol: 'NVDA', company: 'NVIDIA', price: 220.0, change: 2.0),
        Stock(symbol: 'PYPL', company: 'PayPal', price: 290.0, change: -0.7),
        Stock(symbol: 'ADBE', company: 'Adobe', price: 640.0, change: 0.3),
        Stock(symbol: 'ORCL', company: 'Oracle', price: 87.0, change: 1.4),
        Stock(symbol: 'IBM', company: 'IBM', price: 124.0, change: -0.6),
        Stock(symbol: 'INTC', company: 'Intel', price: 55.0, change: 0.8),
        Stock(symbol: 'AMD', company: 'AMD', price: 110.0, change: 2.1),
        Stock(symbol: 'CSCO', company: 'Cisco', price: 54.0, change: -0.9),
        Stock(symbol: 'SAP', company: 'SAP', price: 145.0, change: 0.5),
        Stock(symbol: 'CRM', company: 'Salesforce', price: 250.0, change: -1.0),
        Stock(symbol: 'TWTR', company: 'Twitter', price: 65.0, change: -0.3),
        Stock(symbol: 'UBER', company: 'Uber', price: 45.0, change: 1.0),
        Stock(symbol: 'SQ', company: 'Square', price: 240.0, change: -0.2),
      ];
      emit(WatchlistLoaded(stocks));
    } catch (e) {
      emit(WatchlistError("Failed to load watchlist"));
    }
  }

  void _onSortBySymbol(SortWatchlistBySymbol event, Emitter<WatchlistState> emit) {
    if (state is WatchlistLoaded) {
      final currentState = state as WatchlistLoaded;
      final sortedStocks = List<Stock>.from(currentState.stocks)
        ..sort((a, b) => a.symbol.compareTo(b.symbol));
      emit(WatchlistLoaded(sortedStocks));
    }
  }

  void _onSortByPrice(SortWatchlistByPrice event, Emitter<WatchlistState> emit) {
    if (state is WatchlistLoaded) {
      final currentState = state as WatchlistLoaded;
      final sortedStocks = List<Stock>.from(currentState.stocks)
        ..sort((a, b) => a.price.compareTo(b.price));
      emit(WatchlistLoaded(sortedStocks));
    }
  }

  void _onSortByChange(SortWatchlistByChange event, Emitter<WatchlistState> emit) {
    if (state is WatchlistLoaded) {
      final currentState = state as WatchlistLoaded;
      final sortedStocks = List<Stock>.from(currentState.stocks)
        ..sort((a, b) => a.change.compareTo(b.change));
      emit(WatchlistLoaded(sortedStocks));
    }
  }
}

