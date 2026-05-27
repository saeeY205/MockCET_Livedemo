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
    final size = MediaQuery.of(context).size;
    final isCompact = size.width < 360;

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
                opacity: 0.08,
                child: Center(
                  child: Icon(Icons.school_outlined, size: isCompact ? 180 : 300, color: primaryColor),
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
                    primaryColor.withValues(alpha: 0.08),
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
                padding: EdgeInsets.symmetric(horizontal: isCompact ? 16 : 32, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Branded header
                    Container(
                      padding: isCompact
                          ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                          : const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(isCompact ? 14 : 20),
                        border: Border.all(color: primaryColor.withValues(alpha: 0.1), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withValues(alpha: 0.06),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Text(
                        'PVP MockCET',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w900,
                          letterSpacing: isCompact ? 2 : 4,
                          fontSize: isCompact ? 22 : 34,
                        ),
                      ),
                    ),
                    SizedBox(height: isCompact ? 12 : 24),
                    // College Name
                    Text(
                      'Padmabhooshan Vasantraodada Patil Institute of Technology, Budhgaon',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isCompact ? 12 : 20,
                        fontWeight: FontWeight.w800,
                        color: primaryColor.withValues(alpha: 0.8),
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: isCompact ? 20 : 32),
                    _buildLoginForm(primaryColor, isCompact),
                    SizedBox(height: isCompact ? 12 : 16),
                    _buildLinks(primaryColor, isCompact),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(Color primaryColor, bool isCompact) {
    return Container(
      padding: EdgeInsets.all(isCompact ? 16 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isCompact ? 16 : 24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              style: isCompact ? const TextStyle(fontSize: 14) : null,
              decoration: _inputDecoration('Email Address', Icons.email_outlined, primaryColor, isCompact),
              validator: (v) => (v == null || v.isEmpty) ? 'Email is required' : null,
            ),
            SizedBox(height: isCompact ? 12 : 16),
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              style: isCompact ? const TextStyle(fontSize: 14) : null,
              decoration: _inputDecoration('Password', Icons.lock_outline, primaryColor, isCompact).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, size: isCompact ? 20 : 24),
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),
              ),
              validator: (v) => (v == null || v.isEmpty) ? 'Password is required' : null,
            ),
            SizedBox(height: isCompact ? 16 : 24),
            SizedBox(
              width: double.infinity,
              height: isCompact ? 44 : 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(isCompact ? 12 : 16)),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Text('Login to Portal', style: TextStyle(fontSize: isCompact ? 14 : 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinks(Color primaryColor, bool isCompact) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("Don't have an account? ", style: TextStyle(fontSize: isCompact ? 12 : 14)),
            TextButton(
              onPressed: () {},
              style: isCompact
                  ? TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    )
                  : null,
              child: Text(
                'Register Now',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  fontSize: isCompact ? 12 : 14,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: isCompact ? 4 : 8),
        TextButton.icon(
          onPressed: () {},
          style: isCompact
              ? TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                )
              : null,
          icon: Icon(Icons.help_outline, size: isCompact ? 14 : 18),
          label: Text(
            'Need Help? View User Guide',
            style: TextStyle(fontSize: isCompact ? 11 : 14),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon, Color primaryColor, bool isCompact) {
    return InputDecoration(
      labelText: label,
      labelStyle: isCompact ? const TextStyle(fontSize: 13) : null,
      contentPadding: isCompact ? const EdgeInsets.symmetric(horizontal: 12, vertical: 10) : null,
      prefixIcon: Icon(icon, color: primaryColor.withValues(alpha: 0.7), size: isCompact ? 18 : 24),
      filled: true,
      fillColor: const Color(0xFFF3F5F9),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(isCompact ? 12 : 16), borderSide: BorderSide.none),
    );
  }
}
