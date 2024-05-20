echo 'Building an apk release'

clear
flutter clean
flutter pub get
flutter build apk --release

echo 'Done building apk release'