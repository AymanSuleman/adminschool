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

  String selectedMonth = 'January'; // Default selected month

  @override
  Widget build(BuildContext context) {
    int totalPresent = students.where((s) => s['present']).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Static Class Heading
            Center(
              child: Text(
                'Attendance for 10 Class-A',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Month Selection Dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Month:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedMonth,
                  items: [
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
                  ].map((month) {
                    return DropdownMenuItem<String>(
                      value: month,
                      child: Text(month),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedMonth = newValue!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Submit Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final presentCount =
                        students.where((s) => s['present']).length;
                    final absentCount =
                        students.where((s) => s['absent']).length;

                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Attendance Summary'),
                        content: Text(
                            'Class: 10 Class-A\nPresent: $presentCount\nAbsent: $absentCount'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  child: const Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MonthlyAttendanceScreen(
                          students: students,
                          selectedMonth:
                              selectedMonth, // Passing selected month
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  child: const Text('View Monthly Attendance'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Attendance Headers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
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
            const Divider(),

            // Attendance List
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal,
                        child: Text(
                          student['name'][0],
                          style: const TextStyle(color: Colors.white),
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

            // Total Attendance Display
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Total Present: $totalPresent',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MonthlyAttendanceScreen extends StatelessWidget {
  final List<Map<String, dynamic>> students;
  final String selectedMonth;

  MonthlyAttendanceScreen(
      {required this.students, required this.selectedMonth});

  @override
  Widget build(BuildContext context) {
    // Mock monthly attendance data
    final Map<String, List<String>> monthlyData = {
      for (var student in students)
        student['name']:
            List.generate(30, (index) => index % 2 == 0 ? 'P' : 'A'),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Attendance'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Month Header
            Text(
              'Attendance for $selectedMonth',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Monthly Attendance Data
            Expanded(
              child: ListView(
                children: monthlyData.entries.map((entry) {
                  // Calculate totals for each student
                  final totalPresent =
                      entry.value.where((status) => status == 'P').length;
                  final totalAbsent =
                      entry.value.where((status) => status == 'A').length;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(entry.key),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Attendance: ${entry.value.join(', ')}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Total Present: $totalPresent, Total Absent: $totalAbsent',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
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
