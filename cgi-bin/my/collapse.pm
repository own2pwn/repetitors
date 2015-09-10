package collapse;
#!/usr/bin/perl
use strict;

# СВЕРТЫВАНИЕ В ОДНУ СТРОКУ САЙТА





#############################
sub simple_collapse {
  my ($refCONTEXT,$data) = @_;

if ($refCONTEXT->{collapse} == 1) {
  $data=~s/\n//g;                 # В одну строчку делаем
  $data=~s/\s+/ /g;


  $data=~s/<\!\-\-[^!]+\-\->//g;  # Уничтожаем html комментарии
  $data=~s/\/\*[^\/\/\*]+\*\///g; # Уничтожаем css и js комментарии

                                   # Уничтожаем пробелы в стилях
  $data=~s/\s*{\s*/{/g;
  $data=~s/\s*}\s*/}/g;
}
return $data;
}

#############################
sub collapse_wt_html_and_js_comment {
  my ($refCONTEXT,$data) = @_;

  $data=~s/\n//g;                 # В одну строчку делаем
  $data=~s/\s+/ /g;


  # $data=~s/<\!\-\-[^!]+\-\->//g;  # Уничтожаем html комментарии
  $data=~s/\/\*[^\/\/\*]+\*\///g; # Уничтожаем css комментарии
  # $data=~s/\/\/[^\/\/]+\*\///g;   # Уничтожаем js комментарии  пишем коментарии в стиле // код */

                                   # Уничтожаем пробелы в стилях
  $data=~s/\s*{\s*/{/g;
  $data=~s/\s*}\s*/}/g;

  return $data;
}


1;