Consists of all the files necessary for running the native android and ios application.

**Pre-requisites**

1. Flutter with version **3.41.2**
2. Dart with version **3.11.0**
3. JDK 17
4. Android device with minimum android sdk 28
5. Ios Device with minimum ios version of 13

Once you have all these pre-requisites setup, please make that you create directory hierarchy as mentioned below.

**Note: Also make sure that the names and naming convention are exact for things to work smoothly.

- esewa_demo_app (root)
  - esewa_native_applications
  - esewa_flutter_module
**

Clone this repository in the esewa_native_applications directory and clone the repository for flutter module within the esewa_flutter_module directory.
Now you directory hierarchy should be something like this

- esewa_demo_app(root)
  - esewa_native_application/
      - esewa_android_application/
      - esewa_ios_app/
  - esewa_flutter_module/

Open the esewa_flutter_module in your system terminal and you must find env directory inside lib directory. Create three different files with names .env.dev, .env.stg and .env.prod

Within these files please add this key-value

BASE_URL=https://fakestoreapi.com/

Paste the same base url for all three files. Later on real application base url could be different based on the envirnment but for the sake of this demo app, base url is the same. 
After its done, run these commands in the given order.

**flutter clean** -> this will clean all flutter caches

**flutter pub get** -> run all depedencies from the pubspec.yaml and generate files required for native apps to create link with flutter

**dart run build_runner build -d** -> generates all auto-generated file which is necessary for running the app module

Now you move to the esewa_ios_app directory and run **pod install --repo-update**

Configure the run method and run the app from their respective IDE, the app should work as expected.

Note: The username and password for logging in as static at the moment.

**username - Esewa Demo User

password - esewa2026@Demo**
