#!/usr/bin/perl
use strict;
use CGI;
use lib './';
use base_teachers;
# Число или нет
use Scalar::Util qw(looks_like_number);

# TODO: ПЕРЕПИСАТЬ ПО АНЛОГИИ С AJAX СКРИПТОМ В ORDER_CALL_PLACE_TEACHERS.PL

# CКРИПТ (ОБРАЩАЕМСЯ К НЕМУ ПО AJAX): ВОЗВРАЩАЕТ HTML ФОРМЫ "ЗАКАЗА ЗВОНКА", СОБРАННЫЙ JS, ПЛЮС CSS

my %CONTEXT = ('min' => 0 );
base_teachers::start(\%CONTEXT,'base_teachers');

my $teacher_id = int(CGI::param("teacher"));
# $CONTEXT{'teacher'} = 1;

if ($ENV{'QUERY_STRING'} eq '') {
  $teacher_id = 1;
  $CONTEXT{'teacher'} = 1;
  start(\%CONTEXT,'get_form');
}
elsif ($teacher_id < 1) {
  redirect(301,'http://127.0.0.1/');
}
elsif (!$CONTEXT{'base_teachers'} -> {$teacher_id}) {
  redirect(302,'http://127.0.0.1/');
}
else {
  $CONTEXT{'teacher'} = $teacher_id;
  start(\%CONTEXT,'get_form');
}

# start(\%CONTEXT,'get_form');
#########################
sub start {
  my ($refCONTEXT,$key) = @_;

  # my %hash_teach = %{$refCONTEXT -> {'base_teachers'}};
  # my $teacher_id = $refCONTEXT -> {'teacher'};
  form_order_call($refCONTEXT,$key);
  # print $CONTEXT{$key}{'html'};
  # print $CONTEXT{$key}{'css'};
  # print $CONTEXT{$key}{'js'};
}


# ----------------------------------------------------- ФОРМА ЗАКАЗА ЗВОНКА -------------------------------------------------------------
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

  ## Таблица , в который 2 ячейки: левая это красивый заголовок, а правая это контакты
  my $html_form_order_call ="

  ";

  my $hash_teach = $refCONTEXT -> {'base_teachers'};
  my $teacher_id = $refCONTEXT -> {'teacher'};

  my $key_regions      = $hash_teach -> {$teacher_id} -> {'key_regions'}            || {};
  my $sort_key_regions = $hash_teach -> {$teacher_id} -> {'key_regions_sort_order'} || [];
  # Собираем строку (массив JS) имен полей и полей заказа (одновременно) звонка
  my $str_field_name = '[';
  foreach my $id (@$sort_key_regions) {
    $str_field_name.= "\"$id\",";
  }
  $str_field_name.= '];';
  # print "Массив имен $str_field_name\n";
  # exit;
#
#  text_all_form+= "name='"+attributeFiled+"'";
  my $js_form_order_call =<<"EOF";
  (function () {

    addCss('$css_form_order_call');

    var massivAttributeFiled= $str_field_name
    var i;
    var text_all_form = ""; /* Вся форма */
    for (i = 0; i < massivAttributeFiled.length; i++) {

      var attributeFiled = massivAttributeFiled[i];
      console.log(\'Аттрибут поля =\' + attributeFiled);



    text_all_form+="<form action='/cgi-bin/order_call/order_call_3.pl'>";
       text_all_form+= "<input type=hidden name='action' value='order_call'>";
       text_all_form+= "<input type=hidden name='id' value='$teacher_id'>";
       text_all_form+= "<input type=hidden name='region' value='" + attributeFiled + "'>";
       text_all_form+="<input class=form_style ";
                 text_all_form+= "name='ph'";
                 text_all_form+= "type='text' maxlength='255'";
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

  my $js_form_order_call_min =<<EOF;
  !function(){addCss('$css_form_order_call');var b,a=["call_Lyubertsy","call_Balashiha","call_Zheleznodorozhnyiy","call_Volzhskaya","call_Marino"],c="",d=1;for(b=0;b<a.length;b++){var e=a[b];console.log("\u0410\u0442\u0442\u0440\u0438\u0431\u0443\u0442 \u043f\u043e\u043b\u044f ="+e),c+="<form action='/cgi-bin/order_call_2.pl'>",c+="<input class=form_style ",c+="name='"+e+"'",c+="type='text' maxlength='255'",c+="placeholder='Введите телефон' /> <br>",c+="<input class='button' type='submit' value='Заказать звонок'>",c+="</form>",console.log(c),console.log(d),document.getElementById(d).innerHTML=c,c="",d++}}();
EOF

  $js_form_order_call = ( $refCONTEXT -> {'min'} == 1 ) ? $js_form_order_call_min : $js_form_order_call;
  $refCONTEXT -> {$key} -> {'css'} = $css_form_order_call;
  $refCONTEXT -> {$key} -> {'html'} = $html_form_order_call;
  $refCONTEXT -> {$key} -> {'js'} = $js_form_order_call;
}




#############################
sub collapse {
  my $data=shift;


$data=~s/\n//g;                 # В одну строчку делаем
$data=~s/\s+/ /g;


# $data=~s/<\!\-\-[^!]+\-\->//g;  # Уничтожаем html комментарии
$data=~s/\/\*[^\/\/\*]+\*\///g; # Уничтожаем css комментарии
# $data=~s/\/\/[^\/\/]+\*\///g;   # Уничтожаем js комментарии  пишем коментарии в стиле // код */

                                 # Уничтожаем пробелы в стилях
$data=~s/\s*{\s*/{/g;
$data=~s/\s*}\s*/}/g;

return $data;
}






my $stop_browser_cache="Expires: Mon, 26 Jul 1997 05:00:00 GMT\r\nCache-Control: no-cache, must-revalidate\r\nPragma: no-cache\r\n";

my $head ="Status: 200 OK\r\nX-FRAME-OPTIONS: DENY\r\nContent-type: text/html; charset=UTF-8\r\n";
        $head.= $stop_browser_cache;
        $head.="\r\n";

# textHeader это - Репетитор по математике Люберцы: , call_Lyubertsy это -
my $data = <<"EOF";
$CONTEXT{'get_form'}{js}
EOF

$data=collapse($data);

print $head.$data;



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


sub redirect {
  my ($redirect_status, $url)=@_; # // 301 - Permanently // 302 - Temporarily
  my $stop_browser_cache = "Expires: Mon, 26 Jul 1997 05:00:00 GMT\r\nCache-Control: no-cache, must-revalidate\r\nPragma: no-cache\r\n";
  print "Status: ".$redirect_status."\r\n".$stop_browser_cache.'Location: '.$url."\r\n\r\n";
}

sub is_number {
  my $s = shift;
  if (looks_like_number($s)) {
    # print "$s is a number\n";
    return 1;
  } else {
    # print "$s isn't a number\n";
    return 0;
  }
}












