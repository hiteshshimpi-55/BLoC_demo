import 'package:flutter/material.dart';
import 'Employee.dart';
import 'EmployeeBloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    _employeeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BlocDemo"),
      ),
      body: Container(
          child: StreamBuilder<List<Employee>>(
        stream: _employeeBloc.employeeListStream,
        builder:
            ((BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Employee data = snapshot.data![index];
              return Card(
                  elevation: 5.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "${data.id}",
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "${data.name}",
                              style: const TextStyle(fontSize: 20.0),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "₹ ${data.salary}",
                              style: const TextStyle(fontSize: 20.0),
                            ),
                          )
                        ],
                      ),
                      Container(
                        child: IconButton(
                          icon: const Icon(Icons.thumb_up),
                          color: Colors.green,
                          onPressed: (){
                            _employeeBloc.employeeSalaryIncrementSink.add(data);
                          },
                        )
                      ),
                      Container(
                        child: IconButton(
                          icon: const Icon(Icons.thumb_down),
                          color: Colors.red,
                          onPressed: (){
                            _employeeBloc.employeeSalaryDecrementSink.add(data);
                          },
                        )
                      )
                    ],
                  ));
            },
          );
        }),
      )),
    );
  }
}
