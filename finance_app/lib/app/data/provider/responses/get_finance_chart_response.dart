class GetFinanceChartModel {
  final ChartModel chart;

  GetFinanceChartModel({required this.chart});

  factory GetFinanceChartModel.fromMap(Map<String, dynamic> map) {
    return GetFinanceChartModel(
      chart: ChartModel.fromMap(map['chart']),
    );
  }
}

class ChartModel {
  final List<ResultModel>? result;
  final ErrorModel? error;

  ChartModel({
    required this.result,
    required this.error,
  });

  factory ChartModel.fromMap(Map<String, dynamic> map) {
    var result = map['result'];
    var error = map['error'];

    List<ResultModel>? resultModel;
    ErrorModel? errorModel;

    if (result != null) {
      resultModel =
          List<ResultModel>.from(result.map((x) => ResultModel.fromMap(x)));
    }

    if (error != null) {
      errorModel = ErrorModel.fromMap(error);
    }

    return ChartModel(
      result: resultModel,
      error: errorModel,
    );
  }
}

class ErrorModel {
  final String code;
  final String description;

  ErrorModel({
    required this.code,
    required this.description,
  });

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      code: map['code'],
      description: map['description'],
    );
  }
}

class ResultModel {
  final MetaModel meta;
  final List<int> timestamp;
  final Indicators indicators;

  ResultModel({
    required this.meta,
    required this.timestamp,
    required this.indicators,
  });

  factory ResultModel.fromMap(Map<String, dynamic> map) {
    return ResultModel(
      meta: MetaModel.fromMap(map['meta']),
      timestamp: List<int>.from(map['timestamp'].map((x) => x)),
      indicators: Indicators.fromMap(map['indicators']),
    );
  }
}

class MetaModel {
  final String currency;
  final String symbol;
  final String exchangeName;
  final String instrumentType;
  final int firstTradeDate;
  final int regularMarketTime;
  final int gmtoffset;
  final String timezone;
  final String exchangeTimezoneName;
  final double regularMarketPrice;
  final double chartPreviousClose;
  final int priceHint;
  final CurrentTradingPeriodModel currentTradingPeriod;
  final String dataGranularity;
  final String range;
  final List<String> validRanges;

  MetaModel({
    required this.currency,
    required this.symbol,
    required this.exchangeName,
    required this.instrumentType,
    required this.firstTradeDate,
    required this.regularMarketTime,
    required this.gmtoffset,
    required this.timezone,
    required this.exchangeTimezoneName,
    required this.regularMarketPrice,
    required this.chartPreviousClose,
    required this.priceHint,
    required this.currentTradingPeriod,
    required this.dataGranularity,
    required this.range,
    required this.validRanges,
  });

  factory MetaModel.fromMap(Map<String, dynamic> map) {
    return MetaModel(
      currency: map['currency'],
      symbol: map['symbol'],
      exchangeName: map['exchangeName'],
      instrumentType: map['instrumentType'],
      firstTradeDate: map['firstTradeDate'],
      regularMarketTime: map['regularMarketTime'],
      gmtoffset: map['gmtoffset'],
      timezone: map['timezone'],
      exchangeTimezoneName: map['exchangeTimezoneName'],
      regularMarketPrice: map['regularMarketPrice'],
      chartPreviousClose: map['chartPreviousClose'],
      priceHint: map['priceHint'],
      currentTradingPeriod:
          CurrentTradingPeriodModel.fromMap(map['currentTradingPeriod']),
      dataGranularity: map['dataGranularity'],
      range: map['range'],
      validRanges: List<String>.from(map['validRanges'].map((x) => x)),
    );
  }
}

class CurrentTradingPeriodModel {
  final Pre pre;
  final Pre regular;
  final Pre post;

  CurrentTradingPeriodModel({
    required this.pre,
    required this.regular,
    required this.post,
  });

  factory CurrentTradingPeriodModel.fromMap(Map<String, dynamic> map) {
    return CurrentTradingPeriodModel(
      pre: Pre.fromMap(map['pre']),
      regular: Pre.fromMap(map['regular']),
      post: Pre.fromMap(map['post']),
    );
  }
}

class Pre {
  final String timezone;
  final int start;
  final int end;
  final int gmtoffset;

  Pre({
    required this.timezone,
    required this.start,
    required this.end,
    required this.gmtoffset,
  });

  factory Pre.fromMap(Map<String, dynamic> map) {
    return Pre(
      timezone: map['timezone'],
      start: map['start'],
      end: map['end'],
      gmtoffset: map['gmtoffset'],
    );
  }
}

class Indicators {
  final List<Quote> quote;
  final List<Adjclose> adjclose;

  Indicators({
    required this.quote,
    required this.adjclose,
  });

  factory Indicators.fromMap(Map<String, dynamic> map) {
    return Indicators(
      quote: List<Quote>.from(map['quote'].map((x) => Quote.fromMap(x))),
      adjclose:
          List<Adjclose>.from(map['adjclose'].map((x) => Adjclose.fromMap(x))),
    );
  }
}

class Quote {
  final List<double?> close;
  final List<double?> high;
  final List<double?> open;
  final List<double?> low;
  final List<int?> volume;

  Quote({
    required this.close,
    required this.high,
    required this.open,
    required this.low,
    required this.volume,
  });

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      close: List<double?>.from(map['close'].map((x) => x)),
      high: List<double?>.from(map['high'].map((x) => x)),
      open: List<double?>.from(map['open'].map((x) => x)),
      low: List<double?>.from(map['low'].map((x) => x)),
      volume: List<int?>.from(map['volume'].map((x) => x)),
    );
  }
}

class Adjclose {
  final List<double?> adjclose;

  Adjclose({
    required this.adjclose,
  });

  factory Adjclose.fromMap(Map<String, dynamic> map) {
    return Adjclose(
      adjclose: List<double?>.from(map['adjclose'].map((x) => x)),
    );
  }
}
