**[Türkçe](#turkce) | [English](#english)**

# <a name="turkce"></a>Flutter ile yazılmış Quiz Mobil Uygulaması
*Not: Proje kişisel bir çalışma olduğu için kodların bazı kısımları paylaşılmamıştır. Anlayışınız için teşekkür ederim.*

Bu projede, Flutter ile geliştirilen ve MySQL veritabanına bağlı PHP tabanlı bir API ile çalışan bir quiz mobil uygulaması yer almaktadır. Uygulama, kullanıcı deneyimini ve etkileşimi artırmak için çeşitli özellikler içermektedir. İşte bu uygulamanın sunduğu özellikler:

## Özellikler
1. **Mail Onayı Gerektiren Kayıt Sistemi**
   - Yeni kullanıcılar, mail onayı gerektiren bir kayıt sistemi ile güvenli bir şekilde sisteme dahil olabilirler.

2. **Giriş Sistemi**
   - Kullanıcılar, e-posta veya kullanıcı adı ile şifrelerini kullanarak giriş yapabilirler.

3. **Farklı Kategorilerde Sorular**
   - Uygulama içerisinde çeşitli kategoriler bulunmakta ve her kategoriye özel sorular sunulmaktadır. Bu sayede kullanıcılar ilgi alanlarına göre seçim yapabilir.

4. **Kullanıcı Sıralama Sistemi**
   - Kullanıcıların günlük, aylık ve tüm zamanlar bazında sıralamaları görüntülenir. Sıralama, doğru cevap sayısı ve çözülen soru sayısına göre hesaplanır.

5. **Zamana Karşı Soru Çözme**
   - Kullanıcılar belirli bir süre içerisinde soruları çözmeye çalışır. Bu özellik, hızlı düşünme ve karar verme becerilerini geliştirmeyi amaçlar.

6. **Kullanıcı Bilgilerini Güncelleme**
   - Kullanıcılar, hesap ayarları bölümünden kullanıcı adı, e-posta ve şifrelerini değiştirebilirler.

7. **Avatar Seçme**
   - Uygulamada bulunan çeşitli avatarlar arasından kullanıcı, profilini temsil edecek avatarı seçebilir.

8. **Kullanıcı Tarafından Soru Gönderme**
   - Kullanıcılar, sisteme yeni sorular ekleyebilir ve bu sorular onaylandıktan sonra diğer kullanıcılarla paylaşılabilir.

9. **Hesap Silme**
   - Kullanıcılar, hesap ayarları üzerinden hesaplarını kalıcı olarak silebilirler.

10. **Joker Kullanma Sistemi**
    - Soruları çözerken kullanıcılar 3 farklı joker hakkına sahip olabilir:
      - **Doğru Cevap**: Doğru cevabı direkt gösterir.
      - **Çift Cevap**: Kullanıcıya iki cevap hakkı verir.
      - **Yarı Yarıya**: Yanlış olan iki seçeneği eleyerek seçenekleri azaltır.

11. **Duyuru Sistemi**
    - Uygulama üzerinden önemli bilgiler veya güncellemeler duyurular aracılığıyla kullanıcılara iletilir.

12. **Sorun Bildirme**
    - Kullanıcılar, herhangi bir sorun yaşadıklarında uygulama içerisinden sorun bildiriminde bulunabilirler.

### APK Dosyası:
[APK Dosyasını indir](https://drive.google.com/file/d/1pNl1QZn5B2i4cr05vimD1JsFT3jjCWk-/view?usp=sharing)

### Demo Hesap Bilgileri:
Uygulamayı denemek için aşağıdaki hesap bilgilerini kullanabilirsiniz:

- **Kullanıcı Adı:** DemoAccount
- **Email:** demo@demo.com
- **Şifre:** 123456

Bu bilgilerle uygulamaya giriş yaparak tüm özellikleri keşfedebilirsiniz.

### Uygulamada Kullanılan Diller ve Teknolojiler: 
İsim  | Versiyon
------------- | -------------
Flutter | 3.24.3
Dart | 3.5.3
Get | 4.6.6
Firebase Core | 3.6.0
Firebase Messaging | 15.1.3
Firebase Remote Config | 5.1.3
Firebase Crashlytics | 4.1.3
Firebase Analytics | 11.3.3
Flutter Local Notifications | 17.2.3

### Ekran Görüntüleri:
<p>Aşağıda uygulamanın bazı ekran görüntülerini bulabilirsiniz:</p>

### 1. Giriş ve Kayıt Ekranları
<a><img src="https://github.com/cengizhanerturan/flutter_quiz_app/blob/main/app_images/login.png" alt="Giriş ve Kayıt" style="max-width: 100%;" /></a>

### 2. Hesap Onayı Ekranı
<a><img src="https://github.com/cengizhanerturan/flutter_quiz_app/blob/main/app_images/verification.png" alt="Hesap Onayı" style="max-width: 100%;" /></a>

### 3. Anasayfa ve Profil Ekranları
<a><img src="https://github.com/cengizhanerturan/flutter_quiz_app/blob/main/app_images/home.png" alt="Anasayfa ve Profil" style="max-width: 100%;" /></a>

### 4. Kategori ve Soru Çözme Ekranları
<a><img src="https://github.com/cengizhanerturan/flutter_quiz_app/blob/main/app_images/category.png" alt="Kategori ve Soru Çözme" style="max-width: 100%;" /></a>

### 5. Sıralama ve Duyuru Ekranları
<a><img src="https://github.com/cengizhanerturan/flutter_quiz_app/blob/main/app_images/leaderboard.png" alt="Sıralama ve Duyuru" style="max-width: 100%;" /></a>

### 6. Soru Gönderme ve Ayarlar Ekranları
<a><img src="https://github.com/cengizhanerturan/flutter_quiz_app/blob/main/app_images/settings.png" alt="Soru Gönderme ve Ayarlar" style="max-width: 100%;" /></a>

### 7. Email, Kulllanıcı Adı ve Şifre Değiştirme Ekranları
<a><img src="https://github.com/cengizhanerturan/flutter_quiz_app/blob/main/app_images/change_email.png" alt="Email, Kulllanıcı Adı ve Şifre Değiştirme" style="max-width: 100%;" /></a>

### 8. Sorun Bildirme Ekranı ve Dialoglar
<a><img src="https://github.com/cengizhanerturan/flutter_quiz_app/blob/main/app_images/feedback.png" alt="Sorun Bildirme Ekranı ve Dialoglar" style="max-width: 100%;" /></a>

# <a name="english"></a>Quiz Mobile Application Built with Flutter
*Note: Since this project is a personal study, some parts of the code have not been shared. Thank you for your understanding.*

This project is a quiz mobile application developed with Flutter, connected to a MySQL database, and powered by a PHP-based API. The app is designed with a variety of features to enhance user experience and engagement. Here are the features of this application:

## Features
1. **Email Verification Required for Registration**
   - New users can securely join the system through a registration process that requires email verification.

2. **Login System**
   - Users can log in using their email or username and password.

3. **Questions in Different Categories**
   - The application offers various categories, each with its own set of questions, allowing users to choose based on their interests.

4. **User Ranking System**
   - Daily, monthly, and all-time rankings are displayed based on the number of correct answers and questions completed by users.

5. **Time-Based Quiz Mode**
   - Users attempt to solve questions within a specified time limit, aiming to improve quick thinking and decision-making skills.

6. **Update User Information**
   - Users can update their username, email, and password from the account settings section.

7. **Avatar Selection**
   - Users can choose an avatar from a variety available in the app to represent their profile.

8. **User-Generated Questions**
   - Users can submit new questions to the system, which can be shared with other users once approved.

9. **Account Deletion**
   - Users can permanently delete their accounts through the account settings.

10. **Lifeline System**
    - While solving questions, users have access to three different lifelines:
      - **Correct Answer**: Directly reveals the correct answer.
      - **Double Answer**: Allows the user two attempts at answering.
      - **Fifty-Fifty**: Eliminates two incorrect options, reducing the choices.

11. **Announcement System**
    - Important information or updates are communicated to users through in-app announcements.

12. **Report Issue**
    - Users can report any issues they encounter within the app.

### APK File:
[Download APK](https://drive.google.com/file/d/1pNl1QZn5B2i4cr05vimD1JsFT3jjCWk-/view?usp=sharing)

### Demo Account Information:
You can use the following account details to try out the application:

- **Username:** DemoAccount
- **Email:** demo@demo.com
- **Password:** 123456

You can log in to the application with this information to explore all the features.

### Languages and Technologies Used in the App:
Name  | Version
------------- | -------------
Flutter | 3.24.3
Dart | 3.5.3
Get | 4.6.6
Firebase Core | 3.6.0
Firebase Messaging | 15.1.3
Firebase Remote Config | 5.1.3
Firebase Crashlytics | 4.1.3
Firebase Analytics | 11.3.3
Flutter Local Notifications | 17.2.3

### Screenshots:
Below are some screenshots of the application:

### 1. Login and Registration Screens
<a><img src="https://github.com/cengizhanerturan/flutter_quiz_app/blob/main/app_images/login.png" alt="Login and Registration" style="max-width: 100%;" /></a>

### 2. Account Verification Screen
<a><img src="https://github.com/cengizhanerturan/flutter_quiz_app/blob/main/app_images/verification.png" alt="Account Verification" style="max-width: 100%;" /></a>

### 3. Home and Profile Screens
<a><img src="https://github.com/cengizhanerturan/flutter_quiz_app/blob/main/app_images/home.png" alt="Home and Profile" style="max-width: 100%;" /></a>

### 4. Category and Quiz Screens
<a><img src="https://github.com/cengizhanerturan/flutter_quiz_app/blob/main/app_images/category.png" alt="Category and Quiz" style="max-width: 100%;" /></a>

### 5. Leaderboard and Announcement Screens
<a><img src="https://github.com/cengizhanerturan/flutter_quiz_app/blob/main/app_images/leaderboard.png" alt="Leaderboard and Announcement" style="max-width: 100%;" /></a>

### 6. Question Submission and Settings Screens
<a><img src="https://github.com/cengizhanerturan/flutter_quiz_app/blob/main/app_images/settings.png" alt="Question Submission and Settings" style="max-width: 100%;" /></a>

### 7. Email, Username and Password Update Screens
<a><img src="https://github.com/cengizhanerturan/flutter_quiz_app/blob/main/app_images/change_email.png" alt="Email, Username and Password Update" style="max-width: 100%;" /></a>

### 8. Report Issue Screen and Dialogs
<a><img src="https://github.com/cengizhanerturan/flutter_quiz_app/blob/main/app_images/feedback.png" alt="Report Issue Screen and Dialogs" style="max-width: 100%;" /></a>