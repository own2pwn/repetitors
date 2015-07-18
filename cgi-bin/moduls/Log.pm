package Log;
#!/usr/bin/perl
use strict;

# Модуль логов: логи для заказа звонка,



#########################
sub log_order_call {
  my $data=shift;
  my $path='/home/andrey7/www/mat-repetitor.ru/data/log_order_call.txt';
  add_to_file($path,$data);
}


####
sub add_to_file {
  my($fn,$data)=@_;
  open (RESULT,'>>'.$fn);
  print RESULT $data;
  close(RESULT);
}
1;
