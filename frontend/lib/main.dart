import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ==============================================================================
// ENTRY POINT
// ==============================================================================

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ZeroBloatERPApp());
}

class ZeroBloatERPApp extends StatelessWidget {
  const ZeroBloatERPApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zero-Bloat Cloud ERP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A), // Deep Navy / Indigo
          primary: const Color(0xFF1E3A8A),
          secondary: const Color(0xFF0D9488), // Teal accent
          surface: Colors.white,
          brightness: Brightness.light,
        ),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF1E3A8A), width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
      home: const ERPControllerScope(
        child: RootNavigationScreen(),
      ),
    );
  }
}

// ==============================================================================
// MODELS
// ==============================================================================

class Product {
  final int id;
  final String sku;
  final String name;
  final String category;
  final double price;
  final double cost;
  final int stock;

  Product({
    required this.id,
    required this.sku,
    required this.name,
    required this.category,
    required this.price,
    required this.cost,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: (json['id'] as num?)?.toInt() ?? 0,
      sku: json['sku'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      cost: (json['cost'] as num?)?.toDouble() ?? 0.0,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'sku': sku,
        'name': name,
        'category': category,
        'price': price,
        'cost': cost,
        'stock': stock,
      };
}

class Customer {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final double balance;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.balance,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'balance': balance,
      };
}

class Invoice {
  final int id;
  final String invoiceNumber;
  final int customerId;
  final String customerName;
  final double totalAmount;
  final double tax;
  final String status;
  final String createdAt;

  Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.customerId,
    required this.customerName,
    required this.totalAmount,
    required this.tax,
    required this.status,
    required this.createdAt,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: (json['id'] as num?)?.toInt() ?? 0,
      invoiceNumber: json['invoice_number'] ?? '',
      customerId: (json['customer_id'] as num?)?.toInt() ?? 0,
      customerName: json['customer_name'] ?? 'Customer',
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? 'pending',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'invoice_number': invoiceNumber,
        'customer_id': customerId,
        'total_amount': totalAmount,
        'tax': tax,
        'status': status,
      };
}

class Account {
  final int id;
  final String accountCode;
  final String accountName;
  final String accountType;
  final double balance;

  Account({
    required this.id,
    required this.accountCode,
    required this.accountName,
    required this.accountType,
    required this.balance,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: (json['id'] as num?)?.toInt() ?? 0,
      accountCode: json['account_code'] ?? '',
      accountName: json['account_name'] ?? '',
      accountType: json['account_type'] ?? '',
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        'account_code': accountCode,
        'account_name': accountName,
        'account_type': accountType,
        'balance': balance,
      };
}

class Employee {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String department;
  final String position;
  final double salary;
  final String hireDate;

  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.department,
    required this.position,
    required this.salary,
    required this.hireDate,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: (json['id'] as num?)?.toInt() ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      department: json['department'] ?? '',
      position: json['position'] ?? '',
      salary: (json['salary'] as num?)?.toDouble() ?? 0.0,
      hireDate: json['hire_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'department': department,
        'position': position,
        'salary': salary,
        'hire_date': hireDate,
      };
}

class DashboardStats {
  final double totalRevenue;
  final int invoiceCount;
  final int productCount;
  final int customerCount;
  final int employeeCount;
  final List<Invoice> recentInvoices;

  DashboardStats({
    required this.totalRevenue,
    required this.invoiceCount,
    required this.productCount,
    required this.customerCount,
    required this.employeeCount,
    required this.recentInvoices,
  });

  factory DashboardStats.initial() {
    return DashboardStats(
      totalRevenue: 0.0,
      invoiceCount: 0,
      productCount: 0,
      customerCount: 0,
      employeeCount: 0,
      recentInvoices: [],
    );
  }

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    var rawInvoices = json['recent_invoices'] as List? ?? [];
    List<Invoice> list = rawInvoices.map((e) => Invoice.fromJson(e)).toList();
    return DashboardStats(
      totalRevenue: (json['total_revenue'] as num?)?.toDouble() ?? 0.0,
      invoiceCount: (json['invoice_count'] as num?)?.toInt() ?? 0,
      productCount: (json['product_count'] as num?)?.toInt() ?? 0,
      customerCount: (json['customer_count'] as num?)?.toInt() ?? 0,
      employeeCount: (json['employee_count'] as num?)?.toInt() ?? 0,
      recentInvoices: list,
    );
  }
}

// ==============================================================================
// STATE CONTROLLER (VALUENOTIFIER & ZERO-DEPENDENCY STATE)
// ==============================================================================

class ERPController extends ChangeNotifier {
  String apiUrl = 'http://localhost:8080/api';
  String token = '';
  Map<String, dynamic>? currentUser;
  bool isLoggedIn = false;
  int currentTabIndex = 0;
  bool isLoading = false;
  String? errorMessage;

  DashboardStats stats = DashboardStats.initial();
  List<Product> products = [];
  List<Customer> customers = [];
  List<Invoice> invoices = [];
  List<Account> accounts = [];
  List<Employee> employees = [];

  void setApiUrl(String url) {
    apiUrl = url.endsWith('/') ? url.substring(0, url.length - 1) : url;
    notifyListeners();
  }

  void setTab(int index) {
    currentTabIndex = index;
    notifyListeners();
    loadTabContent(index);
  }

  Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token.isNotEmpty) 'Authorization': 'Bearer $token',
      };

  Future<bool> login(String username, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final res = await http.post(
        Uri.parse('$apiUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        token = data['token'] ?? '';
        currentUser = data['user'] as Map<String, dynamic>?;
        isLoggedIn = true;
        isLoading = false;
        notifyListeners();
        await refreshAllData();
        return true;
      } else {
        final err = jsonDecode(res.body);
        errorMessage = err['error'] ?? 'Authentication failed (${res.statusCode})';
      }
    } catch (e) {
      errorMessage = 'Connection error: Could not reach Go backend at $apiUrl. Ensure Go server is running.';
    }

    isLoading = false;
    notifyListeners();
    return false;
  }

  void logout() {
    token = '';
    currentUser = null;
    isLoggedIn = false;
    currentTabIndex = 0;
    notifyListeners();
  }

  Future<void> refreshAllData() async {
    await Future.wait([
      loadDashboard(),
      loadProducts(),
      loadCustomers(),
      loadInvoices(),
      loadAccounts(),
      loadEmployees(),
    ]);
  }

  Future<void> loadTabContent(int index) async {
    switch (index) {
      case 0:
        await loadDashboard();
        break;
      case 1:
        await loadProducts();
        break;
      case 2:
        await loadCustomers();
        break;
      case 3:
        await loadInvoices();
        break;
      case 4:
        await loadAccounts();
        break;
      case 5:
        await loadEmployees();
        break;
    }
  }

  Future<void> loadDashboard() async {
    try {
      final res = await http.get(Uri.parse('$apiUrl/dashboard/stats'), headers: headers);
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        if (body['data'] != null) {
          stats = DashboardStats.fromJson(body['data']);
          notifyListeners();
        }
      }
    } catch (_) {}
  }

  // --- Products CRUD ---
  Future<void> loadProducts([String search = '']) async {
    try {
      final uri = Uri.parse('$apiUrl/products').replace(queryParameters: search.isNotEmpty ? {'search': search} : null);
      final res = await http.get(uri, headers: headers);
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        final list = body['data'] as List? ?? [];
        products = list.map((e) => Product.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<bool> saveProduct(Product p, {bool isEdit = false}) async {
    try {
      final res = isEdit
          ? await http.put(Uri.parse('$apiUrl/products/${p.id}'), headers: headers, body: jsonEncode(p.toJson()))
          : await http.post(Uri.parse('$apiUrl/products'), headers: headers, body: jsonEncode(p.toJson()));
      if (res.statusCode == 200 || res.statusCode == 201) {
        await loadProducts();
        await loadDashboard();
        return true;
      }
    } catch (_) {}
    return false;
  }

  Future<bool> deleteProduct(int id) async {
    try {
      final res = await http.delete(Uri.parse('$apiUrl/products/$id'), headers: headers);
      if (res.statusCode == 200) {
        await loadProducts();
        await loadDashboard();
        return true;
      }
    } catch (_) {}
    return false;
  }

  // --- Customers CRUD ---
  Future<void> loadCustomers([String search = '']) async {
    try {
      final uri = Uri.parse('$apiUrl/customers').replace(queryParameters: search.isNotEmpty ? {'search': search} : null);
      final res = await http.get(uri, headers: headers);
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        final list = body['data'] as List? ?? [];
        customers = list.map((e) => Customer.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<bool> saveCustomer(Customer c, {bool isEdit = false}) async {
    try {
      final res = isEdit
          ? await http.put(Uri.parse('$apiUrl/customers/${c.id}'), headers: headers, body: jsonEncode(c.toJson()))
          : await http.post(Uri.parse('$apiUrl/customers'), headers: headers, body: jsonEncode(c.toJson()));
      if (res.statusCode == 200 || res.statusCode == 201) {
        await loadCustomers();
        await loadDashboard();
        return true;
      }
    } catch (_) {}
    return false;
  }

  Future<bool> deleteCustomer(int id) async {
    try {
      final res = await http.delete(Uri.parse('$apiUrl/customers/$id'), headers: headers);
      if (res.statusCode == 200) {
        await loadCustomers();
        await loadDashboard();
        return true;
      }
    } catch (_) {}
    return false;
  }

  // --- Invoices CRUD ---
  Future<void> loadInvoices() async {
    try {
      final res = await http.get(Uri.parse('$apiUrl/invoices'), headers: headers);
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        final list = body['data'] as List? ?? [];
        invoices = list.map((e) => Invoice.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<bool> createInvoice(Invoice inv) async {
    try {
      final res = await http.post(Uri.parse('$apiUrl/invoices'), headers: headers, body: jsonEncode(inv.toJson()));
      if (res.statusCode == 200 || res.statusCode == 201) {
        await loadInvoices();
        await loadDashboard();
        return true;
      }
    } catch (_) {}
    return false;
  }

  Future<bool> updateInvoiceStatus(int id, String status) async {
    try {
      final res = await http.put(Uri.parse('$apiUrl/invoices/$id/status'), headers: headers, body: jsonEncode({'status': status}));
      if (res.statusCode == 200) {
        await loadInvoices();
        await loadDashboard();
        return true;
      }
    } catch (_) {}
    return false;
  }

  Future<bool> deleteInvoice(int id) async {
    try {
      final res = await http.delete(Uri.parse('$apiUrl/invoices/$id'), headers: headers);
      if (res.statusCode == 200) {
        await loadInvoices();
        await loadDashboard();
        return true;
      }
    } catch (_) {}
    return false;
  }

  // --- Accounts CRUD ---
  Future<void> loadAccounts() async {
    try {
      final res = await http.get(Uri.parse('$apiUrl/accounts'), headers: headers);
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        final list = body['data'] as List? ?? [];
        accounts = list.map((e) => Account.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<bool> saveAccount(Account a, {bool isEdit = false}) async {
    try {
      final res = isEdit
          ? await http.put(Uri.parse('$apiUrl/accounts/${a.id}'), headers: headers, body: jsonEncode(a.toJson()))
          : await http.post(Uri.parse('$apiUrl/accounts'), headers: headers, body: jsonEncode(a.toJson()));
      if (res.statusCode == 200 || res.statusCode == 201) {
        await loadAccounts();
        return true;
      }
    } catch (_) {}
    return false;
  }

  Future<bool> deleteAccount(int id) async {
    try {
      final res = await http.delete(Uri.parse('$apiUrl/accounts/$id'), headers: headers);
      if (res.statusCode == 200) {
        await loadAccounts();
        return true;
      }
    } catch (_) {}
    return false;
  }

  // --- Employees CRUD ---
  Future<void> loadEmployees() async {
    try {
      final res = await http.get(Uri.parse('$apiUrl/employees'), headers: headers);
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        final list = body['data'] as List? ?? [];
        employees = list.map((e) => Employee.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<bool> saveEmployee(Employee emp, {bool isEdit = false}) async {
    try {
      final res = isEdit
          ? await http.put(Uri.parse('$apiUrl/employees/${emp.id}'), headers: headers, body: jsonEncode(emp.toJson()))
          : await http.post(Uri.parse('$apiUrl/employees'), headers: headers, body: jsonEncode(emp.toJson()));
      if (res.statusCode == 200 || res.statusCode == 201) {
        await loadEmployees();
        await loadDashboard();
        return true;
      }
    } catch (_) {}
    return false;
  }

  Future<bool> deleteEmployee(int id) async {
    try {
      final res = await http.delete(Uri.parse('$apiUrl/employees/$id'), headers: headers);
      if (res.statusCode == 200) {
        await loadEmployees();
        await loadDashboard();
        return true;
      }
    } catch (_) {}
    return false;
  }
}

// InheritedNotifier wrapper for clean state injection
class ERPControllerScope extends InheritedNotifier<ERPController> {
  const ERPControllerScope({
    super.key,
    required super.child,
  }) : super(notifier: null);

  @override
  bool updateShouldNotify(InheritedNotifier<ERPController> oldWidget) => true;

  static ERPController of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_ERPInherited>()!.controller;
  }
}

class _ERPInherited extends InheritedWidget {
  final ERPController controller;
  const _ERPInherited({required this.controller, required super.child});

  @override
  bool updateShouldNotify(covariant _ERPInherited oldWidget) => true;
}

// ==============================================================================
// ROOT NAVIGATION & APP SHELL
// ==============================================================================

class RootNavigationScreen extends StatefulWidget {
  const RootNavigationScreen({super.key});

  @override
  State<RootNavigationScreen> createState() => _RootNavigationScreenState();
}

class _RootNavigationScreenState extends State<RootNavigationScreen> {
  final ERPController _controller = ERPController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ERPInherited(
      controller: _controller,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (!_controller.isLoggedIn) {
            return const LoginScreen();
          }
          return const MainDashboardShell();
        },
      ),
    );
  }
}

// ==============================================================================
// 1. LOGIN SCREEN
// ==============================================================================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameCtrl = TextEditingController(text: 'admin');
  final _passwordCtrl = TextEditingController(text: 'admin123');
  final _apiUrlCtrl = TextEditingController(text: 'http://localhost:8080/api');
  bool _obscurePassword = true;
  bool _showServerSettings = false;

  @override
  Widget build(BuildContext context) {
    final ctrl = _ERPInheritedState.get(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Slate 100
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 440),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo Icon & Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.token, size: 36, color: theme.colorScheme.primary),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Zero-Bloat ERP',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          'Golang • Supabase • Flutter Web',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                if (ctrl.errorMessage != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: BorderSide(color: Colors.red.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            ctrl.errorMessage!,
                            style: TextStyle(color: Colors.red.shade800, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),

                Text('Username / Email', style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                TextField(
                  controller: _usernameCtrl,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline, size: 20),
                    hintText: 'admin or admin@erp.local',
                  ),
                ),
                const SizedBox(height: 16),

                Text('Password', style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                TextField(
                  controller: _passwordCtrl,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline, size: 20),
                    hintText: 'admin123',
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, size: 20),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Server API endpoint config accordion
                InkWell(
                  onTap: () => setState(() => _showServerSettings = !_showServerSettings),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(_showServerSettings ? Icons.arrow_drop_down : Icons.arrow_right, size: 20, color: Colors.grey.shade700),
                        Text('Backend API Endpoint Config', style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                      ],
                    ),
                  ),
                ),
                if (_showServerSettings) ...[
                  const SizedBox(height: 8),
                  TextField(
                    controller: _apiUrlCtrl,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.dns_outlined, size: 20),
                      hintText: 'http://localhost:8080/api',
                    ),
                  ),
                ],
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: ctrl.isLoading
                      ? null
                      : () {
                          ctrl.setApiUrl(_apiUrlCtrl.text.trim());
                          ctrl.login(_usernameCtrl.text, _passwordCtrl.text);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: ctrl.isLoading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Text('Sign In to ERP System', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 16),

                // Demo Credentials Helper Card
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8),
                    border: BorderSide(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, size: 18, color: Color(0xFF0284C7)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Test Credentials: User: admin | Pass: admin123',
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Helper context extension
class _ERPInheritedState {
  static ERPController get(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_ERPInherited>()!.controller;
  }
}

// ==============================================================================
// 2. MAIN DASHBOARD SHELL (RESPONSIVE SIDEBAR + APPBAR)
// ==============================================================================

class MainDashboardShell extends StatelessWidget {
  const MainDashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = _ERPInheritedState.get(context);
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 850;

    final navItems = [
      {'title': 'Dashboard', 'icon': Icons.dashboard_outlined, 'activeIcon': Icons.dashboard},
      {'title': 'Inventory', 'icon': Icons.inventory_2_outlined, 'activeIcon': Icons.inventory_2},
      {'title': 'Customers', 'icon': Icons.people_outline, 'activeIcon': Icons.people},
      {'title': 'POS / Sales', 'icon': Icons.receipt_long_outlined, 'activeIcon': Icons.receipt_long},
      {'title': 'Accounting', 'icon': Icons.account_balance_outlined, 'activeIcon': Icons.account_balance},
      {'title': 'HR & Staff', 'icon': Icons.badge_outlined, 'activeIcon': Icons.badge},
    ];

    final screens = [
      const DashboardScreen(),
      const InventoryScreen(),
      const CustomersScreen(),
      const POSInvoicesScreen(),
      const AccountingScreen(),
      const EmployeesScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        titleSpacing: 16,
        title: Row(
          children: [
            if (!isDesktop)
              Builder(
                builder: (ctx) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                ),
              ),
            Text(
              navItems[ctrl.currentTabIndex]['title'] as String,
              style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: BorderSide(color: Colors.green.shade300),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  Text('Cloud Connected', style: TextStyle(fontSize: 11, color: Colors.green.shade800, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh Data',
            icon: const Icon(Icons.refresh, color: Color(0xFF475569)),
            onPressed: () => ctrl.refreshAllData(),
          ),
          const SizedBox(width: 8),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: theme.colorScheme.primary,
                  child: const Text('A', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 8),
                Text(
                  ctrl.currentUser?['username'] ?? 'Admin',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Sign Out',
            icon: const Icon(Icons.logout, color: Color(0xFF64748B)),
            onPressed: () => ctrl.logout(),
          ),
          const SizedBox(width: 12),
        ],
      ),
      drawer: isDesktop
          ? null
          : Drawer(
              child: _buildNavContent(context, ctrl, navItems),
            ),
      body: Row(
        children: [
          if (isDesktop)
            Container(
              width: 240,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(right: BorderSide(color: Colors.grey.shade200)),
              ),
              child: _buildNavContent(context, ctrl, navItems),
            ),
          Expanded(
            child: IndexedStack(
              index: ctrl.currentTabIndex,
              children: screens,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavContent(BuildContext context, ERPController ctrl, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.cloud_done, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Zero-Bloat ERP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Supabase Cloud', style: TextStyle(color: Colors.grey, fontSize: 11)),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, i) {
              final item = items[i];
              final isSelected = ctrl.currentTabIndex == i;
              return Container(
                margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1E3A8A).withOpacity(0.08) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  dense: true,
                  leading: Icon(
                    isSelected ? item['activeIcon'] as IconData : item['icon'] as IconData,
                    color: isSelected ? const Color(0xFF1E3A8A) : const Color(0xFF64748B),
                  ),
                  title: Text(
                    item['title'] as String,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? const Color(0xFF1E3A8A) : const Color(0xFF334155),
                    ),
                  ),
                  onTap: () {
                    ctrl.setTab(i);
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              );
            },
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.bolt, color: Colors.amber, size: 18),
              const SizedBox(width: 8),
              Text(
                '0 MB Local Storage',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ==============================================================================
// 3. DASHBOARD SCREEN
// ==============================================================================

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = _ERPInheritedState.get(context);
    final stats = ctrl.stats;

    return RefreshIndicator(
      onRefresh: () => ctrl.refreshAllData(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPI Summary Row
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth > 1000 ? 5 : (constraints.maxWidth > 650 ? 3 : 2);
                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.4,
                  children: [
                    _buildKpiCard('Total Revenue', '\$${stats.totalRevenue.toStringAsFixed(2)}', Icons.payments, Colors.emerald),
                    _buildKpiCard('Total Invoices', '${stats.invoiceCount}', Icons.receipt_long, Colors.blue),
                    _buildKpiCard('Products in Stock', '${stats.productCount}', Icons.inventory_2, Colors.purple),
                    _buildKpiCard('Active Customers', '${stats.customerCount}', Icons.people, Colors.orange),
                    _buildKpiCard('Employees', '${stats.employeeCount}', Icons.badge, Colors.teal),
                  ],
                );
              },
            ),
            const SizedBox(height: 28),

            // Quick Actions & Architecture Info
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.flash_on, color: Color(0xFFD97706)),
                              SizedBox(width: 8),
                              Text('Quick Actions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              ElevatedButton.icon(
                                icon: const Icon(Icons.add, size: 16),
                                label: const Text('New Invoice'),
                                onPressed: () => ctrl.setTab(3),
                              ),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.add, size: 16),
                                label: const Text('Add Product'),
                                onPressed: () => ctrl.setTab(1),
                              ),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.person_add, size: 16),
                                label: const Text('Add Customer'),
                                onPressed: () => ctrl.setTab(2),
                              ),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.account_balance, size: 16),
                                label: const Text('Add Account'),
                                onPressed: () => ctrl.setTab(4),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Recent Invoices Table
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Recent Invoices & Transactions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 12),
                    if (stats.recentInvoices.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(child: Text('No invoices recorded yet. Click New Invoice to create one.')),
                      )
                    else
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Invoice #')),
                            DataColumn(label: Text('Customer')),
                            DataColumn(label: Text('Total Amount')),
                            DataColumn(label: Text('Tax')),
                            DataColumn(label: Text('Status')),
                          ],
                          rows: stats.recentInvoices.map((inv) {
                            return DataRow(cells: [
                              DataCell(Text(inv.invoiceNumber, style: const TextStyle(fontWeight: FontWeight.bold))),
                              DataCell(Text(inv.customerName)),
                              DataCell(Text('\$${inv.totalAmount.toStringAsFixed(2)}')),
                              DataCell(Text('\$${inv.tax.toStringAsFixed(2)}')),
                              DataCell(_buildStatusChip(inv.status)),
                            ]);
                          }).toList(),
                        ),
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

  Widget _buildKpiCard(String title, String value, IconData icon, MaterialColor color) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 12, fontWeight: FontWeight.w600)),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(6)),
                  child: Icon(icon, size: 16, color: color.shade700),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color bg = Colors.grey.shade100;
    Color fg = Colors.grey.shade800;
    if (status.toLowerCase() == 'paid') {
      bg = Colors.green.shade50;
      fg = Colors.green.shade800;
    } else if (status.toLowerCase() == 'pending') {
      bg = Colors.amber.shade50;
      fg = Colors.amber.shade900;
    } else if (status.toLowerCase() == 'cancelled') {
      bg = Colors.red.shade50;
      fg = Colors.red.shade800;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(status.toUpperCase(), style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }
}

// Fallback color for emerald
extension ColorsEmerald on Colors {
  static MaterialColor get emerald => Colors.teal;
}

// ==============================================================================
// 4. INVENTORY / PRODUCTS SCREEN
// ==============================================================================

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final _searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ctrl = _ERPInheritedState.get(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Action Bar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, size: 20),
                      hintText: 'Search products by SKU, name, or category...',
                      suffixIcon: _searchCtrl.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () {
                                _searchCtrl.clear();
                                ctrl.loadProducts();
                              },
                            )
                          : null,
                    ),
                    onSubmitted: (val) => ctrl.loadProducts(val),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add Product'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  onPressed: () => _showProductDialog(context, ctrl),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Products Table Card
            Expanded(
              child: Card(
                color: Colors.white,
                child: ctrl.products.isEmpty
                    ? const Center(child: Text('No products in inventory. Add one above!'))
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                          width: double.infinity,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('SKU')),
                              DataColumn(label: Text('Product Name')),
                              DataColumn(label: Text('Category')),
                              DataColumn(label: Text('Price')),
                              DataColumn(label: Text('Cost')),
                              DataColumn(label: Text('Stock')),
                              DataColumn(label: Text('Actions')),
                            ],
                            rows: ctrl.products.map((p) {
                              return DataRow(cells: [
                                DataCell(Text(p.sku, style: const TextStyle(fontWeight: FontWeight.bold))),
                                DataCell(Text(p.name)),
                                DataCell(Chip(
                                  label: Text(p.category, style: const TextStyle(fontSize: 11)),
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                )),
                                DataCell(Text('\$${p.price.toStringAsFixed(2)}')),
                                DataCell(Text('\$${p.cost.toStringAsFixed(2)}')),
                                DataCell(
                                  Text(
                                    '${p.stock}',
                                    style: TextStyle(
                                      color: p.stock < 10 ? Colors.red : Colors.black,
                                      fontWeight: p.stock < 10 ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                DataCell(Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, size: 18, color: Colors.blue),
                                      onPressed: () => _showProductDialog(context, ctrl, product: p),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                                      onPressed: () async {
                                        final confirmed = await _confirmDialog(context, 'Delete product ${p.name}?');
                                        if (confirmed) await ctrl.deleteProduct(p.id);
                                      },
                                    ),
                                  ],
                                )),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductDialog(BuildContext context, ERPController ctrl, {Product? product}) {
    final skuCtrl = TextEditingController(text: product?.sku ?? '');
    final nameCtrl = TextEditingController(text: product?.name ?? '');
    final catCtrl = TextEditingController(text: product?.category ?? 'General');
    final priceCtrl = TextEditingController(text: product?.price.toString() ?? '0.00');
    final costCtrl = TextEditingController(text: product?.cost.toString() ?? '0.00');
    final stockCtrl = TextEditingController(text: product?.stock.toString() ?? '10');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(product == null ? 'Add New Product' : 'Edit Product'),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: skuCtrl, decoration: const InputDecoration(labelText: 'SKU')),
                const SizedBox(height: 12),
                TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Product Name')),
                const SizedBox(height: 12),
                TextField(controller: catCtrl, decoration: const InputDecoration(labelText: 'Category')),
                const SizedBox(height: 12),
                TextField(controller: priceCtrl, decoration: const InputDecoration(labelText: 'Sale Price (\$)', prefixText: '\$')),
                const SizedBox(height: 12),
                TextField(controller: costCtrl, decoration: const InputDecoration(labelText: 'Cost (\$)', prefixText: '\$')),
                const SizedBox(height: 12),
                TextField(controller: stockCtrl, decoration: const InputDecoration(labelText: 'Stock Quantity')),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final p = Product(
                id: product?.id ?? 0,
                sku: skuCtrl.text.trim(),
                name: nameCtrl.text.trim(),
                category: catCtrl.text.trim(),
                price: double.tryParse(priceCtrl.text) ?? 0.0,
                cost: double.tryParse(costCtrl.text) ?? 0.0,
                stock: int.tryParse(stockCtrl.text) ?? 0,
              );
              await ctrl.saveProduct(p, isEdit: product != null);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 5. CUSTOMERS (CRM) SCREEN
// ==============================================================================

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = _ERPInheritedState.get(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Customer Directory', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  icon: const Icon(Icons.person_add),
                  label: const Text('New Customer'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  onPressed: () => _showCustomerDialog(context, ctrl),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Card(
                color: Colors.white,
                child: ctrl.customers.isEmpty
                    ? const Center(child: Text('No customers found. Click New Customer to add one.'))
                    : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: ctrl.customers.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, i) {
                          final c = ctrl.customers[i];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.indigo.shade50,
                              child: Text(c.name.isNotEmpty ? c.name[0].toUpperCase() : 'C', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                            ),
                            title: Text(c.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('${c.email} • ${c.phone} • ${c.address}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Balance: \$${c.balance.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: const Icon(Icons.edit, size: 18, color: Colors.blue),
                                  onPressed: () => _showCustomerDialog(context, ctrl, customer: c),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                                  onPressed: () async {
                                    final confirmed = await _confirmDialog(context, 'Delete customer ${c.name}?');
                                    if (confirmed) await ctrl.deleteCustomer(c.id);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomerDialog(BuildContext context, ERPController ctrl, {Customer? customer}) {
    final nameCtrl = TextEditingController(text: customer?.name ?? '');
    final emailCtrl = TextEditingController(text: customer?.email ?? '');
    final phoneCtrl = TextEditingController(text: customer?.phone ?? '');
    final addrCtrl = TextEditingController(text: customer?.address ?? '');
    final balCtrl = TextEditingController(text: customer?.balance.toString() ?? '0.00');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(customer == null ? 'Add Customer' : 'Edit Customer'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Customer Name')),
              const SizedBox(height: 12),
              TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email Address')),
              const SizedBox(height: 12),
              TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: 'Phone Number')),
              const SizedBox(height: 12),
              TextField(controller: addrCtrl, decoration: const InputDecoration(labelText: 'Physical Address')),
              const SizedBox(height: 12),
              TextField(controller: balCtrl, decoration: const InputDecoration(labelText: 'Balance (\$)', prefixText: '\$')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final c = Customer(
                id: customer?.id ?? 0,
                name: nameCtrl.text.trim(),
                email: emailCtrl.text.trim(),
                phone: phoneCtrl.text.trim(),
                address: addrCtrl.text.trim(),
                balance: double.tryParse(balCtrl.text) ?? 0.0,
              );
              await ctrl.saveCustomer(c, isEdit: customer != null);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 6. POS / SALES & INVOICES SCREEN
// ==============================================================================

class POSInvoicesScreen extends StatelessWidget {
  const POSInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = _ERPInheritedState.get(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Sales & Invoicing Ledger', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Create Invoice'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  onPressed: () => _showCreateInvoiceDialog(context, ctrl),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Card(
                color: Colors.white,
                child: ctrl.invoices.isEmpty
                    ? const Center(child: Text('No invoices recorded yet. Click Create Invoice.'))
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                          width: double.infinity,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Invoice #')),
                              DataColumn(label: Text('Customer')),
                              DataColumn(label: Text('Total Amount')),
                              DataColumn(label: Text('Tax')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Change Status')),
                              DataColumn(label: Text('Actions')),
                            ],
                            rows: ctrl.invoices.map((inv) {
                              return DataRow(cells: [
                                DataCell(Text(inv.invoiceNumber, style: const TextStyle(fontWeight: FontWeight.bold))),
                                DataCell(Text(inv.customerName)),
                                DataCell(Text('\$${inv.totalAmount.toStringAsFixed(2)}')),
                                DataCell(Text('\$${inv.tax.toStringAsFixed(2)}')),
                                DataCell(_buildStatusChip(inv.status)),
                                DataCell(
                                  DropdownButton<String>(
                                    value: inv.status.toLowerCase(),
                                    underline: const SizedBox(),
                                    items: const [
                                      DropdownMenuItem(value: 'paid', child: Text('Paid')),
                                      DropdownMenuItem(value: 'pending', child: Text('Pending')),
                                      DropdownMenuItem(value: 'cancelled', child: Text('Cancelled')),
                                    ],
                                    onChanged: (val) {
                                      if (val != null) ctrl.updateInvoiceStatus(inv.id, val);
                                    },
                                  ),
                                ),
                                DataCell(
                                  IconButton(
                                    icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                                    onPressed: () async {
                                      final confirmed = await _confirmDialog(context, 'Delete invoice ${inv.invoiceNumber}?');
                                      if (confirmed) await ctrl.deleteInvoice(inv.id);
                                    },
                                  ),
                                ),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateInvoiceDialog(BuildContext context, ERPController ctrl) {
    int selectedCustomerId = ctrl.customers.isNotEmpty ? ctrl.customers.first.id : 1;
    final totalCtrl = TextEditingController(text: '199.99');
    final taxCtrl = TextEditingController(text: '15.00');
    String status = 'paid';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('Create New ERP Invoice'),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<int>(
                  value: selectedCustomerId,
                  decoration: const InputDecoration(labelText: 'Customer'),
                  items: ctrl.customers.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
                  onChanged: (val) => setState(() => selectedCustomerId = val!),
                ),
                const SizedBox(height: 12),
                TextField(controller: totalCtrl, decoration: const InputDecoration(labelText: 'Total Amount (\$)', prefixText: '\$')),
                const SizedBox(height: 12),
                TextField(controller: taxCtrl, decoration: const InputDecoration(labelText: 'Tax Amount (\$)', prefixText: '\$')),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: status,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: const [
                    DropdownMenuItem(value: 'paid', child: Text('Paid')),
                    DropdownMenuItem(value: 'pending', child: Text('Pending')),
                    DropdownMenuItem(value: 'cancelled', child: Text('Cancelled')),
                  ],
                  onChanged: (val) => setState(() => status = val!),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () async {
                final inv = Invoice(
                  id: 0,
                  invoiceNumber: 'INV-${DateTime.now().year}-${DateTime.now().millisecondsSinceEpoch % 10000}',
                  customerId: selectedCustomerId,
                  customerName: '',
                  totalAmount: double.tryParse(totalCtrl.text) ?? 0.0,
                  tax: double.tryParse(taxCtrl.text) ?? 0.0,
                  status: status,
                  createdAt: '',
                );
                await ctrl.createInvoice(inv);
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color bg = Colors.grey.shade100;
    Color fg = Colors.grey.shade800;
    if (status.toLowerCase() == 'paid') {
      bg = Colors.green.shade50;
      fg = Colors.green.shade800;
    } else if (status.toLowerCase() == 'pending') {
      bg = Colors.amber.shade50;
      fg = Colors.amber.shade900;
    } else if (status.toLowerCase() == 'cancelled') {
      bg = Colors.red.shade50;
      fg = Colors.red.shade800;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(status.toUpperCase(), style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }
}

// ==============================================================================
// 7. ACCOUNTING SCREEN (CHART OF ACCOUNTS)
// ==============================================================================

class AccountingScreen extends StatelessWidget {
  const AccountingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = _ERPInheritedState.get(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('General Ledger & Chart of Accounts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('New Account'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  onPressed: () => _showAccountDialog(context, ctrl),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Card(
                color: Colors.white,
                child: ctrl.accounts.isEmpty
                    ? const Center(child: Text('No accounts configured. Click New Account.'))
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                          width: double.infinity,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Code')),
                              DataColumn(label: Text('Account Name')),
                              DataColumn(label: Text('Type')),
                              DataColumn(label: Text('Balance')),
                              DataColumn(label: Text('Actions')),
                            ],
                            rows: ctrl.accounts.map((acc) {
                              return DataRow(cells: [
                                DataCell(Text(acc.accountCode, style: const TextStyle(fontWeight: FontWeight.bold))),
                                DataCell(Text(acc.accountName)),
                                DataCell(_buildAccountTypeChip(acc.accountType)),
                                DataCell(Text('\$${acc.balance.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold))),
                                DataCell(Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, size: 18, color: Colors.blue),
                                      onPressed: () => _showAccountDialog(context, ctrl, account: acc),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                                      onPressed: () async {
                                        final confirmed = await _confirmDialog(context, 'Delete account ${acc.accountName}?');
                                        if (confirmed) await ctrl.deleteAccount(acc.id);
                                      },
                                    ),
                                  ],
                                )),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountTypeChip(String type) {
    Color bg = Colors.blue.shade50;
    Color fg = Colors.blue.shade800;
    if (type.toLowerCase() == 'liability') {
      bg = Colors.red.shade50;
      fg = Colors.red.shade800;
    } else if (type.toLowerCase() == 'equity') {
      bg = Colors.purple.shade50;
      fg = Colors.purple.shade800;
    } else if (type.toLowerCase() == 'revenue') {
      bg = Colors.green.shade50;
      fg = Colors.green.shade800;
    } else if (type.toLowerCase() == 'expense') {
      bg = Colors.orange.shade50;
      fg = Colors.orange.shade800;
    }
    return Chip(
      label: Text(type, style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.bold)),
      backgroundColor: bg,
      side: BorderSide.none,
      visualDensity: VisualDensity.compact,
    );
  }

  void _showAccountDialog(BuildContext context, ERPController ctrl, {Account? account}) {
    final codeCtrl = TextEditingController(text: account?.accountCode ?? '');
    final nameCtrl = TextEditingController(text: account?.accountName ?? '');
    final balCtrl = TextEditingController(text: account?.balance.toString() ?? '0.00');
    String type = account?.accountType ?? 'Asset';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(account == null ? 'Add General Ledger Account' : 'Edit Account'),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: codeCtrl, decoration: const InputDecoration(labelText: 'Account Code (e.g. 1010)')),
                const SizedBox(height: 12),
                TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Account Name')),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: type,
                  decoration: const InputDecoration(labelText: 'Account Type'),
                  items: const [
                    DropdownMenuItem(value: 'Asset', child: Text('Asset')),
                    DropdownMenuItem(value: 'Liability', child: Text('Liability')),
                    DropdownMenuItem(value: 'Equity', child: Text('Equity')),
                    DropdownMenuItem(value: 'Revenue', child: Text('Revenue')),
                    DropdownMenuItem(value: 'Expense', child: Text('Expense')),
                  ],
                  onChanged: (val) => setState(() => type = val!),
                ),
                const SizedBox(height: 12),
                TextField(controller: balCtrl, decoration: const InputDecoration(labelText: 'Opening Balance (\$)', prefixText: '\$')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () async {
                final a = Account(
                  id: account?.id ?? 0,
                  accountCode: codeCtrl.text.trim(),
                  accountName: nameCtrl.text.trim(),
                  accountType: type,
                  balance: double.tryParse(balCtrl.text) ?? 0.0,
                );
                await ctrl.saveAccount(a, isEdit: account != null);
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================================================================
// 8. HR & PAYROLL SCREEN
// ==============================================================================

class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = _ERPInheritedState.get(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Human Resources & Staff Directory', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  icon: const Icon(Icons.badge),
                  label: const Text('Add Employee'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  onPressed: () => _showEmployeeDialog(context, ctrl),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Card(
                color: Colors.white,
                child: ctrl.employees.isEmpty
                    ? const Center(child: Text('No employees found. Add one above!'))
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                          width: double.infinity,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Email')),
                              DataColumn(label: Text('Department')),
                              DataColumn(label: Text('Position')),
                              DataColumn(label: Text('Salary')),
                              DataColumn(label: Text('Hire Date')),
                              DataColumn(label: Text('Actions')),
                            ],
                            rows: ctrl.employees.map((emp) {
                              return DataRow(cells: [
                                DataCell(Text('${emp.firstName} ${emp.lastName}', style: const TextStyle(fontWeight: FontWeight.bold))),
                                DataCell(Text(emp.email)),
                                DataCell(Chip(
                                  label: Text(emp.department, style: const TextStyle(fontSize: 11)),
                                  visualDensity: VisualDensity.compact,
                                )),
                                DataCell(Text(emp.position)),
                                DataCell(Text('\$${emp.salary.toStringAsFixed(2)}')),
                                DataCell(Text(emp.hireDate)),
                                DataCell(Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, size: 18, color: Colors.blue),
                                      onPressed: () => _showEmployeeDialog(context, ctrl, employee: emp),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                                      onPressed: () async {
                                        final confirmed = await _confirmDialog(context, 'Delete employee ${emp.firstName}?');
                                        if (confirmed) await ctrl.deleteEmployee(emp.id);
                                      },
                                    ),
                                  ],
                                )),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEmployeeDialog(BuildContext context, ERPController ctrl, {Employee? employee}) {
    final fnCtrl = TextEditingController(text: employee?.firstName ?? '');
    final lnCtrl = TextEditingController(text: employee?.lastName ?? '');
    final emailCtrl = TextEditingController(text: employee?.email ?? '');
    final deptCtrl = TextEditingController(text: employee?.department ?? 'Engineering');
    final posCtrl = TextEditingController(text: employee?.position ?? 'Software Engineer');
    final salCtrl = TextEditingController(text: employee?.salary.toString() ?? '85000.00');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(employee == null ? 'Add Employee' : 'Edit Employee'),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: fnCtrl, decoration: const InputDecoration(labelText: 'First Name')),
                const SizedBox(height: 12),
                TextField(controller: lnCtrl, decoration: const InputDecoration(labelText: 'Last Name')),
                const SizedBox(height: 12),
                TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email Address')),
                const SizedBox(height: 12),
                TextField(controller: deptCtrl, decoration: const InputDecoration(labelText: 'Department')),
                const SizedBox(height: 12),
                TextField(controller: posCtrl, decoration: const InputDecoration(labelText: 'Job Position')),
                const SizedBox(height: 12),
                TextField(controller: salCtrl, decoration: const InputDecoration(labelText: 'Annual Salary (\$)', prefixText: '\$')),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final emp = Employee(
                id: employee?.id ?? 0,
                firstName: fnCtrl.text.trim(),
                lastName: lnCtrl.text.trim(),
                email: emailCtrl.text.trim(),
                department: deptCtrl.text.trim(),
                position: posCtrl.text.trim(),
                salary: double.tryParse(salCtrl.text) ?? 0.0,
                hireDate: employee?.hireDate ?? DateTime.now().toIso8601String().substring(0, 10),
              );
              await ctrl.saveEmployee(emp, isEdit: employee != null);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// COMMON UTILS & DIALOGS
// ==============================================================================

Future<bool> _confirmDialog(BuildContext context, String message) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Confirm Action'),
      content: Text(message),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
  return result ?? false;
}
