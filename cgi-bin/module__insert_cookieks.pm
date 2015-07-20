package module__insert_cookieks;
use strict;

# ВСТАВКА COOKIEKS ДЛЯ ПРОВЕРКИ ИХ ПРАВИЛЬНОСТИ И НАЛиЧИЯ

# my %CONTEXT = ('min' => 1, 'id' => 1);
# start(\%CONTEXT,'contacts_filials');

#########################
sub start {
  my ($refCONTEXT,$key) = @_;

  insert_cookieks($refCONTEXT,$key);
  # print $CONTEXT{$key}{html};
  # print $CONTEXT{$key}{css};
  # print $CONTEXT{$key}{js};
}




# ----------------------------------------------------- СОБИРАЕМ контакты филиалов (Текстильщики и Кузьминки) -------------------------------------------------------------
sub insert_cookieks {
  my ($refCONTEXT,$key) = @_;


  my $js_contacts_insert_cookieks ='
  ';

  my $js_contacts_insert_cookieks_min ='
  ';
  $js_contacts_insert_cookieks = ( $refCONTEXT -> {'min'} == 1 ) ? $js_contacts_insert_cookieks_min : $js_contacts_insert_cookieks;
  $refCONTEXT -> {$key} -> {'js'} = $js_contacts_insert_cookieks;
}
1;