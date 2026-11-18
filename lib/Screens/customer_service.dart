import 'package:flutter/material.dart';

// تعريف أنواع الرسائل
enum MessageSender { user, ai, agent, system }

class ContactCustomerServiceScreen extends StatefulWidget {
  const ContactCustomerServiceScreen({super.key});

  @override
  State<ContactCustomerServiceScreen> createState() => _ContactCustomerServiceScreenState();
}

class _ContactCustomerServiceScreenState extends State<ContactCustomerServiceScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isAiMode = true; // هل نحن في وضع الذكاء الاصطناعي؟

  @override
  void initState() {
    super.initState();
    // رسالة الترحيب الافتتاحية من AI
    _messages.add({
      'text': 'مرحبًا بك في خدمة الدعم. أنا مساعدك الافتراضي، كيف يمكنني مساعدتك اليوم؟',
      'sender': MessageSender.ai,
    });
    _messages.add({
      'text': 'We’re here to help you with your questions, orders, or issues',
      'sender': MessageSender.system,
    });
  }

  // محاكاة استجابة من الذكاء الاصطناعي
  void _simulateAiResponse(String userMessage) async {
    // 1. إظهار رسالة التحميل (Typing Indicator)
    setState(() {
      _messages.add({'text': 'AI is typing...', 'sender': MessageSender.ai, 'isTyping': true});
    });

    // 2. محاكاة التأخير
    await Future.delayed(const Duration(seconds: 2));

    // 3. إزالة رسالة التحميل
    setState(() {
      _messages.removeLast();
    });

    // 4. توليد استجابة (محاكاة)
    String response;
    if (userMessage.toLowerCase().contains('connect') || userMessage.toLowerCase().contains('human')) {
      response = 'أتفهم. سأقوم بتحويلك إلى أحد ممثلي خدمة العملاء الآن...';
      _messages.add({'text': response, 'sender': MessageSender.ai});
      _switchToAgent();
    } else {
      response = 'قد تكون هذه مشكلة في الدفع. هل حاولت التحقق من إعدادات محفظتك (Wallet)؟ إذا لم يساعدك هذا، يمكنك كتابة "Connect" للتحدث مع موظف.';
      _messages.add({'text': response, 'sender': MessageSender.ai});
    }
  }

  // التبديل إلى وضع خدمة العملاء المباشرة
  void _switchToAgent() {
    setState(() {
      _isAiMode = false;
      _messages.add({
        'text': 'تم تحويلك إلى موظف الدعم. سيقوم بالرد عليك قريباً.',
        'sender': MessageSender.system,
      });
      // في تطبيق حقيقي: هنا يتم فتح اتصال API بخدمة العملاء
    });
  }

  // معالجة إرسال الرسالة
  void _handleSubmitted(String text) {
    if (text.isEmpty) return;
    _textController.clear();

    // 1. إضافة رسالة المستخدم
    setState(() {
      _messages.add({'text': text, 'sender': MessageSender.user});
    });

    // 2. معالجة الاستجابة
    if (_isAiMode) {
      _simulateAiResponse(text);
    } else {
      // تم استبدال print برسالة SnackBar لمحاكاة السلوك
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent to Agent.')),
      );
    }
  }

  // ويدجت لعرض فقاعة الرسالة
  Widget _buildMessage(Map<String, dynamic> message) {
    final sender = message['sender'] as MessageSender;
    final isUser = sender == MessageSender.user;
    final isSystem = sender == MessageSender.system;
    final color = isUser ? const Color(0xE540281E) : (isSystem ? Colors.grey.shade500 : const Color(0xFFE5BE85));
    final textColor = isUser ? Colors.white : (isSystem ? Colors.white : const Color(0xFF543D34));
    final alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;
    final radius = isUser
        ? const BorderRadius.only(topLeft: Radius.circular(16), bottomRight: Radius.circular(16), bottomLeft: Radius.circular(16))
        : const BorderRadius.only(topRight: Radius.circular(16), bottomRight: Radius.circular(16), bottomLeft: Radius.circular(16));
    
    // محاكاة وضع الكتابة
    if (message['isTyping'] == true) {
      return Align(
        alignment: alignment,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: color, borderRadius: radius),
          child: const Text('...AI is typing', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic)),
        ),
      );
    }

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(color: color, borderRadius: radius),
        child: Text(
          message['text']!,
          style: TextStyle(color: textColor, fontFamily: 'Tajawal', fontWeight: FontWeight.w500, height: 1.47),
        ),
      ),
    );
  }
  
  // ويدجت لإنشاء شريط الإدخال
  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: const Color(0xFF40281E), width: 1.5),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  decoration: const InputDecoration(
                    hintText: 'Message',
                    hintStyle: TextStyle(color: Color(0xBF40281E), fontSize: 16, fontFamily: 'Raleway', fontWeight: FontWeight.w500),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // زر الإرسال
          InkWell(
            onTap: () => _handleSubmitted(_textController.text),
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: const Color(0xFFE5BE85),
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: const Color(0xFF40281E)),
              ),
              child: const Icon(Icons.send, color: Color(0xFF40281E), size: 20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Contact Customer Service',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF40281E),
            fontSize: 25,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF40281E)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // 1. منطقة المحادثة (قابلة للتمرير)
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true, // لعرض أحدث رسالة في الأسفل
              itemBuilder: (_, int index) => _buildMessage(_messages[_messages.length - 1 - index]),
              itemCount: _messages.length,
            ),
          ),
          
          // 2. زر التحويل (يظهر فقط إذا كنا في وضع AI)
          if (_isAiMode)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
                onPressed: _switchToAgent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9B5F3B),
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Connect to Human Agent', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            
          const Divider(height: 1.0),
          // 3. شريط إرسال الرسائل
          _buildTextComposer(),
        ],
      ),
    );
  }
}