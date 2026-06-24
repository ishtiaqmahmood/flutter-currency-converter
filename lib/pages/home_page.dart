import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:currency_converter/controllers/currency_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final amountController = TextEditingController();

  final currencies = ["USD", "BDT", "EUR", "GBP", "INR", "JPY", "AUD"];

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CurrencyController>(context);

    return Scaffold(
      backgroundColor: const Color(0xff101820),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Text(
                "Currency Converter",

                style: TextStyle(
                  fontSize: 32,

                  fontWeight: FontWeight.bold,

                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.all(25),

                decoration: BoxDecoration(
                  color: const Color(0xff1E2A38),

                  borderRadius: BorderRadius.circular(25),
                ),

                child: Column(
                  children: [
                    Text(
                      "${controller.result.toStringAsFixed(2)} ${controller.toCurrency}",

                      style: const TextStyle(
                        fontSize: 35,

                        fontWeight: FontWeight.bold,

                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: amountController,

                      keyboardType: TextInputType.number,

                      style: const TextStyle(color: Colors.white),

                      decoration: InputDecoration(
                        hintText: "Enter amount",

                        hintStyle: const TextStyle(color: Colors.grey),

                        prefixIcon: const Icon(
                          Icons.money,
                          color: Colors.greenAccent,
                        ),

                        filled: true,

                        fillColor: Colors.black26,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),

                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: dropdown(controller.fromCurrency, (value) {
                            controller.changeFrom(value);
                          }),
                        ),

                        IconButton(
                          onPressed: controller.swap,

                          icon: const Icon(
                            Icons.swap_horiz,

                            color: Colors.greenAccent,

                            size: 35,
                          ),
                        ),

                        Expanded(
                          child: dropdown(controller.toCurrency, (value) {
                            controller.changeTo(value);
                          }),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,

                      height: 55,

                      child: ElevatedButton(
                        onPressed: () {
                          final amount = double.tryParse(amountController.text);

                          if (amount != null) {
                            controller.convert(amount);
                          }
                        },

                        child: controller.loading
                            ? const CircularProgressIndicator()
                            : const Text(
                                "Convert",

                                style: TextStyle(fontSize: 20),
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              if (controller.error.isNotEmpty)
                Text(
                  controller.error,

                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropdown(String value, Function(String) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,

      dropdownColor: Colors.black,

      items: currencies
          .map(
            (e) => DropdownMenuItem(
              value: e,

              child: Text(e, style: const TextStyle(color: Colors.white)),
            ),
          )
          .toList(),

      onChanged: (v) => onChanged(v!),

      decoration: InputDecoration(
        filled: true,

        fillColor: Colors.black26,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
