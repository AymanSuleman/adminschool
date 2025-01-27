// // import 'package:flutter/material.dart';

// // class Addhomework extends StatefulWidget {
// //   const Addhomework({super.key});

// //   @override
// //   State<Addhomework> createState() => _AddhomeworkState();
// // }

// // class _AddhomeworkState extends State<Addhomework> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return const Placeholder();
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class AddHomeworkScreen extends StatefulWidget {
//   @override
//   _AddHomeworkScreenState createState() => _AddHomeworkScreenState();
// }

// class _AddHomeworkScreenState extends State<AddHomeworkScreen> {
//   final _titleController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   DateTime? _selectedDate;

//   void _submitHomework() {
//     if (_titleController.text.isEmpty ||
//         _descriptionController.text.isEmpty ||
//         _selectedDate == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please fill in all fields")),
//       );
//       return;
//     }

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Homework added successfully!")),
//     );

//     // You can add logic to save homework to a database here
//   }

//   void _pickDate() async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );

//     if (pickedDate != null) {
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Add Homework")),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Title", style: TextStyle(fontSize: 16)),
//             TextField(
//               controller: _titleController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "Enter homework title",
//               ),
//             ),
//             SizedBox(height: 10),
//             Text("Description", style: TextStyle(fontSize: 16)),
//             TextField(
//               controller: _descriptionController,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "Enter description",
//               ),
//             ),
//             SizedBox(height: 10),
//             Text("Due Date", style: TextStyle(fontSize: 16)),
//             GestureDetector(
//               onTap: _pickDate,
//               child: Container(
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: Text(
//                   _selectedDate == null
//                       ? "Select Due Date"
//                       : DateFormat('yyyy-MM-dd').format(_selectedDate!),
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _submitHomework,
//                 child: Text("Add Homework"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddHomeworkScreen extends StatefulWidget {
  const AddHomeworkScreen({Key? key}) : super(key: key);

  @override
  _AddHomeworkScreenState createState() => _AddHomeworkScreenState();
}

class _AddHomeworkScreenState extends State<AddHomeworkScreen> {
  // Controllers for form fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Variable to store the selected due date
  DateTime? _selectedDate;

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Function to handle form submission
  void _submitHomework() {
    // Validate if all fields are filled
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    // Show success message (you can add logic to save to a database here)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Homework added successfully!")),
    );

    // Clear the form after submission
    _titleController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedDate = null;
    });
  }

  // Function to pick a due date using DatePicker
  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Homework")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title field
            const Text("Title", style: TextStyle(fontSize: 16)),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter homework title",
              ),
            ),
            const SizedBox(height: 10),

            // Description field
            const Text("Description", style: TextStyle(fontSize: 16)),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter description",
              ),
            ),
            const SizedBox(height: 10),

            // Due Date field with a DatePicker
            const Text("Due Date", style: TextStyle(fontSize: 16)),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                //   _selectedDate == null
                //       ? "Select Due Date"
                //       : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                //   style: const TextStyle(fontSize: 16),
                DateFormat('yyyy-MM-dd').format(_selectedDate ?? DateTime.now())

                ),
              ),
            ),
            const SizedBox(height: 20),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitHomework,
                child: const Text("Add Homework"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
