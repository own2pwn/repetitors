package module__insert_contact_js;
#!/usr/bin/perl
use strict;

# ВСТАВКА E-MAIL И ТЕЛЕФОНА В HEADER, FOOTER И BODY СКРИПТА ПРЕПОДАВТЕЛЯ

# my %CONTEXT = ('min' => 0);
# start(\%CONTEXT,'insert_contact_js');


#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  insert_contact_js($refCONTEXT,$key);
  # print $CONTEXT{$key}{'js'};
  # foreach my $key (keys %CONTEXT) {
  #   print "$key === $CONTEXT{$key}\n";
  # }
}




# ----------------------------------------------------- ВСТАВКА телефона и email по ID -------------------------------------------------------------
sub insert_contact_js {
  my ($refCONTEXT,$key) = @_;

  # JavaScript для КОНТАКТОВ возвращает по id utf8 и функция рисующая БОРДЕРЫ
  my $js_insert_contact_js ='

  var mail = ["communication","communication_m","communication_m_footer"];

  for (var i=0,l=mail.length; i<l; i++) {
     document.getElementById(mail[i]).innerHTML="\u006d\u0061\u0072\u0069\u0061\u006E\u006E\u0061\u002E\u0072\u0065\u0070\u0065\u0074\u0069\u0074\u006F\u0072\u0040\u0067\u006d\u0061\u0069\u006C\u002E\u0063\u006F\u006d";
  }

  var phones = {
    "\u0038\u0028\u0039\u0031\u0036\u0029\u002D\u0033\u0034\u0031\u002D\u0032\u0030\u0037\u0030":["communication_ph","communication_ph1","communication_ph2","communication_ph_footer","communication_ph_individual","communication_ph_contractual"],
    };
  for(var ph in phones) {
    var ids=phones[ph];
    for (var i=0,l=ids.length; i<l; i++) {
     document.getElementById(ids[i]).innerHTML=ph;
     }
  }
  ';

  # communication это id для получения почты в header

  # communication_ph это id для получения phone(marianna) в header

  # communication это id для получения почты в раздел заказов заданий(order_solution)

  # communication_ph это id для получения phone(marianna) в раздел contacts в первый раз

  # communication_ph это id для получения phone(marianna) в раздел contacts во второй раз

  # communication_ph_textile_workers это id для получения phone(Текстильщиков)  в раздел contacts

  # communication_ph_individual это id для получения phone(marianna) в разделе индивидуальных занятий в ТОП-5 регионах

  # communication_ph_contractual это id для получения phone(marianna) в разделе договрных цен

  my $js_insert_contact_js_min ='
  ';
  $js_insert_contact_js = ( $refCONTEXT -> {'min'} == 1 ) ? $js_insert_contact_js_min : $js_insert_contact_js;
  $refCONTEXT -> {$key} -> {'js'} = $js_insert_contact_js;
}
1;