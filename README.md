JI Storekeeper App

JI Storekeeper is a simple yet powerful Flutter application that helps users manage their inventory efficiently.
You can add, edit, delete, and search products, all stored locally using SQLite.

🎥 Demo Video: https://drive.google.com/file/d/18IRi08_JLPmefzDXhmNeec-9D9q-6ujc/view?usp=drive_link

📱 Download APK:https://drive.google.com/file/d/1FNJYu5QEWrVxi-_yoF2g8Q_ZfRzBY_97/view?usp=drive_link

✨ Features

🧾 Add new products with name, quantity, price, and image

✏ Edit existing products easily

❌ Delete products from your list

🔍 Search and filter products

🌓 Switch between Dark and Light modes

💾 Offline storage using SQLite Database

📸 Upload images from Gallery or Camera

🧩 Tech Stack
Technology	Description
Flutter	Frontend framework
Dart	Programming language
SQLite (sqflite)	Local database
Provider	State management
Image Picker	Capturing and selecting product images
Permission Handler	Managing camera and storage permissions
📂 Project Structure
lib/
│
├── models/
│   └── product.dart
│
├── services/
│   └── database_helper.dart
│
├── providers/
│   └── theme_provider.dart
│
├── screens/
│   ├── product_list_screen.dart
│   ├── add_edit_product_screen.dart
│   ├── product_detail_screen.dart
│   └── settings_screen.dart
│
└── widgets/
    └── product_card.dart

⚙️ How to Run Locally

1️⃣ Clone the repository:

git clone https://github.com/jesuferanmi-0620/Storekeeper_app.git


2️⃣ Navigate to the project folder:

cd storekeeper_app


3️⃣ Install dependencies:

flutter pub get


4️⃣ Run the app:

flutter run

👨‍💻 Developer

Jesu Fẹranmi Iyanuni Oluwasegun
📧 jesuferanmioluwasegun@gmail.com

🔗 LinkedIn Profile: https://www.linkedin.com/in/jesuferanmi-oluwasegun-204b83356