package md5;
#!/usr/bin/perl
# use 5.016;
use strict;

# use Data::Dumper;

# Функции для работы с MD5

use Digest::MD5  qw(md5_hex);

my $PASSWD = '456GHfre890';

# get_keys('Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:39.0) Gecko/20100101 Firefox/39.0');

# Для получения двух переменных A – рандомные буквы плюс время,
# B –– закодированное A
sub get_keys {
  my $user_agent = shift;
  my @passset = ('a'..'z','A'..'Z');
  # print Dumper(\@passset);
  my $A = '';
  for (my $i = 0; $i < 12; $i++) { $A.= $passset[int(rand($#passset + 1))]; }
  $A.= time();
  my $B = md5_hex($A, $PASSWD, $user_agent);
  # print $A."\n";
  # print $B."\n";
  return ($A, $B);
}

# Для проверки эквивалентности A  зашифрованному B
# функция работает в связке с функцией выше(get_keys)
sub check_keys {
  my($A, $B, $user_agent) = @_;
  return ($B eq md5_hex($A, $PASSWD, $user_agent)) ? 1 : 0;
}

1;