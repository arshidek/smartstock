import 'dart:io';

void main() {
  final dirsToDelete = [
    // Delete the new consolidated folders I made by mistake
    'lib/features/category/presentation/categories',
    'lib/features/brand/presentation/brands',

    // Delete the misplaced files the user accidentally put in add_brand
    'lib/features/brand/presentation/add_brand/mobile/mobile_brand_details_screen.dart',
    'lib/features/brand/presentation/add_brand/mobile/mobile_brand_list_screen.dart',
    'lib/features/brand/presentation/add_brand/mobile/mobile_edit_brand_bottom_sheet.dart',
    
    'lib/features/brand/presentation/add_brand/web/web_brand_details_screen.dart',
    'lib/features/brand/presentation/add_brand/web/web_brand_list_screen.dart',
    'lib/features/brand/presentation/add_brand/web/web_edit_brand_bottom_sheet.dart',
  ];

  for (var path in dirsToDelete) {
    if (FileSystemEntity.isDirectorySync(path)) {
      try {
        Directory(path).deleteSync(recursive: true);
        print('Deleted directory: $path');
      } catch (e) {
        print('Could not delete directory $path: $e');
      }
    } else if (FileSystemEntity.isFileSync(path)) {
      try {
        File(path).deleteSync();
        print('Deleted file: $path');
      } catch (e) {
        print('Could not delete file $path: $e');
      }
    }
  }
  print('Cleanup complete!');
}
