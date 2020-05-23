import 'package:flutter/material.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyCalendar extends StatefulWidget {
  MyCalendar({Key key, this.title, this.myDate, this.selectDate})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final DateTime myDate;
  final String title;
  var selectDate;
  @override
  _MyCalendarState createState() => new _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  DateTime _currentDate;
  DateTime _targetDateTime;

  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    super.initState();
    _currentDate = widget.myDate ?? DateTime.now();
    _targetDateTime = widget.myDate ?? DateTime(2019, 2, 3);
  }

  @override
  Widget build(BuildContext context) {
    /// Example with custom icon
    _calendarCarousel = CalendarCarousel<Event>(
      isScrollable: false,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate = date);
      },
      weekendTextStyle: TextStyle(
        fontSize: 10.0,
        color: Colors.blue.shade700,
      ),
      thisMonthDayBorderColor: kBlack,
//          weekDays: null, /// for pass null when you do not want to render weekDays
      weekFormat: true,
      height: 100.0,
      width: 100.0,
      selectedDateTime: _currentDate,
      showIconBehindDayText: true,
//          daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 2,
      selectedDayTextStyle: TextStyle(
        fontSize: 10.0,
        color: Colors.yellow,
      ),
      todayTextStyle: TextStyle(
        fontSize: 10.0,
        color: Colors.blue.shade100,
      ),
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      todayButtonColor: Colors.blue.shade700,
      todayBorderColor: Colors.blue.shade700,
      markedDateMoreShowTotal:
          true, // null for not showing hidden events indicator
//          markedDateIconMargin: 9,
//          markedDateIconOffset: 3,
    );

    /// Example Calendar Carousel without header and custom prev & next button
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      isScrollable: false,
      todayBorderColor: Colors.blue.shade700,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate = date);
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        fontSize: 10.0,
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      height: 420.0,
      selectedDateTime: _currentDate,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.yellow)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 10.0,
        color: Colors.green,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        fontSize: 10.0,
        color: Colors.blue,
      ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: Colors.yellow,

      selectedDayTextStyle: TextStyle(
        fontSize: 10.0,
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 10.0,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 10.0,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
        });
      },
    );

    return Container(
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() {
            widget.selectDate(date, events);
            _currentDate = date;
          });
        },
        pageScrollPhysics: NeverScrollableScrollPhysics(),
        customGridViewPhysics: NeverScrollableScrollPhysics(),
        prevDaysTextStyle: TextStyle(
          fontSize: 10.0,
          color: Colors.grey,
        ),
        nextDaysTextStyle: TextStyle(
          fontSize: 10.0,
          color: Colors.grey,
        ),
        weekdayTextStyle: TextStyle(
          fontSize: 12.0,
          color: Colors.white,
        ),
        todayTextStyle: TextStyle(
          fontSize: 12.0,
          color: Colors.black.withOpacity(0.83),
          fontWeight: FontWeight.bold,
        ),
        todayButtonColor: Colors.transparent,

        todayBorderColor: Colors.black.withOpacity(0.83),
        daysTextStyle: TextStyle(
          fontSize: 10.0,
          color: Colors.black.withOpacity(0.83),
          fontWeight: FontWeight.bold,
        ),
        selectedDayButtonColor: kButton,
        selectedDayTextStyle: TextStyle(
          fontSize: 12.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        isScrollable: true,
        weekendTextStyle: TextStyle(
          fontSize: 10.0,
          color: Colors.red,
        ),
        markedDateIconMargin: 1.0,
        thisMonthDayBorderColor: Colors.black.withOpacity(0.3),
        locale: "pt_Br",
//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: "teste";
        headerTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
        leftButtonIcon: Icon(
          FontAwesomeIcons.chevronLeft,
          color: Colors.white,
        ),
        rightButtonIcon: Icon(
          FontAwesomeIcons.chevronRight,
          color: Colors.white,
        ),
        headerMargin: EdgeInsets.only(bottom: 3.0),
        customDayBuilder: (
          /// you can provide your own build function to make custom day containers
          bool isSelectable,
          int index,
          bool isSelectedDay,
          bool isToday,
          bool isPrevMonthDay,
          TextStyle textStyle,
          bool isNextMonthDay,
          bool isThisMonthDay,
          DateTime day,
        ) {
          return null;
        },
        weekFormat: false,
        height: 260.0,
        width: 220.0,
        selectedDateTime: _currentDate,
        daysHaveCircularBorder: false,

        /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
  }
}
