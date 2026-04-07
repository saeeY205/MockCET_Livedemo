import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/mock_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    if (!mounted) return;
    
    final mockProvider = context.read<MockDataProvider>();
    mockProvider.login(_emailController.text.trim(), _passwordController.text.trim());

    setState(() => _isLoading = false);

    if (mockProvider.isLoggedIn) {
      final isAdmin = mockProvider.userRole == 'admin';
      _showSnackBar(
        isAdmin ? 'Admin Login Successful' : 'Login Successful',
        isAdmin ? Colors.green : Colors.blue,
      );
      
      Navigator.pushReplacementNamed(
        context,
        isAdmin ? '/admin_dashboard' : '/home',
      );
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1A237E);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF8F9FE),
      body: Stack(
        children: [
          // Background Placeholder (Inspired by Mock CET)
          Positioned.fill(
            child: Container(
              color: primaryColor.withValues(alpha: 0.05),
              child: Opacity(
                opacity: 0.1,
                child: Center(
                  child: Icon(Icons.school_outlined, size: 300, color: primaryColor),
                ),
              ),
            ),
          ),
          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    primaryColor.withValues(alpha: 0.1),
                    Colors.white.withValues(alpha: 0.8),
                    Colors.white,
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Branded header
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: primaryColor.withValues(alpha: 0.1), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Text(
                        'PVP MockCET',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 4,
                          fontSize: 34,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // College Name
                    const Text(
                      'Padmabhooshan Vasantraodada Patil Institute of Technology, Budhgaon',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: primaryColor,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildLoginForm(primaryColor),
                    const SizedBox(height: 16),
                    _buildLinks(primaryColor),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: _inputDecoration('Email Address', Icons.email_outlined, primaryColor),
              validator: (v) => (v == null || v.isEmpty) ? 'Email is required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: _inputDecoration('Password', Icons.lock_outline, primaryColor).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),
              ),
              validator: (v) => (v == null || v.isEmpty) ? 'Password is required' : null,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Login to Portal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinks(Color primaryColor) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text("Don't have an account? "),
            TextButton(
              onPressed: () {},
              child: const Text('Register Now', style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
            ),
          ],
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.help_outline, size: 18),
          label: const Text('Need Help? View User Guide'),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon, Color primaryColor) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: primaryColor.withValues(alpha: 0.7)),
      filled: true,
      fillColor: const Color(0xFFF3F5F9),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
    );
  }
}
