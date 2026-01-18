import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/nutrition_provider.dart';
import '../models/food_entry.dart';


class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _fatController = TextEditingController();
  final _carbsController = TextEditingController();

  MealType _selectedMealType = MealType.breakfast;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Provider.of<NutritionProvider>(context, listen: false).addEntry(
        _nameController.text,
        int.parse(_caloriesController.text),
        int.parse(_proteinController.text),
        int.parse(_fatController.text),
        int.parse(_carbsController.text),
        _selectedMealType,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ДОБАВИТЬ ЗАПИСЬ')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Meal Type Selector
              DropdownButtonFormField<MealType>(
                value: _selectedMealType,
                dropdownColor: const Color(0xFF1E1E1E),
                style: const TextStyle(color: Colors.white, fontFamily: 'Courier'),
                decoration: const InputDecoration(labelText: 'ПРИЕМ ПИЩИ'),
                items: MenuItems.mealTypes,
                onChanged: (value) {
                  setState(() {
                    _selectedMealType = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              
              _buildInput(_nameController, "НАЗВАНИЕ", false),
              const SizedBox(height: 16),
              _buildInput(_caloriesController, "КАЛОРИИ", true),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildInput(_proteinController, "БЕЛКИ (г)", true)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildInput(_fatController, "ЖИРЫ (г)", true)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildInput(_carbsController, "УГЛЕВОДЫ (г)", true)),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('ДОБАВИТЬ', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String label, bool isNumeric) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white, fontFamily: 'Courier'),
      validator: (value) => value == null || value.isEmpty ? 'ОБЯЗАТЕЛЬНО' : null,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}

class MenuItems {
  static List<DropdownMenuItem<MealType>> get mealTypes {
    const map = {
      MealType.breakfast: 'Завтрак',
      MealType.lunch: 'Обед',
      MealType.dinner: 'Ужин',
      MealType.snack: 'Перекус',
    };
    
    return MealType.values.map((type) {
      return DropdownMenuItem(
        value: type,
        child: Text(map[type]!),
      );
    }).toList();
  }
}
