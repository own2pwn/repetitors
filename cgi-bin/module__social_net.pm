package module__social_net;
use strict;

# БЛОК СО ССЫЛКАМИ на СОЦИАЛЬНЫЕ СЕТИ (СКРИПТ ПРЕПОДАВАТЕЛЯ)

# my %CONTEXT = ('min' => 1);
# start(\%CONTEXT,'footer');

#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  social_net($refCONTEXT,$key);
  # print $CONTEXT{$key}{html};
  # print $CONTEXT{$key}{css};
  # print $CONTEXT{$key}{js};
}




# ----------------------------------------------------- СОЦИАЛЬНЫЕ СЕТИ (ССЫЛКИ) -------------------------------------------------------------
sub social_net {
  my ($refCONTEXT,$key) = @_;

  my $css_social_net ='

  ';

  ## Таблица , в который 2 ячейки: левая это красивый заголовок, а правая это контакты
  my $html_social_net ="
  <div style='width:90%;margin-top:25px;border-top:2px solid #999;padding:20px 5%'>

   <p>
       Мы в социальных сетях:<br>
       <a href='https://vk.com/club78990716'>
       <img style='width:38px;border-radius:3px;margin:16px 3%' alt='' src='Photo/Vkontakte.png'>
       </a>

       <a href='https://www.facebook.com/groups/373448889477325/'>
       <img style='width:38px;border-radius:3px;margin:16px 3%;pading:0 1%' alt='' src='Photo/Facebook.png'>
       </a>

       <a href='https://twitter.com/MariannaKamaeva'>
       <img style='width:38px;border-radius:3px;margin:16px 3%' alt='' src='Photo/Twitter.png'>
       </a>
   </p>

  </div>
  ";

  my $js_social_net ='
  ';

  my $js_social_net_min ='
  ';
  $js_social_net = ( $refCONTEXT -> {'min'} == 1 ) ? $js_social_net_min : $js_social_net;

  $refCONTEXT -> {$key} = { css => $css_social_net, html => $html_social_net, js => $js_social_net};

}
1;