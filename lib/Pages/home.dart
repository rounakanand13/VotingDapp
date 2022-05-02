// ignore_for_file: unused_import, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_is_empty, sized_box_for_whitespace
// ignore_for_file: prefer_const_constructors

import 'package:blockchainvotingapp/Pages/electioninfo.dart';
import 'package:blockchainvotingapp/services/functions.dart';
import 'package:blockchainvotingapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Client? httpClient;
  Web3Client? ethClient;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infura_url, httpClient!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(50),
                  child: Text(
                    'START ELECTION',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Enter Election Name",
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.text.length > 0) {
                    await startElection(controller.text, ethClient!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ElectionInfo(
                            ethClient: ethClient!,
                            electionName: controller.text),
                      ),
                    );
                  }
                },
                child: Text("Start Election"),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
