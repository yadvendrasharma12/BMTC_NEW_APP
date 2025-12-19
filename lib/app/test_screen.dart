//
// import 'package:bmtc_app/app/core/text_style.dart';
// import 'package:flutter/material.dart';
// import '../../../models/profile_data_model.dart' as api;
//
// class EditLabSection extends StatefulWidget {
//   final List<api.Lab> apiLabs;
//   const EditLabSection({super.key, required this.apiLabs});
//
//   @override
//   State<EditLabSection> createState() => _EditLabSectionState();
// }
//
// class _EditLabSectionState extends State<EditLabSection> {
//
//   final _formKey = GlobalKey<FormState>();
//   List<Map<String, String?>> editableLabs = [];
//   final TextEditingController centerNameCtrl = TextEditingController();
//   final TextEditingController description = TextEditingController();
//   final TextEditingController addressCtrl = TextEditingController();
//   final TextEditingController centerType = TextEditingController();
//   final TextEditingController centerLat = TextEditingController();
//   final TextEditingController centerLong = TextEditingController();
//   final TextEditingController capacity = TextEditingController();
//   final TextEditingController localAreaName = TextEditingController();
//   final TextEditingController pincode = TextEditingController();
//   final TextEditingController landmark = TextEditingController();
//   final TextEditingController railwayS = TextEditingController();
//   final TextEditingController busStop = TextEditingController();
//   final TextEditingController metro = TextEditingController();
//   final TextEditingController airport = TextEditingController();
//   final TextEditingController pointOfContactName = TextEditingController();
//   final TextEditingController pointOfContactNumber = TextEditingController();
//   final TextEditingController altPointOfContactNumber = TextEditingController();
//   final TextEditingController pointOfContactEmail = TextEditingController();
//   final TextEditingController csName = TextEditingController();
//   final TextEditingController csNumber = TextEditingController();
//   final TextEditingController csEmail = TextEditingController();
//
//   final TextEditingController pocName = TextEditingController();
//   final TextEditingController pocEmail = TextEditingController();
//   final TextEditingController pocNumber = TextEditingController();
//   final TextEditingController emergencyNo = TextEditingController();
//   final TextEditingController landLineNo = TextEditingController();
//   final TextEditingController primaryIsp = TextEditingController();
//   final TextEditingController totalLab = TextEditingController();
//   final TextEditingController totalSystem = TextEditingController();
//   final TextEditingController totalNetwork = TextEditingController();
//
//   final TextEditingController benifiryName = TextEditingController();
//   final TextEditingController bankName = TextEditingController();
//   final TextEditingController bankAccount = TextEditingController();
//   final TextEditingController ifsc = TextEditingController();
//   final TextEditingController panno = TextEditingController();
//   final TextEditingController gstNo = TextEditingController();
//   final TextEditingController gstStateCode = TextEditingController();
//   final TextEditingController uidiai = TextEditingController();
//   final TextEditingController MsmeNo = TextEditingController();
//   final TextEditingController internateSpeedPrimary = TextEditingController();
//   final TextEditingController internateSpeedSecondry = TextEditingController();
//   final TextEditingController secondryIsp = TextEditingController();
//   final TextEditingController generatorCapacity = TextEditingController();
//   final TextEditingController upsBackup = TextEditingController();
//
//
//
//   final TextEditingController totalLabCtrl = TextEditingController();
//   List<EditableLab> labs = [];
//
//
//   List<String> floors = [];
//   List<String> processors = [];
//   List<String> monitors = [];
//   List<String> rams = [];
//   List<String> hardDisks = [];
//   List<String> osList = [];
//   List<String> ethernetCompanies = []; // populate from API dynamically
//   List<String> switchCategories = [];
//   List<String> ethernetPorts = [];
//
//   List<String> floorOptions = ['Ground', '1st', '2nd', '3rd','4th','5th','6th','7th','8th','9th','10th',"Basement"];
//   final List<String> processor = ['Core 2 Duo','i3', 'i5', 'i7', 'i9'];
//   final List<String> monitor = ['LCD', 'LED', 'CRT'];
//   final List<String> oss = ['Win 7','Win 8', 'Win 10','Win 11','MacOS'];
//   final List<String> ram = ['2GB', '4GB','8GB', '16GB','32GB',];
//   final List<String> hardDisk = ['80GB', '128GB','160GB','256GB','512GB','1TB','2TB','4TB'];
//   final List<String> switchCompanies = ['Cisco','Netgear', 'TP-Link', 'D-Link','Dex','Others'];
//   final List<String> switchCategorie = ['Unmanaged', 'Smart','Managed L2','Managed L3'];
//   final List<String> switchParts = ['8','16','24','32'];
//   @override
//   void initState() {
//     super.initState();
//
//
//
//
//
//     labs = widget.apiLabs.map((lab) {
//       // Floor, processor, etc.
//       if (lab.floorName.isNotEmpty && !floors.contains(lab.floorName)) floors.add(lab.floorName);
//       if (lab.processer.isNotEmpty && !processors.contains(lab.processer)) processors.add(lab.processer);
//       if (lab.monitorType.isNotEmpty && !monitors.contains(lab.monitorType)) monitors.add(lab.monitorType);
//       if (lab.ram.isNotEmpty && !rams.contains(lab.ram)) rams.add(lab.ram);
//       if (lab.hardDisk.isNotEmpty && !hardDisks.contains(lab.hardDisk)) hardDisks.add(lab.hardDisk);
//       if (lab.operatingSystem.isNotEmpty && !osList.contains(lab.operatingSystem)) osList.add(lab.operatingSystem);
//
//       // ⚡ Ethernet fields
//       if (lab.ehternetSwtchCompany.isNotEmpty && !ethernetCompanies.contains(lab.ehternetSwtchCompany)) {
//         ethernetCompanies.add(lab.ehternetSwtchCompany);
//       }
//       if (lab.switchCategory.isNotEmpty && !switchCategories.contains(lab.switchCategory)) {
//         switchCategories.add(lab.switchCategory);
//       }
//       if (lab.noOfPortEthSwitch.isNotEmpty && !ethernetPorts.contains(lab.noOfPortEthSwitch)) {
//         ethernetPorts.add(lab.noOfPortEthSwitch);
//       }
//
//       return EditableLab(
//         floor: lab.floorName ?? '',
//         computers: lab.noOfComputer ?? '',
//         processor: lab.processer ?? '',
//         monitor: lab.monitorType ?? '',
//         os: lab.operatingSystem ?? '',
//         ram: lab.ram ?? '',
//         hardDisk: lab.hardDisk ?? '',
//         ethernetSwitchCompany: lab.ehternetSwtchCompany ?? '',
//         switchCategory: lab.switchCategory ?? '',
//         noOfPorts: lab.noOfPortEthSwitch ?? '',
//       );
//     }).toList();
//
//     if (labs.isEmpty) labs.add(EditableLab());
//     totalLabCtrl.text = labs.length.toString();
//   }
//
//   void _onLabCountChanged(String value) {
//     final count = int.tryParse(value) ?? 1;
//     setState(() {
//       if (count > labs.length) {
//         labs.addAll(List.generate(count - labs.length, (_) => EditableLab()));
//       } else {
//         labs = labs.take(count).toList();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F7FB),
//       appBar: AppBar(title: const Text("Edit Labs")),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text("Total Labs", style: TextStyle(fontWeight: FontWeight.bold)),
//               const SizedBox(height: 6),
//               TextField(
//                 controller: totalLabCtrl,
//                 keyboardType: TextInputType.number,
//                 onChanged: _onLabCountChanged,
//                 decoration: _inputDecoration("Enter number of labs"),
//               ),
//               const SizedBox(height: 20),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: labs.length,
//                 itemBuilder: (context, index) => _labCard(index),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _updateLabs,
//                   child: const Text("Update Labs"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _labCard(int index) {
//     final lab = labs[index];
//
//     List<String> _buildDropdownItems(String value, List<String> list) {
//       final List<String> tempList = List.from(list);
//       if (value.isNotEmpty && !tempList.contains(value)) {
//         tempList.insert(0, value); // API value top pe
//       }
//       return tempList;
//     }
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 40,
//             width: 134,
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Lab Number ${index + 1}", style: AppTextStyles.button),
//                 if (labs.length > 1)
//                   IconButton(
//                     icon: const Icon(Icons.delete, color: Colors.red),
//                     onPressed: () {
//                       setState(() {
//                         labs.removeAt(index);
//                         totalLabCtrl.text = labs.length.toString();
//                       });
//                     },
//                   ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 12),
//
//           // Floor
//           Text("Floor Name", style: AppTextStyles.centerText),
//           SizedBox(height: 5),
//           _dropdown(
//             "Select Floor",
//             lab.floor,
//             _buildDropdownItems(lab.floor, floorOptions),
//                 (v) => lab.floor = v,
//           ),
//
//           // Computers
//           Text("Total number of computers?", style: AppTextStyles.centerText),
//           SizedBox(height: 5),
//           _textField("", lab.computers, (v) => lab.computers = v),
//
//           // Processor
//           Text("System Processor", style: AppTextStyles.centerText),
//           SizedBox(height: 5),
//           _dropdown(
//             "Select Processor",
//             lab.processor,
//             _buildDropdownItems(lab.processor, processor),
//                 (v) => lab.processor = v,
//           ),
//
//           // Monitor
//           Text("Monitor Type", style: AppTextStyles.centerText),
//           SizedBox(height: 5),
//           _dropdown(
//             "Select Monitor",
//             lab.monitor,
//             _buildDropdownItems(lab.monitor, monitor),
//                 (v) => lab.monitor = v,
//           ),
//
//           // OS
//           Text("Operating System", style: AppTextStyles.centerText),
//           SizedBox(height: 5),
//           _dropdown(
//             "Select OS",
//             lab.os,
//             _buildDropdownItems(lab.os, oss),
//                 (v) => lab.os = v,
//           ),
//
//           // RAM
//           Text("RAM (in GB)", style: AppTextStyles.centerText),
//           SizedBox(height: 5),
//           _dropdown(
//             "Select RAM",
//             lab.ram,
//             _buildDropdownItems(lab.ram, ram),
//                 (v) => lab.ram = v,
//           ),
//
//           // Hard Disk
//           Text("Hard Disk Drive Capacity (in GB)", style: AppTextStyles.centerText),
//           SizedBox(height: 5),
//           _dropdown(
//             "Select Hard Disk",
//             lab.hardDisk,
//             _buildDropdownItems(lab.hardDisk, hardDisk),
//                 (v) => lab.hardDisk = v,
//           ),
//
//           // Ethernet Switch Company
//           Text("Ethernet Switch Company", style: AppTextStyles.centerText),
//           SizedBox(height: 5),
//           _dropdown(
//             "Select Company",
//             lab.ethernetSwitchCompany,
//             _buildDropdownItems(lab.ethernetSwitchCompany, switchCompanies),
//                 (v) => lab.ethernetSwitchCompany = v,
//           ),
//
//           // Switch Category
//           Text("Switch Category", style: AppTextStyles.centerText),
//           SizedBox(height: 5),
//           _dropdown(
//             "Select Category",
//             lab.switchCategory,
//             _buildDropdownItems(lab.switchCategory, switchCategorie),
//                 (v) => lab.switchCategory = v,
//           ),
//
//           // No. of Ports
//           Text("No. of Ports", style: AppTextStyles.centerText),
//           SizedBox(height: 5),
//           _dropdown(
//             "Select Ports",
//             lab.noOfPorts,
//             _buildDropdownItems(lab.noOfPorts, switchParts),
//                 (v) => lab.noOfPorts = v,
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget _dropdown(String label, String value, List<String> items, Function(String) onChanged) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: DropdownButtonFormField<String>(
//         value: items.contains(value) ? value : null,
//         decoration: _inputDecoration(label),
//         items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//         onChanged: (v) => onChanged(v ?? ''),
//       ),
//     );
//   }
//
//   Widget _textField(String label, String value, Function(String) onChanged) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextFormField(
//         initialValue: value,
//         keyboardType: TextInputType.number,
//         decoration: _inputDecoration(label),
//         onChanged: onChanged,
//       ),
//     );
//   }
//
//   InputDecoration _inputDecoration(String hint) {
//     return InputDecoration(
//       hintText: hint,
//       filled: true,
//       fillColor: const Color(0xFFF6F7FB),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }
//
//   void _updateLabs() {
//     final payload = labs.map((e) => e.toJson()).toList();
//     debugPrint("Payload: $payload");
//     // Call your API here
//   }
// }
//
// /// ================= MODEL =================
// class EditableLab {
//   String floor;
//   String computers;
//   String processor;
//   String monitor;
//   String os;
//   String ram;
//   String hardDisk;
//   String ethernetSwitchCompany;
//   String switchCategory;
//   String noOfPorts;
//
//   EditableLab({
//     this.floor = '',
//     this.computers = '',
//     this.processor = '',
//     this.monitor = '',
//     this.os = '',
//     this.ram = '',
//     this.hardDisk = '',
//     this.ethernetSwitchCompany = '',
//     this.switchCategory = '',
//     this.noOfPorts = '',
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       "floor_name": floor,
//       "no_of_computer": computers,
//       "window_generation": processor,
//       "monitor_type": monitor,
//       "operating_system": os,
//       "ram": ram,
//       "hard_disk": hardDisk,
//       "ethernet_swtch_company": ethernetSwitchCompany,
//       "switch_category": switchCategory,
//       "no_of_ethernet_switch": noOfPorts,
//     };
//   }
// }
//
