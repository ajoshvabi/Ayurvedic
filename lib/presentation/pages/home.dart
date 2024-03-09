import 'package:ayurvedic/data/api.dart';
import 'package:ayurvedic/presentation/pages/reg.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final String token;

  const Home({Key? key, required this.token}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final sort = ["Date", "Price"];
    ApiClient api = ApiClient();

    String? selectedsort;
    selectedsort = sort.isNotEmpty ? sort.first : null;
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black38),
                        cursorColor: Colors.black87,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: "Search for treatment",
                          labelStyle: const TextStyle(color: Colors.black38),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.black87),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          prefixIcon: const Icon(Icons.search),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 19, 93, 21),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("Search"),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                      child: Text(
                        "Sort by:",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 35,
                      child: DropdownButtonFormField(
                        borderRadius: BorderRadius.circular(15),
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 3.0,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelStyle: TextStyle(color: Colors.black54),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                        ),
                        items: sort
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: SizedBox(
                                    width: 50,
                                    child: Text(
                                      e,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black54),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedsort,
                        onChanged: (val) {},
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 0,
                thickness: 0.5,
                color: Colors.black45,
              ),
              StreamBuilder<Map<String, dynamic>>(
                stream: api.fetchDataAsStream(token),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final data = snapshot.data!;
                  final List<dynamic> branches = data['branches'];
                  return Column(
                    children: branches
                        .map((branchdata) => booking(branchdata))
                        .toList(),
                  );
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Reg()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 19, 93, 21),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text("Register"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column booking(branchdata) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                    // height: 100,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 235, 235, 235),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "1.",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  branchdata["name"],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  branchdata["address"],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      height: 1.5),
                                ),
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "31/10./2",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.group_outlined,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "31/10./2",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                          height: 15,
                          thickness: 0.5,
                          color: Colors.black45,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "View Booking details ",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
