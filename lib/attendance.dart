
import 'package:flutter/material.dart';

void main() => runApp(AttendanceApp());

class AttendanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AttendanceScreen(),
    );
  }
}

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final List<Map<String, dynamic>> students = List.generate(
    10,
    (index) => {
      'name': 'Mohan ${index + 1}',
      'present': false,
      'absent': false,
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Static Class Heading
            Center(
              child: Text(
                'Attendance for 10 Class-A',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Attendance Headers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Student Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      'Present',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 30),
                    Text(
                      'Absent',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            Divider(),

            // Attendance List
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        child: Text(
                          student['name'][0],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(student['name']),
                      subtitle: Text(
                        student['present']
                            ? 'Status: Present'
                            : student['absent']
                                ? 'Status: Absent'
                                : 'Status: Not Marked',
                        style: TextStyle(
                          color: student['present']
                              ? Colors.green
                              : student['absent']
                                  ? Colors.red
                                  : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: student['present'],
                            onChanged: (value) {
                              setState(() {
                                student['present'] = value!;
                                if (value) {
                                  student['absent'] = false;
                                }
                              });
                            },
                          ),
                          Checkbox(
                            value: student['absent'],
                            onChanged: (value) {
                              setState(() {
                                student['absent'] = value!;
                                if (value) {
                                  student['present'] = false;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // View Monthly Attendance Button
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Students: ${students.length}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MonthlyAttendanceScreen(
                            students: students,
                          ),
                        ),
                      );
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                    child: Text(
                      'View Monthly Attendance',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MonthlyAttendanceScreen extends StatefulWidget {
  final List<Map<String, dynamic>> students;

  MonthlyAttendanceScreen({required this.students});

  @override
  _MonthlyAttendanceScreenState createState() =>
      _MonthlyAttendanceScreenState();
}

class _MonthlyAttendanceScreenState extends State<MonthlyAttendanceScreen> {
  String selectedMonth = 'January'; // Default selected month

  @override
  Widget build(BuildContext context) {
    // Mock monthly attendance data
    final Map<String, List<String>> monthlyData = {
      for (var student in widget.students)
        student['name']:
            List.generate(30, (index) => index % 2 == 0 ? 'P' : 'A'),
    };

    // Calculate overall totals for the month
    final totalPresent = monthlyData.values
        .expand((days) => days)
        .where((status) => status == 'P')
        .length;
    final totalAbsent = monthlyData.values
        .expand((days) => days)
        .where((status) => status == 'A')
        .length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Attendance'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Month Dropdown Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Month: $selectedMonth',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                  value: selectedMonth,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMonth = newValue!;
                    });
                  },
                  items: <String>[
                    'January',
                    'February',
                    'March',
                    'April',
                    'May',
                    'June',
                    'July',
                    'August',
                    'September',
                    'October',
                    'November',
                    'December'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Monthly Totals
            // Text(
            //   'Total Present: $totalPresent\nTotal Absent: $totalAbsent',
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 16,
            //   ),
            // ),
            SizedBox(height: 16),

            // Monthly Attendance Data
            Expanded(
              child: ListView(
                children: monthlyData.entries.map((entry) {
                  final totalPresent =
                      entry.value.where((status) => status == 'P').length;
                  final totalAbsent =
                      entry.value.where((status) => status == 'A').length;

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(entry.key),
                      subtitle: Text(
                        'Total Present: $totalPresent, Total Absent: $totalAbsent',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                  
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
