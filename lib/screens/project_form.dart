import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});
  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController(),
      _description = TextEditingController(),
      _techStack = TextEditingController(),
      _projectUrl = TextEditingController(),
      _imageUrl = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _techStack.dispose();
    _projectUrl.dispose();
    _imageUrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final loggedIn = await ensureLoggedIn(context);
    if (!mounted || !loggedIn) return;
    final token = context.read<AuthState>().token;
    if (token == null) return;
    setState(() => _submitting = true);
    try {
      final project = Project(
        title: _title.text.trim(),
        description: _description.text.trim(),
        techStack: _techStack.text.trim(),
        projectUrl: _projectUrl.text.trim(),
        projectImageUrl: _imageUrl.text.trim(),
      );
      await context.read<ApiClient>().createProject(project, token: token);
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Project added'),
          content: const Text('Project berhasil ditambahkan.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on ApiException catch (error) {
      if (!mounted) return;
      if (error.statusCode == 401) {
        await context.read<AuthState>().logout();
        if (!mounted) return;
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menambahkan proyek (${error.statusCode})'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  String? _required(String? value, String label) =>
      value == null || value.trim().isEmpty ? '$label wajib diisi' : null;
  String? _url(String? value) {
    final error = _required(value, 'Project URL');
    if (error != null) return error;
    final uri = Uri.tryParse(value!.trim());
    return uri == null || !uri.hasScheme || uri.host.isEmpty
        ? 'Format URL tidak valid'
        : null;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Add Project')),
    drawer: const LeftDrawer(),
    body: Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (v) => _required(v, 'Title'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _description,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              validator: (v) => _required(v, 'Description'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _techStack,
              decoration: const InputDecoration(
                labelText: 'Tech Stack',
                border: OutlineInputBorder(),
              ),
              validator: (v) => _required(v, 'Tech Stack'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _projectUrl,
              decoration: const InputDecoration(
                labelText: 'Project URL',
                border: OutlineInputBorder(),
              ),
              validator: _url,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _imageUrl,
              decoration: const InputDecoration(
                labelText: 'Project Image URL (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitting ? null : _submit,
              child: _submitting
                  ? const CircularProgressIndicator()
                  : const Text('Save'),
            ),
          ],
        ),
      ),
    ),
  );
}
