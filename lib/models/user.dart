class User {
  final String id;
  final String name;
  final String role; // admin, project_manager, developer

  User({
    required this.id,
    required this.name,
    required this.role,
  });
}