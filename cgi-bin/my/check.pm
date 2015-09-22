package check;
#!/usr/bin/perl
use strict;

use Data::Dumper;

use lib './';
use md5;
use cookies;
# СКРИПТ СОБИРАЮЩИЕ РАЗНЫЕ ПУТИ



# Проверяем наличие cookies у пользователя
# с ключом possible_to_request_call.
# Проверяем, что A в данной куке (A:::B)
# эквиваленто B, если применить md5 к A
sub check_cookies_with_time_random_word {
  # warn "cookies = $ENV{HTTP_COOKIE}\n\n";
  # получаем хэш с куками
  my $cookies = cookies::get_cookies();
  my $c = $cookies->{possible_to_request_call} || '';
  if ($c){
    my ($key, $value) = split(/::::/, $c);
    # key – незашифрованное значение,
    # value –– зашифрованное значение
    # print STDERR "cookie = $key $value\n\n";
    # print STDERR "result = ".md5::check_keys($key, $value, $ENV{HTTP_USER_AGENT})."\n\n";
    return md5::check_keys($key, $value, $ENV{HTTP_USER_AGENT});
  }
  else {
    # print STDERR "cookie nothing\n";
    return 0;
  }
}

1;