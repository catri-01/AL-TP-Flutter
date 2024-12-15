import 'package:tp_al/posts/posts_bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/post.dart';

class CreatePostScreen extends StatelessWidget {
  static const routeName = '/addPost';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  CreatePostScreen({Key? key}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostsBloc, PostsState>(
      listenWhen: listenWhen,
      listener: postsBlocListener,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ajouter un Post'),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Titre',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Entrez le titre',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Entrez la description',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            final loading = state.status == PostsStatus.creatingPosts;
            return FloatingActionButton.extended(
              onPressed: loading ? null : () => createPost(context),
              backgroundColor: loading ? Colors.grey : Colors.blue,
              label: loading
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : const Text(
                'Ajouter',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: loading
                  ? const SizedBox.shrink()
                  : const Icon(Icons.add, color: Colors.white),
            );
          },
        ),
      ),
    );
  }

  void createPost(BuildContext context) {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    // Validation
    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final post = Post(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
    );

    context.read<PostsBloc>().add(CreatePost(postToAdd: post));
  }

  bool listenWhen(PostsState previous, PostsState current) {
    return previous.status != current.status &&
        (current.status == PostsStatus.errorCreatingPost ||
            current.status == PostsStatus.createdPost);
  }

  void postsBlocListener(BuildContext context, PostsState state) {
    switch (state.status) {
      case PostsStatus.errorCreatingPost:
        showSnackBar(
          context,
          'Erreur lors de l\'ajout du post',
          isError: true,
        );
        break;
      case PostsStatus.createdPost:
        showSnackBar(
          context,
          'Post ajouté avec succès',
          isError: false,
        );
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        break;
      default:
        return;
    }
  }

  void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
  }
}