import 'package:flutter/material.dart';

class BusBookingHome extends StatefulWidget {
  const BusBookingHome({super.key});

  @override
  _BusBookingHomeState createState() => _BusBookingHomeState();
}

class _BusBookingHomeState extends State<BusBookingHome> {
  final TextEditingController mobileController = TextEditingController();
  int ticketCount = 1;
  final int ticketPrice = 50; // Example price per ticket

  // Dropdown options for locations
  final List<String> locations = ['City A', 'City B', 'City C', 'City D'];
  String? selectedFrom;
  String? selectedTo;

  // Controllers for passenger names and gender selection
  List<TextEditingController> nameControllers = [];
  List<String?> selectedGenders = [];

  @override
  void initState() {
    super.initState();
    _initializePassengerDetails();
  }

  // Initialize controllers and gender selection based on ticket count
  void _initializePassengerDetails() {
    nameControllers = List.generate(ticketCount, (_) => TextEditingController());
    selectedGenders = List.generate(ticketCount, (_) => null);
  }

  @override
  void dispose() {
    for (var controller in nameControllers) {
      controller.dispose();
    }
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int totalPrice = ticketPrice * ticketCount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Booking'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Book Your Bus',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // From Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'From',
                  border: OutlineInputBorder(),
                ),
                value: selectedFrom,
                items: locations
                    .map((location) => DropdownMenuItem(
                  value: location,
                  child: Text(location),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedFrom = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              // To Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'To',
                  border: OutlineInputBorder(),
                ),
                value: selectedTo,
                items: locations
                    .map((location) => DropdownMenuItem(
                  value: location,
                  child: Text(location),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedTo = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Mobile Number Input
              TextField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Number of Tickets Selector
              Row(
                children: [
                  const Text(
                    'Number of Tickets:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 20),
                  DropdownButton<int>(
                    value: ticketCount,
                    items: List.generate(10, (index) => index + 1)
                        .map((num) => DropdownMenuItem(
                      value: num,
                      child: Text(num.toString()),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        ticketCount = value ?? 1;
                        _initializePassengerDetails();
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Dynamic passenger details input fields
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ticketCount,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: nameControllers[index],
                            decoration: InputDecoration(
                              labelText: 'Name ${index + 1}',
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Gender',
                              border: OutlineInputBorder(),
                            ),
                            value: selectedGenders[index],
                            items: ['Male', 'Female']
                                .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedGenders[index] = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Price Display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Price:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${totalPrice.toString()}',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Book Now Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_validateInputs()) {
                      // Add booking logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Booking successful for $ticketCount ticket(s)!',
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all the details.'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 40),
                  ),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to validate the inputs
  bool _validateInputs() {
    if (selectedFrom == null ||
        selectedTo == null ||
        mobileController.text.isEmpty ||
        nameControllers.any((controller) => controller.text.isEmpty) ||
        selectedGenders.contains(null)) {
      return false;
    }
    return true;
  }
}
