package module__insert_cookieks;
use strict;

# ВСТАВКА COOKIEKS ДЛЯ ПРОВЕРКИ ИХ ПРАВИЛЬНОСТИ И НАЛИЧИЯ

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

  # Получаем A –– незакодированное значение, B –– закодированное значение
  my ($A, $B) = md5::get_keys($ENV{HTTP_USER_AGENT});


  # setCookie('possible_to_request_call', '$A\:\:\:\:$B', 0, '/', window.location.hostname);
  # document.cookie;
  my $js_contacts_insert_cookieks =<<"EOF";

  setCookie('possible_to_request_call', '$A\:\:\:\:$B', 1, '/', window.location.hostname);

  function setCookie(o,e,n,t,a){var i=o+"="+encodeURIComponent(e);if("number"!=typeof n)throw new Error(" Параметр daysToLive должен быть числом. ");i+="; max-age="+60*n*60*24,i+="; path="+t,i+="; domain="+a,i+=";",document.cookie=i}

EOF

  my $js_contacts_insert_cookieks_min ='
  ';
  $js_contacts_insert_cookieks = ( $refCONTEXT -> {'min'} == 1 ) ? $js_contacts_insert_cookieks_min : $js_contacts_insert_cookieks;
  $refCONTEXT -> {$key} -> {'js'} = $js_contacts_insert_cookieks;
}
1;