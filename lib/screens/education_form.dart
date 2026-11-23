import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _institutionController = TextEditingController();
  final _studyProgramController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _level = 'Sarjana';
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isOngoing = false;

  final List<String> _levels = ['SMA/SMK', 'Diploma', 'Sarjana', 'Magister', 'Doktor'];

  @override
  void dispose() {
    _institutionController.dispose();
    _studyProgramController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Education'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _institutionController,
                decoration: _decoration('Nama Institusi', 'Contoh: Universitas Indonesia'),
                validator: (value) => _required(value, 'Nama institusi'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _studyProgramController,
                decoration: _decoration('Program Studi', 'Contoh: Ilmu Komputer'),
                validator: (value) => _required(value, 'Program studi'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _level,
                decoration: _decoration('Jenjang Pendidikan', null),
                items: _levels
                    .map((level) => DropdownMenuItem(value: level, child: Text(level)))
                    .toList(),
                onChanged: (value) => setState(() => _level = value!),
              ),
              const SizedBox(height: 16),
              _DateField(
                label: 'Tanggal Mulai',
                value: _startDate,
                onTap: () => _pickDate(isStart: true),
                validator: (_) => _startDate == null ? 'Tanggal mulai wajib dipilih' : null,
              ),
              const SizedBox(height: 8),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Masih berlangsung'),
                value: _isOngoing,
                onChanged: (value) => setState(() {
                  _isOngoing = value ?? false;
                  if (_isOngoing) _endDate = null;
                }),
              ),
              _DateField(
                label: 'Tanggal Selesai',
                value: _endDate,
                enabled: !_isOngoing,
                onTap: () => _pickDate(isStart: false),
                validator: (_) {
                  if (_isOngoing) return null;
                  if (_endDate == null) return 'Tanggal selesai wajib dipilih';
                  if (_startDate != null && _endDate!.isBefore(_startDate!)) {
                    return 'Tanggal selesai tidak boleh sebelum tanggal mulai';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: _decoration('Deskripsi', 'Ceritakan pendidikan ini'),
                validator: (value) {
                  final requiredError = _required(value, 'Deskripsi');
                  if (requiredError != null) return requiredError;
                  if (value!.trim().length < 10) return 'Deskripsi minimal 10 karakter';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _saveEducation,
                icon: const Icon(Icons.save),
                label: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _required(String? value, String label) {
    return value == null || value.trim().isEmpty ? '$label wajib diisi' : null;
  }

  InputDecoration _decoration(String label, String? hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: const OutlineInputBorder(),
    );
  }

  Future<void> _pickDate({required bool isStart}) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: isStart ? (_startDate ?? DateTime.now()) : (_endDate ?? _startDate ?? DateTime.now()),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );
    if (selected == null) return;
    setState(() {
      if (isStart) {
        _startDate = selected;
        if (_endDate != null && _endDate!.isBefore(selected)) _endDate = null;
      } else {
        _endDate = selected;
      }
    });
  }

  void _saveEducation() {
    if (!_formKey.currentState!.validate()) return;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pendidikan berhasil ditambahkan!'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Institusi: ${_institutionController.text.trim()}'),
              Text('Program Studi: ${_studyProgramController.text.trim()}'),
              Text('Jenjang: $_level'),
              Text('Periode: ${_formatDate(_startDate!)} - ${_isOngoing ? 'Sekarang' : _formatDate(_endDate!)}'),
              Text('Deskripsi: ${_descriptionController.text.trim()}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _formKey.currentState!.reset();
              _institutionController.clear();
              _studyProgramController.clear();
              _descriptionController.clear();
              setState(() {
                _startDate = null;
                _endDate = null;
                _isOngoing = false;
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) => '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final bool enabled;
  final VoidCallback onTap;
  final String? Function(DateTime?)? validator;

  const _DateField({required this.label, required this.value, required this.onTap, required this.validator, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      validator: validator,
      builder: (field) => InkWell(
        onTap: enabled ? onTap : null,
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            errorText: field.errorText,
            enabled: enabled,
          ),
          child: Text(value == null ? 'Pilih tanggal' : '${value!.day.toString().padLeft(2, '0')}/${value!.month.toString().padLeft(2, '0')}/${value!.year}'),
        ),
      ),
    );
  }
}
