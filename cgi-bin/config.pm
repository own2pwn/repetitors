package config;
#!/usr/bin/perl
use strict;

# КОНФИГУРАЦИОННЫЙ ФАЙЛ

# Если 0 –– development
# Если 1 –– production
# Если 2 –– ngrok  # ngrok -subdomain=mat-repetitor.ru 80
my $trigger = 0;

# my $config = settings();
# print "$config->{localhost}\n";

sub settings {
  if ($trigger == 0) {
    return {
      domain =>     'http://127.0.0.1/',
      main_path => '/home_1/andrey7/www/mat-repetitor.ru/',
      collapse => 1, # Свертка html 0 –– выключена, 1 –– включена
    }
  }
  elsif ($trigger == 1) {
    return {
        domain =>    'http://mat-repetitor.ru/',
        main_path =>'/home/andrey7/www/mat-repetitor.ru/',
        collapse => 1,
    }
  }
  elsif ($trigger == 2) {
    return {
        domain =>    'http://mat-repetitor.ru.ngrok.com/',
        main_path =>'/home/andrey7/www/mat-repetitor.ru/',
        collapse => 1,
    }
  }
}

1;