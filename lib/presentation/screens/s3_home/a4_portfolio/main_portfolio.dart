import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SF Pro Display',
      ),
      home: PortfolioScreen(),
    );
  }
}

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  int _selectedIndex = 3; // Portfolio tab is selected
  int _selectedTab = 0; // Overview tab is selected by default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'My Main Portfolio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          SvgPicture.asset('assets/icons/diamond.svg', height: 20, width: 20),
          SizedBox(width: 20),
          SvgPicture.asset('assets/icons/search.svg', height: 20, width: 20),
          SizedBox(width: 16),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage('assets/images/senghak.png'),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          // Portfolio Value Section
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '\$14,541.34',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.visibility_off_outlined, color: Colors.grey),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  '24h: -\$185.65 ▼ 5.78%',
                  style: TextStyle(fontSize: 14, color: Colors.red),
                ),
                SizedBox(height: 2),
                Text(
                  'All-time: -\$185.65 ▼ 5.78%',
                  style: TextStyle(fontSize: 14, color: Colors.red),
                ),
              ],
            ),
          ),

          // Tab Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildTab('Overview', 0),
                SizedBox(width: 24),
                _buildTab('Transaction', 1),
                SizedBox(width: 24),
                _buildTab('Earn', 2),
              ],
            ),
          ),

          Expanded(
            child:
                _selectedTab == 0
                    ? _buildOverviewTab()
                    : _selectedTab == 1
                    ? _buildTransactionTab()
                    : _buildEarnTab(),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    bool isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.blue : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Sub tabs
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                _buildSubTab('Holdings', true),
                SizedBox(width: 16),
                _buildSubTab('All-time profit', false),
                SizedBox(width: 16),
                _buildSubTab('Allocation', false),
              ],
            ),
          ),

          // Time period selector
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildTimePeriod('24h', true),
                SizedBox(width: 8),
                _buildTimePeriod('7d', false),
                SizedBox(width: 8),
                _buildTimePeriod('30d', false),
                SizedBox(width: 8),
                _buildTimePeriod('90d', false),
                SizedBox(width: 8),
                _buildTimePeriod('All', false),
              ],
            ),
          ),

          // Chart
          Container(
            height: 200,
            padding: EdgeInsets.all(16),
            child: Image.asset('assets/images/chart.png', fit: BoxFit.contain),
          ),

          // Assets list header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text('Assets', style: TextStyle(fontWeight: FontWeight.w600)),
                Spacer(),
                Text('Price', style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(width: 60),
                Text(
                  'Holdings ▼',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          // Asset items
          _buildAssetItem(
            'Ethereum',
            'ETH',
            '\$121.26 B',
            '5.78%',
            '\$121.26 B',
            '1.000 ETH',
            'assets/images/Ether.png',
          ),
          _buildAssetItem(
            'Tron',
            'TRX',
            '\$8.34 B',
            '23.41%',
            '\$8.34 B',
            '1.000 TRON',
            'assets/images/Tron.png',
          ),

          // New transaction button
          Container(
            margin: EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                foregroundColor: Colors.black,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 20),
                  SizedBox(width: 8),
                  Text('New transaction'),
                ],
              ),
            ),
          ),

          // Footer text
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'CoinXPlorer does not support the ability to buy or sell crypto assets.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTab() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Filter buttons
          Row(
            children: [
              _buildFilterButton('All Types'),
              SizedBox(width: 12),
              _buildFilterButton('All Coins'),
            ],
          ),
          SizedBox(height: 16),

          // Date
          Container(
            width: double.infinity,
            child: Text(
              'Mar 25, 2025',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          SizedBox(height: 12),

          // Transaction items
          _buildTransactionItem(
            'Ethereum',
            'ETH',
            '+ 1.000 ETH',
            '1,845.41 \$',
            'assets/images/Ether.png',
          ),
          SizedBox(height: 16),
          _buildTransactionItem(
            'Tron',
            'TRX',
            '+ 25.000 TRON',
            '6.78 \$',
            'assets/images/Tron.png',
          ),
        ],
      ),
    );
  }

  Widget _buildEarnTab() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text('#', style: TextStyle(color: Colors.grey)),
                SizedBox(width: 16),
                Text('Asset', style: TextStyle(fontWeight: FontWeight.w600)),
                Spacer(),
                Text(
                  'Service Provider',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 60),
                Text('Net APY', style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),

          // Earn items
          _buildEarnItem(
            '3',
            'ETH',
            'Ethereum',
            '0.05-12.00%',
            'assets/images/Ether.png',
          ),
          _buildEarnItem(
            '78',
            'TRON',
            'Tron',
            '4.78%',
            'assets/images/Tron.png',
          ),

          Spacer(),

          // New transaction button
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                foregroundColor: Colors.black,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.help_outline, size: 20),
                  SizedBox(width: 8),
                  Text('New transaction'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubTab(String title, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTimePeriod(String period, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey.shade200 : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        period,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildAssetItem(
    String name,
    String symbol,
    String price,
    String change,
    String holdings,
    String amount,
    String imagePath,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Image.asset(imagePath, width: 40, height: 40, fit: BoxFit.contain),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              Text(
                '▲ $change',
                style: TextStyle(color: Colors.green, fontSize: 12),
              ),
            ],
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                holdings,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              Text(amount, style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
    String name,
    String symbol,
    String amount,
    String value,
    String imagePath,
  ) {
    return Container(
      child: Row(
        children: [
          Image.asset(imagePath, width: 40, height: 40, fit: BoxFit.contain),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(value, style: TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEarnItem(
    String rank,
    String symbol,
    String name,
    String apy,
    String imagePath,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 24,
            child: Text(rank, style: TextStyle(color: Colors.grey)),
          ),
          SizedBox(width: 16),
          Image.asset(imagePath, width: 32, height: 32, fit: BoxFit.contain),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  symbol,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Text(name, style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          // Service provider icons
          Row(
            children: [
              Image.asset(
                'assets/images/yellow.png', // Replaces orange
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 4),
              Image.asset(
                'assets/images/blue.png', // Replaces green
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 4),
              Image.asset(
                'assets/images/cyan.png', // Replaces blue
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
              Text('+2', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          SizedBox(width: 20),
          Text(
            apy,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down, size: 16),
        ],
      ),
    );
  }
}
