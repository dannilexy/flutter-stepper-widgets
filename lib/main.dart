import 'package:flutter/material.dart';

void main() => runApp(MyApp());
int currentStep = 0;
bool isCompleted = false;

final firstname = TextEditingController();
final lastname = TextEditingController();
final address = TextEditingController();
final postalCode = TextEditingController();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override // StatelessWidget must override build()
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stateless & Stateful',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Stepper Widgets"),
          centerTitle: true,
        ),
        body: isCompleted
            ? buildCompleted()
            : Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(primary: Colors.red)),
                child: Stepper(
                  type: StepperType.horizontal,
                  steps: getSteps(),
                  currentStep: currentStep,
                  onStepContinue: () {
                    final isLastStep = currentStep == getSteps().length - 1;
                    if (isLastStep) {
                      setState(() => isCompleted = true);
                      print("Completed");

                      //Send Data To server
                    } else {
                      setState(() => currentStep += 1);
                    }
                  },
                  onStepTapped: (step) => setState(() => currentStep = step),
                  onStepCancel: () {
                    currentStep == 0 ? null : setState(() => currentStep -= 1);
                  },
                  controlsBuilder: (context, {onStepContinue, onStepCancel}) {
                    final isLastStep = currentStep == getSteps().length - 1;
                    return Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                            child: Text(isLastStep ? "Confirm" : "Next"),
                            onPressed: onStepContinue,
                          )),
                          const SizedBox(
                            width: 12,
                          ),
                          if (currentStep != 0)
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: onStepCancel,
                                    child: Text("Back")))
                        ],
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}

buildCompleted() {
  return Container(
    child: Card(
      child: Column(
        children: [
          Image.asset('assets/good.png'),
        ],
      ),
    ),
  );
}

List<Step> getSteps() => [
      Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text("Account"),
          content: Column(
            children: [
              TextFormField(
                controller: firstname,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextFormField(
                controller: lastname,
                decoration: InputDecoration(labelText: 'Last Name'),
              )
            ],
          )),
      Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text("Address"),
          content: Column(
            children: [
              TextFormField(
                controller: address,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextFormField(
                controller: postalCode,
                decoration: InputDecoration(labelText: 'Postal Code'),
              )
            ],
          )),
      Step(
          isActive: currentStep >= 2,
          title: Text("Complete"),
          content: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text("First Name: "),
                      Text(firstname.value.text),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Last Name: ",
                      ),
                      Text(lastname.value.text),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Address : "),
                      Text(address.value.text),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Postal: "),
                      Text(postalCode.value.text),
                    ],
                  )
                ],
              ),
            ],
          )),
    ];
