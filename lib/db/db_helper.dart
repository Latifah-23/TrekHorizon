
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cryptography/cryptography.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  static final List<Map<String, dynamic>> _webMockUsers = [];
  static Map<String, dynamic>? _currentUser;

  static final _algorithm = Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: 600000,
    bits: 256,
  );

  // Password hashing
  Future<String> _hashPassword(String password) async {
    final random = Random.secure();
    final salt = List<int>.generate(
      16, (_) => random.nextInt(256),
    );

    final key = await _algorithm.deriveKey(
      secretKey: SecretKey(utf8.encode(password)),
      nonce: salt,
    );

    final hash = await key.extractBytes();

    return 'pbkdf2\$${base64Encode(salt)}\$${base64Encode(hash)}';
  }

  // Password verification
  Future<bool> _verifyPassword(
    String password,
    String storedPassword,
  ) async {
    if (!storedPassword.startsWith('pbkdf2\$')) {
      return password == storedPassword;
    }

    final parts = storedPassword.split('\$');
    if (parts.length != 3) return false;

    final salt = base64Decode(parts[1]);
    final expected = base64Decode(parts[2]);

    final key = await _algorithm.deriveKey(
      secretKey: SecretKey(utf8.encode(password)),
      nonce: salt,
    );

    final actual = await key.extractBytes();

    if (actual.length != expected.length) return false;

    int difference = 0;

    for (int i = 0; i < actual.length; i++) {
      difference |= actual[i] ^ expected[i];
    }

    return difference == 0;
  }

  Future<Database?> get database async {
    if (kIsWeb) return null;

    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = join(
      await getDatabasesPath(),
      'camping_app.db',
    );

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE,
            password TEXT,
            phone TEXT,
            name TEXT
          )
        ''');
      },
    );
  }

  // Register a new user
  Future<bool> registerUser(Map<String, dynamic> user) async {
    try {
      final newUser = Map<String, dynamic>.from(user);

      newUser['password'] =
          await _hashPassword(user['password'] as String);

      if (kIsWeb) {
        bool exists = _webMockUsers.any(
          (u) => u['email'] == newUser['email'],
        );

        if (exists) return false;

        _webMockUsers.add(newUser);
        debugPrint("Web: User Registered Successfully");
        return true;
      } else {
        Database? db = await database;
        await db!.insert('users', newUser);
        return true;
      }
    } catch (_) {
      debugPrint("Error registering user");
      return false;
    }
  }

  // Login
  Future<bool> loginUser(String email, String password) async {
    try {
      _currentUser = null;

      Map<String, dynamic> user;

      if (kIsWeb) {
        user = _webMockUsers.firstWhere(
          (u) => u['email'] == email,
          orElse: () => {},
        );
      } else {
        Database? db = await database;

        final result = await db!.query(
          'users',
          where: 'email = ?',
          whereArgs: [email],
        );

        if (result.isEmpty) return false;

        user = Map<String, dynamic>.from(result.first);
      }

      if (user.isEmpty) return false;

      final storedPassword = user['password'] as String;

      if (!await _verifyPassword(password, storedPassword)) {
        return false;
      }

      // Upgrade legacy plaintext passwords
      if (!storedPassword.startsWith('pbkdf2\$')) {
        final hashedPassword = await _hashPassword(password);

        if (!kIsWeb) {
          final db = await database;

          await db!.update(
            'users',
            {'password': hashedPassword},
            where: 'email = ?',
            whereArgs: [email],
          );
        }

        user['password'] = hashedPassword;
      }

      _currentUser = Map<String, dynamic>.from(user)
        ..remove('password');

      return true;
    } catch (_) {
      debugPrint("Login Error");
      return false;
    }
  }

  // Get current user without password
  Map<String, dynamic>? getCurrentUser() {
    if (_currentUser == null) return null;

    return Map<String, dynamic>.from(_currentUser!);
  }

  // Update user profile
  Future<void> updateCurrentUser(
    Map<String, dynamic> updatedData,
  ) async {
    if (_currentUser == null) return;

    final oldEmail = _currentUser!['email'];

    final safeData = Map<String, dynamic>.from(updatedData)
      ..remove('id');

    if (safeData.containsKey('password')) {
      safeData['password'] =
          await _hashPassword(safeData['password'] as String);
    }

    if (safeData.isEmpty) return;

    if (kIsWeb) {
      final index = _webMockUsers.indexWhere(
        (u) => u['email'] == oldEmail,
      );

      if (index == -1) return;

      if (safeData.containsKey('email') &&
          _webMockUsers.any(
            (u) => u['email'] == safeData['email'] &&
                u['email'] != oldEmail,
          )) {
        return;
      }

      _webMockUsers[index].addAll(safeData);
    } else {
      Database? db = await database;

      final count = await db!.update(
        'users',
        safeData,
        where: 'email = ?',
        whereArgs: [oldEmail],
      );

      if (count == 0) return;
    }

    safeData.remove('password');
    _currentUser!.addAll(safeData);
  }

  // Notifications
  static final List<Map<String, String>>
      _webMockNotifications = [];

  Future<void> addNotification(
    String title,
    String body,
  ) async {
    String time =
        "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}";

    _webMockNotifications.insert(0, {
      'title': title,
      'body': body,
      'time': time,
      'date': DateTime.now().toString().split(' ')[0],
    });
  }

  Future<List<Map<String, String>>> getNotifications() async {
    return _webMockNotifications;
  }
}
