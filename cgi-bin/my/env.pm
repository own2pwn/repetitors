package env;
#!/usr/bin/perl
use strict;


sub get_ip {
my $ip;
  # если ключ HTTP_X_FORWARDED_FOR определен
  if ($ENV{HTTP_X_FORWARDED_FOR}) {
   # в переменную $ip записывается IP-адрес
   # клиента, подключенного через прокси
   $ip = $ENV{HTTP_X_FORWARDED_FOR};
  }
  else {
   # в противном случае запишем в $ip
   # удаленный IP-адрес клиента
   $ip = $ENV{REMOTE_ADDR} || 'Not exist IP';
  }
return $ip;
}
1;