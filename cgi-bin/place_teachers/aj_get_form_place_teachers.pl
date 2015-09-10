#!/usr/bin/perl
use strict;
use CGI;
use Data::Dumper;
# CКРИПТ (ОБРАЩАЕМСЯ К НЕМУ ПО AJAX): ВОЗВРАЩАЕТ HTML ФОРМЫ "ЗАКАЗА ЗВОНКА", СОБРАННЫЙ JS, ПЛЮС CSS

use lib '../';
use config;
my $c = config::settings();

my %CONTEXT = ('min' => 0, collapse => $c->{collapse}, domain => 'http://'.$ENV{HTTP_HOST}, api_js => $c -> {api_js});

use lib './';
use base_types_forms;
base_types_forms::start(\%CONTEXT,'base_types_forms');
# Dumper($CONTEXT{'base_types_forms'});
use lib '../my/';
use http;
use collapse;

if ($ENV{'QUERY_STRING'} eq '') {
  start(\%CONTEXT,'get_form');
}
else {
  http::redirect(301,$CONTEXT{domain});
}

# start(\%CONTEXT,'get_form');
#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  form_order_call($refCONTEXT,$key);
  # print $CONTEXT{$key}{'html'};
  # print $CONTEXT{$key}{'css'};
  # print $CONTEXT{$key}{'js'};
}


# ----------------------------------------------------- ФОРМА ЗАКАЗА ЗВОНКА (ДЛЯ ПРЕПОДАВАТЕЛЯ) -------------------------------------------------------------
sub form_order_call {
  my ($refCONTEXT,$key) = @_;

  my $css_form_order_call = '
  .button {
  display: inline-block;
  width: 100%;
  height: 2em;
  font-size: 100%;
  color:#e5216a;
  line-height: 1.5em;
  vertical-align: middle;
  text-align: center;
  text-decoration: none;
  user-select: none;

  outline: none;
  border: 1px solid rgba(0,0,0,.4);
  border-top-color: rgba(0,0,0,.3);
  border-radius: 5px;
  background: linear-gradient(rgb(255,255,255), rgb(240,240,240));
  box-shadow:
   0 0 3px rgba(0,0,0,0) inset,
   0 1px 1px 1px rgba(255,255,255,.2),
   0 -1px 1px 1px rgba(0,0,0,0);
  transition: .2s ease-in-out;
}
.button:hover:not(:active) {
  box-shadow:
   0 0 3px rgba(0,0,0,0) inset,
   0 1px 1px 1px rgba(0,255,255,.5),
   0 -1px 1px 1px rgba(0,255,255,.5);
}
.button:active {
  background: linear-gradient(rgb(250,250,250), rgb(235,235,235));
  box-shadow:
   0 0 3px rgba(0,0,0,.5) inset,
   0 1px 1px 1px rgba(255,255,255,.4),
   0 -1px 1px 1px rgba(0,0,0,.1);
}



/* Отступ сверху и снизу для поля телефона */
.form_style {
    width:95%;
    font-size:16px;
    border: 2px solid #777;
    border-radius:8px;
    margin-top:15px;
    margin-bottom:15px;
    padding:2px;
}
  ';

  my $html_form_order_call ="

  ";

  my $hash_types_forms = $refCONTEXT -> {'base_types_forms'} || {};
  my $sort_order       = $refCONTEXT -> {'base_types_forms_sort_order'} || [];
  # Dumper($hash_types_forms || 'NULL');

  # Собираем строку (массив JS) имен полей и полей заказа (одновременно) звонка
  my $str_field_name = '[';
  foreach my $id (@$sort_order) {
    $str_field_name.= "\"".$id."\",";
  }
  $str_field_name.= '];';
  # print "Массив имен $str_field_name\n";
  # exit;

#  text_all_form+= "name='"+attributeFiled+"'";
  my $js_form_order_call =<<"EOF";
  (function () {

    addCss('$css_form_order_call');

    var massivAttributeFiled= $str_field_name
    var text_all_form = ""; /* Вся форма */
    for (var i = 0, l = massivAttributeFiled.length; i < l; i++) {

      var attributeFiled = massivAttributeFiled[i];
      console.log(\'Аттрибут поля =\' + attributeFiled);

      text_all_form+="<form action='$CONTEXT{domain}/cgi-bin/order_call_place_teachers/order_call_place_teachers.pl'>";
             text_all_form+= "<input type=hidden name=action value=order_call_place_teachers>";
             text_all_form+= "<input type=hidden name=sub value='" + attributeFiled + "'>";
             text_all_form+="<input class=form_style ";
                       text_all_form+= "name='ph' ";
                       text_all_form+= "type='text' maxlength='255' ";
                       text_all_form+= "placeholder='Введите телефон' /> <br>";
            text_all_form+= "<input class='button' type='submit' value='Заказать звонок'>";
          text_all_form+= "</form>";



  console.log(text_all_form);
  console.log(attributeFiled);
  document.getElementById(attributeFiled).innerHTML = text_all_form;
  text_all_form="";
    }


  }());
EOF
print STDERR $js_form_order_call;
  my $js_form_order_call_min =<<EOF;
EOF

  $js_form_order_call = ( $refCONTEXT -> {'min'} == 1 ) ? $js_form_order_call_min : $js_form_order_call;
  $refCONTEXT -> {$key} -> {'css'} = $css_form_order_call;
  $refCONTEXT -> {$key} -> {'html'} = $html_form_order_call;
  $refCONTEXT -> {$key} -> {'js'} = $js_form_order_call;
}

print http::header();
# print $CONTEXT{get_form}{js};
print collapse::collapse_wt_html_and_js_comment(\%CONTEXT,$CONTEXT{get_form}{js});



# СТАРЫЙ КОД ВСЕЙ ФОРМЫ

my $all_form_with_button=<<"EOF";
Status: 200 OK
Content-type: text/html; charset=utf-8


<div class=frame>
 <span class=phrase_form> Репетитор по математике Люберцы: </span>

   <form  action='/cgi-bin/order_call.pl'>
        <input class=form_style
               name='call_Lyubertsy'
               type='text' maxlength='255'
               placeholder='Введите телефон' /> <br>

        <input class='button' type='submit' value='Заказать звонок'>
   </form>
</div>


<div class=frame style='margin:70px 0px;'>
 <span class=phrase_form> Репетитор по математике Балашиха: </span>

  <form action='/cgi-bin/order_call.pl'>
        <input  class=form_style
                name='call_Balashiha'
                type='text' maxlength='255'
                placeholder='Введите телефон' /> <br>

        <input class='button' type='submit' value='Заказать звонок'>
  </form>
 </div>

<div class=frame style='margin:70px 0px;'>
 <span class=phrase_form> Репетитор по математике Железнодорожный: </span>

  <form action='/cgi-bin/order_call.pl'>
        <input  class=form_style
                name='call_Zheleznodorozhnyiy'
                type='text' maxlength='255'
                placeholder='Введите телефон' /> <br>

        <input class='button' type='submit' value='Заказать звонок'>
  </form>

 </div>

 <div class=frame style='margin:70px 0px;'>
 <span class=phrase_form> Репетитор по математике Волжская: </span>

  <form action='/cgi-bin/order_call.pl'>
        <input  class=form_style
                name='call_Volzhskaya'
                type='text' maxlength='255'
                placeholder='Введите телефон' /> <br>

        <input class='button' type='submit' value='Заказать звонок'>
  </form>

 </div>

 <div class=frame style='margin:70px 0px;'>
 <span class=phrase_form> Репетитор по математике Марьино: </span>

  <form action='/cgi-bin/order_call.pl'>
        <input  class=form_style
                name='call_Marino'
                type='text' maxlength='255'
                placeholder='Введите телефон' /> <br>

        <input class='button' type='submit' value='Заказать звонок'>
  </form>

 </div>
EOF















