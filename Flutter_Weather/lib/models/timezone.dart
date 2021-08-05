import 'package:flutter/foundation.dart';


@immutable
class Timezone {

  const Timezone({
    required this.timezone,
    required this.timezoneOffset,
    required this.date,
    required this.dateTime,
    required this.dateTimeTxt,
    required this.dateTimeWti,
    required this.dateTimeYmd,
    required this.dateTimeUnix,
    required this.time24,
    required this.time12,
    required this.week,
    required this.month,
    required this.year,
    required this.yearAbbr,
    required this.isDst,
    required this.dstSavings,
  });

  final String timezone;
  final int timezoneOffset;
  final String date;
  final String dateTime;
  final String dateTimeTxt;
  final String dateTimeWti;
  final String dateTimeYmd;
  final double dateTimeUnix;
  final String time24;
  final String time12;
  final String week;
  final String month;
  final String year;
  final String yearAbbr;
  final bool isDst;
  final int dstSavings;

  factory Timezone.fromJson(Map<String,dynamic> json) => Timezone(
    timezone: json['timezone'] as String,
    timezoneOffset: json['timezone_offset'] as int,
    date: json['date'] as String,
    dateTime: json['date_time'] as String,
    dateTimeTxt: json['date_time_txt'] as String,
    dateTimeWti: json['date_time_wti'] as String,
    dateTimeYmd: json['date_time_ymd'] as String,
    dateTimeUnix: json['date_time_unix'] as double,
    time24: json['time_24'] as String,
    time12: json['time_12'] as String,
    week: json['week'] as String,
    month: json['month'] as String,
    year: json['year'] as String,
    yearAbbr: json['year_abbr'] as String,
    isDst: json['is_dst'] as bool,
    dstSavings: json['dst_savings'] as int
  );
  
  Map<String, dynamic> toJson() => {
    'timezone': timezone,
    'timezone_offset': timezoneOffset,
    'date': date,
    'date_time': dateTime,
    'date_time_txt': dateTimeTxt,
    'date_time_wti': dateTimeWti,
    'date_time_ymd': dateTimeYmd,
    'date_time_unix': dateTimeUnix,
    'time_24': time24,
    'time_12': time12,
    'week': week,
    'month': month,
    'year': year,
    'year_abbr': yearAbbr,
    'is_dst': isDst,
    'dst_savings': dstSavings
  };

  Timezone clone() => Timezone(
    timezone: timezone,
    timezoneOffset: timezoneOffset,
    date: date,
    dateTime: dateTime,
    dateTimeTxt: dateTimeTxt,
    dateTimeWti: dateTimeWti,
    dateTimeYmd: dateTimeYmd,
    dateTimeUnix: dateTimeUnix,
    time24: time24,
    time12: time12,
    week: week,
    month: month,
    year: year,
    yearAbbr: yearAbbr,
    isDst: isDst,
    dstSavings: dstSavings
  );


  Timezone copyWith({
    String? timezone,
    int? timezoneOffset,
    String? date,
    String? dateTime,
    String? dateTimeTxt,
    String? dateTimeWti,
    String? dateTimeYmd,
    double? dateTimeUnix,
    String? time24,
    String? time12,
    String? week,
    String? month,
    String? year,
    String? yearAbbr,
    bool? isDst,
    int? dstSavings
  }) => Timezone(
    timezone: timezone ?? this.timezone,
    timezoneOffset: timezoneOffset ?? this.timezoneOffset,
    date: date ?? this.date,
    dateTime: dateTime ?? this.dateTime,
    dateTimeTxt: dateTimeTxt ?? this.dateTimeTxt,
    dateTimeWti: dateTimeWti ?? this.dateTimeWti,
    dateTimeYmd: dateTimeYmd ?? this.dateTimeYmd,
    dateTimeUnix: dateTimeUnix ?? this.dateTimeUnix,
    time24: time24 ?? this.time24,
    time12: time12 ?? this.time12,
    week: week ?? this.week,
    month: month ?? this.month,
    year: year ?? this.year,
    yearAbbr: yearAbbr ?? this.yearAbbr,
    isDst: isDst ?? this.isDst,
    dstSavings: dstSavings ?? this.dstSavings,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Timezone && timezone == other.timezone && timezoneOffset == other.timezoneOffset && date == other.date && dateTime == other.dateTime && dateTimeTxt == other.dateTimeTxt && dateTimeWti == other.dateTimeWti && dateTimeYmd == other.dateTimeYmd && dateTimeUnix == other.dateTimeUnix && time24 == other.time24 && time12 == other.time12 && week == other.week && month == other.month && year == other.year && yearAbbr == other.yearAbbr && isDst == other.isDst && dstSavings == other.dstSavings;

  @override
  int get hashCode => timezone.hashCode ^ timezoneOffset.hashCode ^ date.hashCode ^ dateTime.hashCode ^ dateTimeTxt.hashCode ^ dateTimeWti.hashCode ^ dateTimeYmd.hashCode ^ dateTimeUnix.hashCode ^ time24.hashCode ^ time12.hashCode ^ week.hashCode ^ month.hashCode ^ year.hashCode ^ yearAbbr.hashCode ^ isDst.hashCode ^ dstSavings.hashCode;
}
