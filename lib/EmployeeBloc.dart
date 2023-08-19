
// TODO: imports

// TODO: List of Employees

// TODO: Stream Controllers

// TODO: Stream Sink getter

// TODO: Constructor - add data; Listen to Changes

// TODO: Core Functions

// TODO: dispose


import 'dart:async';
import 'Employee.dart';

class EmployeeBloc{
   // sink to add in pipe
   // stream to get data

  List<Employee> _employeeList = [
    Employee(1,"Employee One", 10000.0),
    Employee(2,"Employee Two", 20000.0),
    Employee(3,"Employee Three", 30000.0),
    Employee(4,"Employee Four", 40000.0),
    Employee(5,"Employee Five", 50000.0),
  ];


  final _employeeListStreamController = StreamController<List<Employee>>();

  final _employeeIncrementStreamController = StreamController<Employee>();

  final _employeeDecrementStreamController = StreamController<Employee>();

  // Getters

  Stream<List<Employee>> get employeeListStream => _employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink => _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryDecrementSink => _employeeDecrementStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrementSink => _employeeIncrementStreamController.sink;


  EmployeeBloc(){
    _employeeListStreamController.add(_employeeList);

    _employeeIncrementStreamController.stream.listen(_incrementSalary);
    _employeeDecrementStreamController.stream.listen(_decrementSalary);
  }


  _incrementSalary(Employee employee){
    double base = employee.salary;

    double increment = base * 20/100;

    _employeeList[employee.id-1].salary = base + increment;

    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee){
    double base = employee.salary;

    double decrement = base * 20/100;

    _employeeList[employee.id-1].salary = base - decrement;

    employeeListSink.add(_employeeList);
  }

  void dispose(){
    _employeeDecrementStreamController.close();
    _employeeIncrementStreamController.close();
    _employeeListStreamController.close();
  }
}