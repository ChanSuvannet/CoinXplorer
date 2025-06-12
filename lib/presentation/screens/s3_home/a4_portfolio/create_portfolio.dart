import 'package:flutter/material.dart';

class CreatePortfolioScreen extends StatelessWidget {
  const CreatePortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text('Create Portfolio'),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        // <-- Added this
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose your prefer option to create portfolio',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // Wallet Option
              _buildOptionCard(
                icon: Icons.account_balance_wallet_outlined,
                title: 'Connect a wallet',
                description:
                    'Simply enter your wallet address (no signature needed!) and we\'ll sync it right away',
                onTap:
                    () => _showSnackBar(context, 'Wallet connection selected'),
              ),
              const SizedBox(height: 16),
              // Manual Option
              _buildOptionCard(
                icon: Icons.edit_outlined,
                title: 'Add transactions manually',
                description:
                    'Enter all transaction details at your own pace to track your portfolio',
                onTap:
                    () =>
                        _showSnackBar(context, 'Manual transactions selected'),
              ),
              const SizedBox(height: 16),
              // Binance Option
              _buildOptionCard(
                icon: Icons.account_balance_outlined,
                title: 'Connect Binance account',
                description:
                    'Securely sync assets from your Binance account without using API key.',
                onTap:
                    () => _showSnackBar(context, 'Binance connection selected'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4, // Added shadow elevation
      shadowColor: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.blue),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }
}
