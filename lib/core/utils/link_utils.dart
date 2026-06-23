import 'package:url_launcher/url_launcher.dart';

class LinkUtils {
  LinkUtils._();

  static Future<void> triggerWhatsApp(String? phone, [String? recruiterName]) async {
    if (phone == null || phone.isEmpty) return;
    
    // Clean phone number
    String cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanPhone.length == 10) {
      cleanPhone = '91$cleanPhone';
    }
    
    final text = recruiterName != null && recruiterName.isNotEmpty
        ? 'Hi ${recruiterName.trim()}, '
        : '';
    final encodedText = Uri.encodeComponent(text);
    
    final uri = Uri.parse('whatsapp://send?phone=$cleanPhone&text=$encodedText');
    final fallbackUri = Uri.parse('https://api.whatsapp.com/send?phone=$cleanPhone&text=$encodedText');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> triggerSMS(String? phone) async {
    if (phone == null || phone.isEmpty) return;
    final cleanPhone = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    final uri = Uri.parse('sms:$cleanPhone');
    final fallbackUri = Uri.parse('https://messages.google.com/web/conversations/new?phone=$cleanPhone');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> triggerGmail(String? email, [String? recruiterName]) async {
    if (email == null || email.isEmpty) return;
    final subject = Uri.encodeComponent("Job Application Status");
    final body = recruiterName != null && recruiterName.isNotEmpty
        ? Uri.encodeComponent("Hi ${recruiterName.trim()},\n\n")
        : '';
        
    final uri = Uri.parse('mailto:$email?subject=$subject&body=$body');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static Future<void> triggerPhone(String? phone) async {
    if (phone == null || phone.isEmpty) return;
    final cleanPhone = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    final uri = Uri.parse('tel:$cleanPhone');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static Future<void> launchWeb(String? url) async {
    if (url == null || url.isEmpty) return;
    var cleanUrl = url.trim();
    if (!cleanUrl.startsWith('http://') && !cleanUrl.startsWith('https://')) {
      cleanUrl = 'https://$cleanUrl';
    }
    final uri = Uri.parse(cleanUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
