#!/usr/bin/perl 
use strict;

### Скрипт, который позволяет парсить стили(Bootsrap) и выдергивать их в отдельный файл

# Откуда берем стили
my $PATH_STYLE_MIN='/Users/dmitrijd/Desktop/marianna_web/marianna_web_2.4/Util/bootsrap_style_min.css';

# Куда кладем результат поиска
my $PATH_SEARCH_STYLE='/Users/dmitrijd/Desktop/marianna_web/marianna_web_2.4/Util/search_style.txt';

my $RES; # Результат поиска

# Задаем какие стили хотим найти
my @search_style=qw(html
    h1);

parser_style(\@search_style);

######################
sub parser_style {
    my $ref_search_style=shift;

    open (FILE,$PATH_STYLE_MIN);
       while (<FILE>) {
           foreach my $st (@$ref_search_style) {
              if ($_=~/($st({[^{}]+}))/) { $RES.=$1."\n";}  # Ищем необходимый стиль, а так же все его свойста в {}, вторые () нужны для отделения $st от {}
           }
       }
     close(FILE);

save_to_txt_file($PATH_SEARCH_STYLE,$RES);
}


############
sub save_to_txt_file {
  my($fn,$data)=@_;
  open (RESULT,'>'.$fn);
  print RESULT $data;
  close(RESULT);
}