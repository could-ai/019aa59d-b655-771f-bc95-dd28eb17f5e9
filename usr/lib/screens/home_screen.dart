import 'package:flutter/material.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isConverting = false;
  final TextEditingController _textController = TextEditingController();

  void _convertContent(String content, {bool isFile = false}) async {
    setState(() {
      _isConverting = true;
    });

    // Simulate processing delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock conversion logic - in a real app this would parse PDF or text
    String convertedLatex;
    if (isFile) {
      // Mock result for file
      convertedLatex = r'''
\documentclass{article}
\usepackage[utf8]{inputenc}
\title{Converted PDF File}
\begin{document}
\maketitle
\section{Content}
This is the simulated output from the selected PDF file.
\end{document}
''';
    } else {
      // Wrap pasted text
      convertedLatex = '''
\\documentclass{article}
\\usepackage[utf8]{inputenc}
\\title{Converted Text}
\\begin{document}
\\maketitle
\\section{Content}
${content.isEmpty ? "No content provided." : content}
\\end{document}
''';
    }

    if (mounted) {
      setState(() {
        _isConverting = false;
      });
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(latexContent: convertedLatex),
        ),
      );
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF to LaTeX Converter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: _isConverting
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text('Analyzing format and spacing...'),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.picture_as_pdf_outlined,
                    size: 80,
                    color: Colors.indigo,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Convert PDF or Text to LaTeX',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  
                  // Option 1: File Picker (Mock)
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text('Option 1: Upload PDF', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: () => _convertContent("file", isFile: true),
                            icon: const Icon(Icons.upload_file),
                            label: const Text('Select PDF File'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  const Row(children: [
                    Expanded(child: Divider()),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text("OR")),
                    Expanded(child: Divider()),
                  ]),
                  const SizedBox(height: 20),

                  // Option 2: Text Input
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text('Option 2: Paste Text Content', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _textController,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText: 'Paste text from your document here...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: () => _convertContent(_textController.text, isFile: false),
                            icon: const Icon(Icons.text_fields),
                            label: const Text('Convert Text'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
