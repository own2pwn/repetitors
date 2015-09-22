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
      domain    => 'http://127.0.0.1/',
      main_path => '/home_1/andrey7/www/mat-repetitor.ru/',
      collapse  => 0, # Свертка html              0 –– выключена, 1 –– включена
      api_js    => 1, # metrica,analytics,vk_comments и т.д.  0 –– выключена, 1 –– включена
      log_temp  => 1,
    }
  }
  elsif ($trigger == 1) {
    return {
        domain    => 'http://mat-repetitor.ru/',
        main_path => '/home/andrey7/www/mat-repetitor.ru/',
        collapse  => 1,
        api_js    => 0,
        log_temp  => 0,
    }
  }
  elsif ($trigger == 2) {
    return {
        domain    => 'http://mat-repetitor.ru.ngrok.com/',
        main_path => '/home/andrey7/www/mat-repetitor.ru/',
        collapse  => 1,
        api_js    => 0,
        log_temp  => 0,
    }
  }
}

1;