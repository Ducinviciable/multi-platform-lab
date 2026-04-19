# Lab Flutter

Workspace này có 5 dự án Flutter riêng biệt:

- `dice`
- `i_am_rich`
- `mi_card`
- `magic_ball`
- `xylophone`

## Cách chạy từng dự án

Mở terminal tại thư mục `d:\Learning\lab_flutter`, sau đó vào đúng thư mục dự án và chạy lệnh `flutter run`.

### 1. Dice

```powershell
cd d:\Learning\lab_flutter\dice
flutter run
```

### 2. I Am Rich

```powershell
cd d:\Learning\lab_flutter\i_am_rich
flutter run
```

### 3. Mi Card

```powershell
cd d:\Learning\lab_flutter\mi_card
flutter run
```

### 4. Magic Ball

```powershell
cd d:\Learning\lab_flutter\magic_ball
flutter run
```

### 5. Xylophone

```powershell
cd d:\Learning\lab_flutter\xylophone
flutter run
```

## Ghi chú

- Nếu có nhiều thiết bị, dùng `flutter devices` để xem danh sách rồi chạy `flutter run -d <device_id>`.
- Nếu muốn chạy trên web, vào đúng thư mục dự án rồi dùng `flutter run -d chrome`.
- Nếu mới clone project hoặc mới thêm package, chạy `flutter pub get` trước khi `flutter run`.
