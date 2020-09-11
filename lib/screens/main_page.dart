import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_mobile_fullstack/utils/constants.dart';
import 'package:todo_mobile_fullstack/widgets/add_task_container.dart';
import 'package:todo_mobile_fullstack/widgets/drawer.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final CalendarController _calendarController = CalendarController();
  DateTime _selectedDay = DateTime.now();

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedDay = day;
    });
  }

  String _getTitle() {
    DateTime today = DateTime.now();

    if (_selectedDay.day == today.day &&
        _selectedDay.month == today.month &&
        _selectedDay.year == today.year) {
      return 'Today';
    } else if (_selectedDay.year != today.year) {
      return DateFormat.yMMMd().format(_selectedDay);
    }

    return DateFormat.MMMd().format(_selectedDay);
  }

  @override
  void dispose() {
    super.dispose();
    _calendarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      drawerEdgeDragWidth: 0,
      drawer: Drawer(
        child: DrawerContent(),
      ),
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Column(
          children: [
            Text(_getTitle()),
          ],
        ),
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
          child: Icon(FontAwesomeIcons.bars),
        ),
        actions: [
          if (_getTitle() != 'Today')
            InkWell(
              onTap: () {
                setState(() {
                  _calendarController.setSelectedDay(DateTime.now());
                  _selectedDay = DateTime.now();
                });
              },
              child: SizedBox(
                  width: 56.0, child: Icon(FontAwesomeIcons.dotCircle)),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(75.0),
          child: Column(
            children: [
              AppBarCalendar(
                calendarController: _calendarController,
                onSelectDay: _onDaySelected,
              ),
              SizedBox(
                width: double.infinity,
                height: 1,
                child: Container(
                  color: Colors.grey[700],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            context: context,
            builder: (BuildContext context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTaskContainer(() {}),
              ),
            ),
          );
        },
        backgroundColor: Colors.blueAccent,
        tooltip: 'Add Task',
        child: Icon(
          FontAwesomeIcons.calendarPlus,
          color: Colors.white,
          size: 24.0,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 100),
          Container(
            height: 250.0,
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SvgPicture.asset("images/empty.svg"),
          ),
          SizedBox(height: 20),
          Text(
            "You have a free day!",
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 5),
          Text(
            "Add more tasks by pressing the floating button!",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}

class AppBarCalendar extends StatelessWidget {
  const AppBarCalendar({
    @required Function onSelectDay,
    @required CalendarController calendarController,
  })  : _calendarController = calendarController,
        _onSelectDay = onSelectDay;

  final CalendarController _calendarController;
  final Function _onSelectDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: const TextStyle(color: const Color(0xFF616161)),
      ),
      calendarController: _calendarController,
      headerVisible: false,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      initialCalendarFormat: CalendarFormat.week,
      availableCalendarFormats: const {CalendarFormat.week: 'Week'},
      calendarStyle: CalendarStyle(
        weekdayStyle: kCalendarTextStyle,
        weekendStyle: kCalendarTextStyle,
        outsideStyle: kCalendarTextStyle,
        outsideWeekendStyle: kCalendarTextStyle,
        selectedColor: Colors.blueAccent,
        todayColor: Color(0xFF2F2E40),
        outsideDaysVisible: false,
      ),
      onDaySelected: _onSelectDay,
    );
  }
}
