// ignore_for_file: avoid_print

class ColorfulPrint{

  static yellow(String text) =>
    print('\x1B[33m$text\x1B[0m');
  
  static red(String text) =>
    print('\x1B[31m$text\x1B[0m');
  
  static green(String text) =>
    print('\x1B[32m$text\x1B[0m');
  

}