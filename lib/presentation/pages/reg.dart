import 'dart:developer';
import 'dart:io';

import 'package:ayurvedic/data/api.dart';
import 'package:ayurvedic/presentation/widgets/customtextfiel.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class Reg extends StatefulWidget {
  final String token;

  const Reg({Key? key, required this.token}) : super(key: key);

  @override
  _RegState createState() => _RegState(token);
}

class PatientData {
  String? treatment;
  int? male;
  int? female;

  PatientData({this.treatment, this.male, this.female});
}

class _RegState extends State<Reg> {
  final String token;

  _RegState(this.token);
  String? selectedPaymentOption;
  String? branchof;
  String? location;
  String? treatment;
  late TextEditingController nameController;
  late TextEditingController whatsappController;
  late TextEditingController addressController;
  late TextEditingController locationController;
  late TextEditingController branchController;
  late TextEditingController totalAmountController;
  late TextEditingController discountAmountController;
  late TextEditingController advanceAmountController;
  late TextEditingController balanceAmountController;
  late TextEditingController treatmentDateController;
  late TextEditingController treatmentController;
  late TextEditingController femalecontroller;
  late TextEditingController malecontroller;
  late TimeOfDay selectedTime;
  List<PatientData> patientList = [];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    whatsappController = TextEditingController();
    addressController = TextEditingController();
    locationController = TextEditingController();
    branchController = TextEditingController();
    totalAmountController = TextEditingController();
    discountAmountController = TextEditingController();
    advanceAmountController = TextEditingController();
    balanceAmountController = TextEditingController();
    treatmentDateController = TextEditingController();
    treatmentController = TextEditingController();
    malecontroller = TextEditingController();
    femalecontroller = TextEditingController();
    selectedTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    ApiClient api = ApiClient();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.black,
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Registration',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                text: "Name",
                controller: nameController,
                labelText: "Enter Your Full Name",
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                text: "Whatsapp number",
                controller: whatsappController,
                labelText: "Enter Whatsapp number",
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                text: "Address",
                controller: addressController,
                labelText: "Enter Your Address",
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, bottom: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Location",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  StreamBuilder<Map<String, dynamic>>(
                    stream: api.fetchDataAsStream(token),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;

                        final List<dynamic> branches = data['branches'];

                        return DropdownButtonFormField<String>(
                          items:
                              branches.map<DropdownMenuItem<String>>((branch) {
                            return DropdownMenuItem<String>(
                              value: branch['id'].toString(),
                              child: Text(branch['name']),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              location = value;
                              print(location);
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            labelText: "Select Location",
                            labelStyle: const TextStyle(color: Colors.black38),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.black87),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, bottom: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Branch",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  StreamBuilder<Map<String, dynamic>>(
                    stream: api.fetchDataAsStream(token),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;

                        final List<dynamic> branches = data['branches'];

                        return DropdownButtonFormField<String>(
                          items:
                              branches.map<DropdownMenuItem<String>>((branch) {
                            return DropdownMenuItem<String>(
                              value: branch['id'].toString(),
                              child: Text(branch['name']),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              branchof = value;
                              print('Selected branch ID: $branchof');
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            labelText: "Select Branch",
                            labelStyle: const TextStyle(color: Colors.black38),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.black87),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  patientList.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: patientList.length,
                          itemBuilder: (context, index) {
                            PatientData patient = patientList[index];
                            return ListTile(
                              subtitle: Container(
                                padding: const EdgeInsets.all(10),
                                color: const Color.fromARGB(255, 247, 247, 247),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${patient.treatment}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                patientList.removeAt(index);
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("Male"),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: const EdgeInsets.only(
                                                top: 6,
                                                bottom: 6,
                                                left: 9,
                                                right: 14),
                                            child: Text(' ${patient.male}')),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        const Text('Female'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: const EdgeInsets.only(
                                                top: 6,
                                                bottom: 6,
                                                left: 9,
                                                right: 14),
                                            child: Text(' ${patient.female}')),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Container(),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Add Patient'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StreamBuilder<Map<String, dynamic>>(
                                    stream: api.fetchTretement(token),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final data = snapshot.data!;

                                        if (data.containsKey('treatments') &&
                                            data['treatments'] != null) {
                                          final List<dynamic> treatments =
                                              data['treatments'];

                                          return DropdownButtonFormField<
                                              String>(
                                            items: treatments
                                                .map<DropdownMenuItem<String>>(
                                                    (treatment) {
                                              return DropdownMenuItem<String>(
                                                value: treatment['name'],
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.50,
                                                  child:
                                                      Text(treatment['name']),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                treatment = value;
                                                print(
                                                    'Selected treatment ID: $branchof');
                                              });
                                            },
                                            decoration: InputDecoration(
                                              filled: true,
                                              labelText: "Select treatment",
                                              labelStyle: const TextStyle(
                                                  color: Colors.black38),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.black87),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255)),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return const Text(
                                              'No treatments available.');
                                        }
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  const Text("Add Patients"),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      const SizedBox(
                                          width: 100, child: Text("Male")),
                                      Expanded(
                                        child: SizedBox(
                                          width: 25,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40),
                                            child: TextField(
                                              controller: malecontroller,
                                              style: const TextStyle(
                                                  color: Colors.black38),
                                              cursorColor: Colors.black87,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 0,
                                                        horizontal: 10),
                                                filled: true,
                                                labelStyle: const TextStyle(
                                                    color: Colors.black38),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.black87),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: const BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      const SizedBox(
                                          width: 100, child: Text("Female")),
                                      Expanded(
                                        child: SizedBox(
                                          width: 25,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40),
                                            child: TextField(
                                              controller: femalecontroller,
                                              style: const TextStyle(
                                                  color: Colors.black38),
                                              cursorColor: Colors.black87,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 0,
                                                        horizontal: 10),
                                                filled: true,
                                                labelStyle: const TextStyle(
                                                    color: Colors.black38),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.black87),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: const BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              patientList.add(PatientData(
                                                treatment: treatment,
                                                male: int.parse(
                                                    malecontroller.text),
                                                female: int.parse(
                                                    femalecontroller.text),
                                              ));
                                            });
                                            print(patientList);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 19, 93, 21),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(15.0),
                                            child: Text("Saver"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(154, 104, 212, 109),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "+ Add treatments",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                text: "Total amount",
                controller: totalAmountController,
                labelText: "Enter Total Amount",
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                text: "Discount amount",
                controller: discountAmountController,
                labelText: "Enter Discount Amount",
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                text: "Advance amount",
                controller: advanceAmountController,
                labelText: "Enter Advance Amount",
                obscureText: false,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Payment options",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text('Cash'),
                          value: 'Cash',
                          groupValue: selectedPaymentOption,
                          onChanged: (value) {
                            setState(() {
                              selectedPaymentOption = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text('UPI'),
                          value: 'UPI',
                          groupValue: selectedPaymentOption,
                          onChanged: (value) {
                            setState(() {
                              selectedPaymentOption = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text('Card'),
                          value: 'Card',
                          groupValue: selectedPaymentOption,
                          onChanged: (value) {
                            setState(() {
                              selectedPaymentOption = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                text: "Balance amount",
                controller: balanceAmountController,
                labelText: "Enter Balance Amount",
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, bottom: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Treatment date",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 243, 243, 243),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black38,
                          width: 1.5,
                        ),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              treatmentDateController.text.isEmpty
                                  ? 'Select Date'
                                  : treatmentDateController.text,
                              style: const TextStyle(color: Colors.black38),
                            ),
                          ),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, bottom: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Treatment Time",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _selectTime(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black38,
                          width: 1.5,
                        ),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              ' ${selectedTime.format(context)}',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          const Icon(Icons.access_time),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        generatePDFWithTextField('Sample Text');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 19, 93, 21),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text("Save"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        String formattedDate = "${picked.day}-${picked.month}-${picked.year}";
        log(formattedDate);
        treatmentDateController.text = formattedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> generatePDFWithTextField(String text) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Center(
            child: pw.Text(text, style: const pw.TextStyle(fontSize: 20)),
          );
        },
      ),
    );

    final output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(await pdf.save());

    OpenFile.open(file.path);

    print('PDF Generated');
  }
}
