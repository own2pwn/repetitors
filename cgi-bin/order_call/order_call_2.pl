#!/usr/bin/perl
use strict;
#use lib '/Users/dmitrijd/Desktop/marianna_web/marianna_web_2.3/cgi-bin/moduls'; ### Для локалки
# use lib '/home/andrey7/www/mat-repetitor.ru/cgi-bin/moduls'; ### Для сервера
use CGI;
# use Log;

#my $call_Lyubertsy=4;
my $call_Lyubertsy=CGI::param("call_Lyubertsy");
my $call_Balashiha=CGI::param("call_Balashiha");
my $call_Zheleznodorozhnyiy=CGI::param("call_Zheleznodorozhnyiy");
my $call_Volzhskaya=CGI::param("call_Volzhskaya");
my $call_Marino=CGI::param("call_Marino");


my ($phone,$region)=proccesing_region_and_order_phone();
## Получаем ip клиента
my $ip=get_ip_client();
my $user_agent=$ENV{HTTP_USER_AGENT};
## Функция формирования html-страницы с данными
onload_monitor($phone,$region,$ip,$user_agent);

#my ($sec,$min,$hour,$day,$ref_nmonth,$year)=get_time();
#my $subject="Заказали звонок в $hour:$min:$sec $day $$ref_nmonth $year\n";
#print $subject."\n";

# СТАРЫЙ КОД (КАК ПЕРЕПИШЕШЬ ORDER_CALL_3.PL, УДАЛЯЙ)


################################################
sub onload_monitor {
 my ($phone,$region,$ip,$user_agent)=@_;
my $data;
my $info;


my ($sec,$min,$hour,$day,$ref_nmonth,$year)=get_time();

if ($phone=~/[\d\-\+()]+/i) {
   $data="<p> Спасибо, за заказ. <br>
             Вам позвонят на номер <em> $phone </em>
             в ближайшее время.$region


           <br style='margin-bottom:15px;'>
                <a   href='http://mat-repetitor.ru' class='button'>
                     Вернуться на главную страницу
                </a>
           </p>
             ";


my $subject="Заказали звонок в $hour:$min:$sec $day $$ref_nmonth $year\n";

my ($counter_error_1,$info_send_mail_1)=send_mail('qwertyzxcv526@gmail.com',$subject,"Заказ звонка \n Телефон:".$phone."\n Регион:".$region);
my ($counter_error_2,$info_send_mail_2)=send_mail('marianna.repetitor@gmail.com',$subject,"Заказ звонка \n Телефон:".$phone."\n Регион:".$region);

#print "$counter_error_1\n";
#print "$counter_error_2\n";

$info="$hour:$min:$sec \t $day $$ref_nmonth $year \t $region \t  тел:$phone \t почта_1:$info_send_mail_1   почта_2:$info_send_mail_2; \t IP:$ip \nUser-agent: $user_agent\n\n\n";
Log::log_order_call($info);

}

else {
    $data="<p> Вы ввели неверную информацию. Попробуйте ввести еще раз телефон.
               Например  в таком формате: <em> +7(906)1234567 </em>
               или <em> 89061234567 </em>

             <br style='margin-bottom:15px;'>
                 <a href='http://mat-repetitor.ru' class='button'>
                   Вернуться на главную страницу
                 </a>
            </p>

            ";

$info="$hour:$min:$sec \t $day $$ref_nmonth $year \t $region \t  тел:$phone ПОЛЬЗОВАТЕЛЬ ВВЕЛ НЕВЕРНУЮ ИНФОРМАЦИЮ!!! \t IP:$ip \nUser-agent: $user_agent\n\n";
#add_to_file($path,$info);
Log::log_order_call($info);
}






my $page=<<"EOF";
<!DOCTYPE html>
<html><head>

<meta charset=utf-8>

<meta http-equiv="Refresh" Content="120; URL=http://mat-repetitor.ru">

<title>Заказ звонка</title>
<style>
*{margin:0;padding:0}
body{font-family:Arial,Helvetica,sans-serif}
ul,li{list-style:none}
img{border:0}
table{border:0;border-collapse:collapse}
table tr{vertical-align:top}
table td{padding:0}
a{color:#1a50bd;text-decoration:none}
a:visited{color:#551A8B}
h1{display:inline;color:#AB3C3C;font-weight:normal;font-size:110%}
em{font-weight:bold;color:#0099CC}
strong{color:#AB3C3C}
b{color:#0099CC}
a:active, a:focus, img{outline:0}

body {padding:10px}

\@import "http://webfonts.ru/import/permian.css";
/*
	Permian Sans, 400, 400 italic, 700
*/
.indent_width {margin:20% auto;width:20%}

.text_reply{
	/* border:1px solid orange; */

	text-align:center;
	color: rgba(78,78,78,1);
	font-family: 'Permian Sans';font-size: 28px;
	font-weight: 400;
	line-height: 1.6em;
	width: 700px;
}



a.button {

  font-weight: 700;
  color: white;

  text-decoration: none;
  padding: .3em 1em calc(.3em + 3px);
  border-radius: 3px;
  background: rgb(64,199,129);
  box-shadow: 0 -3px rgb(53,167,110) inset;
  transition: 0.2s;
}

a.button:hover { background: rgb(53, 167, 110); }

a.button:active {
  background: rgb(33,147,90);
  box-shadow: 0 3px rgb(33,147,90) inset;
}



</style>
</head>
<body>

<div class="text_reply indent_width" style="display:block">
    $data

</div>


<script>
   //[].forEach.call(document.querySelectorAll("*"),function(a){a.style.outline="2px solid #"+(~~(Math.random()*(1<<24))).toString(16)})
</script>

</body>



EOF

$page=collapse($page);
print <<EOF;
Status: 200 OK
Content-type: text/html; charset=utf-8

$page

EOF

}



##################################################
sub proccesing_region_and_order_phone {
     if    ($call_Lyubertsy)          {return ($call_Lyubertsy,"регион Люберцы");}
     elsif ($call_Balashiha)          {return ($call_Balashiha,"регион Балашиха");}
     elsif ($call_Zheleznodorozhnyiy) {return ($call_Zheleznodorozhnyiy,"регион Железнодорожный");}
     elsif ($call_Volzhskaya)         {return ($call_Volzhskaya,"регион Волжская");}
     elsif ($call_Marino)             {return ($call_Marino,"регион Марьино");}

     else                             {return ("ПРОИЗОШЛА ОШИБКА!!! ПРИ ВВОДЕ НОМЕРА","ПРОИЗОШЛА ОШИБКА!!! ПРИ ОПРЕДЕЛЕНИИ РЕГИОНА");}
}

#########################
sub send_mail {
  my($to,$subj,$msg)=@_;
  my $count_error_mail=0; ## Счетчик ошибки при открытии потока sendmail
  my $count_error_send_mail=0; ## Счетчик ошибок при отсылания файла, инкрементируем при каждом удчном выполненом действии
  unless(open(SENDMAIL, "|/usr/sbin/sendmail -t")) {
        $count_error_mail=1;
        return ($count_error_mail,'ОШИБКА ПРИ ОТКРЫТИИ ПОТОКА SENDMAIL');
        }
 my $MAIL_FROM='ActiveCloud <andrey7@ru111.activeby.net>';


  print SENDMAIL "From: ${MAIL_FROM}\n"; $count_error_send_mail++;
  print SENDMAIL "To: ${to}\n";          $count_error_send_mail++;
  print SENDMAIL "Subject: ${subj}\n\n"; $count_error_send_mail++;
  print SENDMAIL "${msg}";               $count_error_send_mail++;
  close(SENDMAIL);                       $count_error_send_mail++;

   if ($count_error_send_mail==5) {
      return ($count_error_send_mail,'ВЫСЛАНО');
   }
   else {
      return ($count_error_send_mail,'ОШИБКА ПРИ ОТПРАВКЕ ПИСЬМА!!!');
   }

}


#############################
sub get_time {
  use Time::localtime;
my $tm = localtime;
my ($DAY, $MONTH, $YEAR) = ($tm->mday, $tm->mon, $tm->year);
$MONTH=$MONTH+1;
$YEAR=$YEAR+1900;
#my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) =localtime(time);
#print " DAY===$DAY \t MONTH===$MONTH \t YEAR===$YEAR\n";
my @D_MONTH;
$D_MONTH[1]='января';
$D_MONTH[2]='февраля';
$D_MONTH[3]='марта';
$D_MONTH[4]='апреля';
$D_MONTH[5]='мая';
$D_MONTH[6]='июня';
$D_MONTH[7]='июля';
$D_MONTH[8]='августа';
$D_MONTH[9]='сентября';
$D_MONTH[10]='октября';
$D_MONTH[11]='ноября';
$D_MONTH[12]='декабря';


#print "Name of month===$D_MONTH{$MONTH} YEAR===$YEAR\n";

my ($sec ,$min ,$hour, $mday, $mon, $year, $wday ,$yday,$isdst ) = gmtime(time);
$hour=$hour+3;
   if ($hour<=9)  {$hour='0'."$hour";}
   if ($hour==24) {$hour='00';}
   if ($min<=9)   {$min='0'."$min";}
   if ($sec<=9)   {$sec='0'."$sec";}
#print "HOUR===$hour \t MIN===$min \t SEC===$sec \t SEASON_TIME===$isdst ; \n";

return ($sec,$min,$hour,$mday,\$D_MONTH[$MONTH],$YEAR); # Возвращаем название месяца и год

}

#############################
sub get_ip_client {
my $ip;
  ## если ключ HTTP_X_FORWARDED_FOR определен
  if ( $ENV{ HTTP_X_FORWARDED_FOR } ) {

   ## в переменную $ip записывается IP-адрес
   ## клиента, подключенного через прокси
   $ip = $ENV{ HTTP_X_FORWARDED_FOR};
  }
  else {
   ## в противном случае запишем в $ip
   ## удаленный IP-адрес клиента
   $ip = $ENV{ REMOTE_ADDR };
  }
return $ip;
}



#############################
sub collapse {
  my $page=shift;

$page=~s/\n//g;                 # В одну строчку делаем
$page=~s/\s+/ /g;


$page=~s/<\!\-\-[^!]+\-\->//g;  # Уничтожаем html комментарии
$page=~s/\/\*[^\/\/\*]+\*\///g; # Уничтожаем css и js комментарии

                                 # Уничтожаем пробелы в стилях
$page=~s/\s*{\s*/{/g;
$page=~s/\s*}\s*/}/g;

return $page;
}