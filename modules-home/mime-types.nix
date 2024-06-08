# =======
# Mime/Types
# =======

{
  config,
  pkgs,
  lib,
  ...
}:
let
  image_openers = [
    "org.gnome.eog.desktop"
    "gimp.desktop"
    "work.openpaper.Paperwork.desktop"
  ];
  text_openers = [ "org.gnome.TextEditor.desktop" ];
  html_openers = [ "firefox.desktop" ] ++ text_openers;
  dir_openers = [
    "org.gnome.Nautilus.desktop"
    "code.desktop"
    "org.gnome.baobab.desktop"
  ];
  pdf_openers = [
    "org.gnome.Evince.desktop"
    "com.github.jeromerobert.pdfarranger.desktop"
    "work.openpaper.Paperwork.desktop"
  ];
  doc_openers = [
    "writer.desktop"
    "work.openpaper.Paperwork.desktop"
  ];
  calc_openers = [ "calc.desktop" ];
in
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {

      "application/x-planner" = [ "app.drey.Planner.desktop" ];
      "application/vnd.mozilla.xul+xml" = [ "firefox.desktop" ];
      "application/com.github.phase1geo.minder" = [ "com.github.phase1geo.minder.desktop" ];
      "text/x.gcode" = [ "PrusaGcodeviewer.desktop" ];

      # Images
      "image/bmp" = image_openers;
      "image/gif" = image_openers;
      "image/jpeg" = image_openers;
      "image/jpg" = image_openers;
      "image/pjpeg" = image_openers;
      "image/png" = image_openers;
      "image/tiff" = image_openers;
      "image/webp" = image_openers;
      "image/x-bmp" = image_openers;
      "image/x-gray" = image_openers;
      "image/x-icb" = image_openers;
      "image/x-ico" = image_openers;
      "image/x-png" = image_openers;
      "image/x-portable-anymap" = image_openers;
      "image/x-portable-bitmap" = image_openers;
      "image/x-portable-graymap" = image_openers;
      "image/x-portable-pixmap" = image_openers;
      "image/x-xbitmap" = image_openers;
      "image/x-xpixmap" = image_openers;
      "image/x-pcx" = image_openers;
      "image/svg+xml" = image_openers;
      "image/svg+xml-compressed" = image_openers;
      "image/vnd.wap.wbmp" = image_openers;
      "image/x-icns" = image_openers;

      # HTML
      "application/xhtml+xml" = html_openers;
      "text/html" = html_openers;

      # Plain/empty texts
      "application/x-mobipocket-subscription" = text_openers;
      "application/x-cbc" = text_openers;
      "application/x-mobi8-ebook" = text_openers;
      "text/fb2+xml" = text_openers;
      "application/oebps-package+xml" = text_openers;
      "text/plain" = text_openers;
      "text/x-markdown" = text_openers;
      "application/x-mobipocket-ebook" = text_openers;
      "application/ereader" = text_openers;
      "application/epub+zip" = text_openers;

      "application/x-zerosize" = text_openers;
      "text/xml" = text_openers ++ html_openers;

      # PDF
      "application/vnd.comicbook-rar" = pdf_openers;
      "application/vnd.comicbook+zip" = pdf_openers;
      "application/x-cb7" = pdf_openers;
      "application/x-cbr" = pdf_openers;
      "application/x-cbt" = pdf_openers;
      "application/x-cbz" = pdf_openers;
      "application/x-ext-cb7" = pdf_openers;
      "application/x-ext-cbr" = pdf_openers;
      "application/x-ext-cbt" = pdf_openers;
      "application/x-ext-cbz" = pdf_openers;
      "application/x-ext-djv" = pdf_openers;
      "application/x-ext-djvu" = pdf_openers;
      "image/vnd.djvu" = pdf_openers;
      "application/x-bzdvi" = pdf_openers;
      "application/x-dvi" = pdf_openers;
      "application/x-ext-dvi" = pdf_openers;
      "application/x-gzdvi" = pdf_openers;
      "application/pdf" = pdf_openers;
      "application/x-bzpdf" = pdf_openers;
      "application/x-ext-pdf" = pdf_openers;
      "application/x-gzpdf" = pdf_openers;
      "application/x-xzpdf" = pdf_openers;
      "application/postscript" = pdf_openers;
      "application/x-bzpostscript" = pdf_openers;
      "application/x-gzpostscript" = pdf_openers;
      "application/x-ext-eps" = pdf_openers;
      "application/x-ext-ps" = pdf_openers;
      "image/x-bzeps" = pdf_openers;
      "image/x-eps" = pdf_openers;
      "image/x-gzeps" = pdf_openers;
      "application/oxps" = pdf_openers;
      "application/vnd.ms-xpsdocument" = pdf_openers;
      "application/illustrator" = pdf_openers;

      # Directories
      "inode/directory" = dir_openers;

      # File roller
      "application/bzip2" = [ "org.gnome.FileRoller.desktop" ];
      "application/gzip" = [ "org.gnome.FileRoller.desktop" ];
      "application/vnd.android.package-archive" = [ "org.gnome.FileRoller.desktop" ];
      "application/vnd.ms-cab-compressed" = [ "org.gnome.FileRoller.desktop" ];
      "application/vnd.debian.binary-package" = [ "org.gnome.FileRoller.desktop" ];
      "application/vnd.rar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-7z-compressed" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-7z-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-ace" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-alz" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-apple-diskimage" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-ar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-archive" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-arj" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-brotli" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-bzip-brotli-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-bzip" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-bzip-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-bzip1" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-bzip1-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-cabinet" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-cd-image" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-compress" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-cpio" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-chrome-extension" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-deb" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-ear" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-ms-dos-executable" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-gtar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-gzip" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-java-archive" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-lha" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-lhz" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-lrzip" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-lrzip-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-lz4" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-lzip" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-lzip-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-lzma" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-lzma-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-lzop" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-lz4-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-ms-wim" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-rar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-rar-compressed" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-rpm" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-source-rpm" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-rzip" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-rzip-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-tarz" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-tzo" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-stuffit" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-war" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-xar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-xz" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-xz-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-zip" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-zip-compressed" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-zstd-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-zoo" = [ "org.gnome.FileRoller.desktop" ];
      "application/zip" = [ "org.gnome.FileRoller.desktop" ];
      "application/zstd" = [ "org.gnome.FileRoller.desktop" ];

      # Doc
      "application/vnd.oasis.opendocument.text" = doc_openers;
      "application/vnd.oasis.opendocument.text-template" = doc_openers;
      "application/vnd.oasis.opendocument.text-web" = doc_openers;
      "application/vnd.oasis.opendocument.text-master" = doc_openers;
      "application/vnd.oasis.opendocument.text-master-template" = doc_openers;
      "application/vnd.sun.xml.writer" = doc_openers;
      "application/vnd.sun.xml.writer.template" = doc_openers;
      "application/vnd.sun.xml.writer.global" = doc_openers;
      "application/msword" = doc_openers;
      "application/vnd.ms-word" = doc_openers;
      "application/x-doc" = doc_openers;
      "application/x-hwp" = doc_openers;
      "application/rtf" = doc_openers;
      "text/rtf" = doc_openers;
      "application/vnd.wordperfect" = doc_openers;
      "application/wordperfect" = doc_openers;
      "application/vnd.lotus-wordpro" = doc_openers;
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = doc_openers;
      "application/vnd.ms-word.document.macroEnabled.12" = doc_openers;
      "application/vnd.openxmlformats-officedocument.wordprocessingml.template" = doc_openers;
      "application/vnd.ms-word.template.macroEnabled.12" = doc_openers;
      "application/vnd.ms-works" = doc_openers;
      "application/vnd.stardivision.writer-global" = doc_openers;
      "application/x-extension-txt" = doc_openers;
      "application/x-t602" = doc_openers;
      "application/vnd.oasis.opendocument.text-flat-xml" = doc_openers;
      "application/x-fictionbook+xml" = doc_openers;
      "application/macwriteii" = doc_openers;
      "application/x-aportisdoc" = doc_openers;
      "application/prs.plucker" = doc_openers;
      "application/vnd.palm" = doc_openers;
      "application/clarisworks" = doc_openers;
      "application/x-sony-bbeb" = doc_openers;
      "application/x-abiword" = doc_openers;
      "application/x-iwork-pages-sffpages" = doc_openers;
      "application/vnd.apple.pages" = doc_openers;
      "application/x-mswrite" = doc_openers;
      "application/x-starwriter" = doc_openers;

      # Spreadhseet
      "application/vnd.oasis.opendocument.spreadsheet" = calc_openers;
      "application/vnd.oasis.opendocument.spreadsheet-template" = calc_openers;
      "application/vnd.sun.xml.calc" = calc_openers;
      "application/vnd.sun.xml.calc.template" = calc_openers;
      "application/msexcel" = calc_openers;
      "application/vnd.ms-excel" = calc_openers;
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = calc_openers;
      "application/vnd.ms-excel.sheet.macroEnabled.12" = calc_openers;
      "application/vnd.openxmlformats-officedocument.spreadsheetml.template" = calc_openers;
      "application/vnd.ms-excel.template.macroEnabled.12" = calc_openers;
      "application/vnd.ms-excel.sheet.binary.macroEnabled.12" = calc_openers;
      "text/csv" = calc_openers;
      "application/x-dbf" = calc_openers;
      "text/spreadsheet" = calc_openers;
      "application/csv" = calc_openers;
      "application/excel" = calc_openers;
      "application/tab-separated-values" = calc_openers;
      "application/vnd.lotus-1-2-3" = calc_openers;
      "application/vnd.oasis.opendocument.chart" = calc_openers;
      "application/vnd.oasis.opendocument.chart-template" = calc_openers;
      "application/x-dbase" = calc_openers;
      "application/x-dos_ms_excel" = calc_openers;
      "application/x-excel" = calc_openers;
      "application/x-msexcel" = calc_openers;
      "application/x-ms-excel" = calc_openers;
      "application/x-quattropro" = calc_openers;
      "application/x-123" = calc_openers;
      "text/comma-separated-values" = calc_openers;
      "text/tab-separated-values" = calc_openers;
      "text/x-comma-separated-values" = calc_openers;
      "text/x-csv" = calc_openers;
      "application/vnd.oasis.opendocument.spreadsheet-flat-xml" = calc_openers;
      "application/x-iwork-numbers-sffnumbers" = calc_openers;
      "application/vnd.apple.numbers" = calc_openers;
      "application/x-starcalc" = calc_openers;

      "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];

      "model/stl" = [
        "fstl.desktop"
        "PrusaSlicer.desktop"
      ];
    };
  };
}
