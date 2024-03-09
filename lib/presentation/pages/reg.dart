import 'package:flutter/material.dart';

class Reg extends StatelessWidget {
  const Reg({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                child: Text(
                  "Registration",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87),
                ),
              ),
            ],
          ),
          Divider(
            height: 0,
            thickness: 0.5,
            color: Colors.black45,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [],
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
