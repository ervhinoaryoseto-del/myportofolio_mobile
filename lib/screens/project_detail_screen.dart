import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({required this.project, super.key});
  final Project project;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(project.title)),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (project.projectImageUrl.isNotEmpty)
            Image.network(project.projectImageUrl),
          Text(project.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          Text('Tech Stack: ${project.techStack}'),
          const SizedBox(height: 12),
          Text(project.description),
          const SizedBox(height: 12),
          Text('Project URL: ${project.projectUrl}'),
        ],
      ),
    ),
  );
}
