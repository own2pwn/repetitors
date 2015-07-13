#!/usr/bin/perl
use strict;

# ПОСЛАТЬ EMAIL

# send_mail('qwertyzxcv526@gmail.com',$subject,"Заказ звонка \n Телефон:".$phone."\n Регион:".$region);
# send_mail('qwertyzxcv526@gmail.com', 'Тестовая отправка',"Заказ звонка \n Телефон:99999\n Регион:Балашиха");

sub send_mail {
  my($to, $subj, $msg)=@_;
  my $count_error_mail = 0; # Счетчик ошибки при открытии потока sendmail
  my $count_error_send_mail = 0; # Счетчик ошибок при отсылания файла, инкрементируем при каждом удчном выполненом действии

  unless(open(SENDMAIL, "|/usr/sbin/sendmail -t")) {
    $count_error_mail = 1;
    return ($count_error_mail,'ОШИБКА ПРИ ОТКРЫТИИ ПОТОКА SENDMAIL');
  }

 # my $MAIL_FROM='ActiveCloud <andrey7@ru111.activeby.net>';
 my $MAIL_FROM='dmitrijd@local';


  print SENDMAIL "From: ${MAIL_FROM}\n"; $count_error_send_mail++;
  print SENDMAIL "To: ${to}\n";          $count_error_send_mail++;
  print SENDMAIL "Subject: ${subj}\n\n"; $count_error_send_mail++;
  print SENDMAIL "${msg}";               $count_error_send_mail++;
  close(SENDMAIL);                       $count_error_send_mail++;

   if ($count_error_send_mail == 5) {
      return ($count_error_send_mail,'ВЫСЛАНО');
   }
   else {
      return ($count_error_send_mail,'ОШИБКА ПРИ ОТПРАВКЕ ПИСЬМА!!!');
   }

}
1;


