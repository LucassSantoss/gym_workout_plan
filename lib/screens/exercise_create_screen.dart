import 'package:flutter/material.dart';
import 'package:gym_workout_plan/database/db_helper.dart';
import 'package:gym_workout_plan/models/exercise.dart';

class ExerciseCreateScreen extends StatefulWidget {
  const ExerciseCreateScreen({super.key});

  @override
  State<ExerciseCreateScreen> createState() => _ExerciseCreateScreenState();
}

class _ExerciseCreateScreenState extends State<ExerciseCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _seriesController = TextEditingController();
  final _repetitionsController = TextEditingController();
  final _observationsController = TextEditingController();

  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _seriesController.dispose();
    _repetitionsController.dispose();
    _observationsController.dispose();
    super.dispose();
  }

  Future<void> _saveExercise() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final name = _nameController.text.trim();
    final series = int.parse(_seriesController.text.trim());
    final repetitions = int.parse(_repetitionsController.text.trim());
    final obsText = _observationsController.text.trim();
    final observations = obsText.isEmpty ? null : obsText;

    final exercise = Exercise(
      name: name,
      series: series,
      repetitions: repetitions,
      observations: observations,
    );

    try {
      await DatabaseHelper.instance.insertExercise(exercise);
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      setState(() {
        _isSaving = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar exercício: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Novo Exercício',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: _isSaving
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Adicione um novo exercício à sua rotina',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nome do Exercício',
                        hintText: 'Ex: Supino Reto',
                        prefixIcon: const Icon(Icons.fitness_center_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por favor, insira o nome do exercício';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _seriesController,
                            decoration: InputDecoration(
                              labelText: 'Séries',
                              hintText: 'Ex: 4',
                              prefixIcon: const Icon(Icons.repeat),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Obrigatório';
                              }
                              final number = int.tryParse(value);
                              if (number == null || number <= 0) {
                                return 'Inválido';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _repetitionsController,
                            decoration: InputDecoration(
                              labelText: 'Repetições',
                              hintText: 'Ex: 12',
                              prefixIcon: const Icon(Icons.play_arrow_rounded),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Obrigatório';
                              }
                              final number = int.tryParse(value);
                              if (number == null || number <= 0) {
                                return 'Inválido';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _observationsController,
                      decoration: InputDecoration(
                        labelText: 'Observações / Instruções',
                        hintText: 'Ex: Foco na cadência de movimento, 2s na descida.',
                        prefixIcon: const Icon(Icons.notes_rounded),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 4,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      onPressed: _saveExercise,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.save_rounded),
                      label: const Text(
                        'Salvar Exercício',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
