package get_time;
#!/usr/bin/perl
use strict;

# МОДУЛЬ ОПРЕДЕЛЕНИЯ ВРЕМЕНИ В РАЗНЫХ ФОРМАТАХ


# my ($sec,$min,$hour,$day,$ref_nmonth,$year) = time_email();
# my $subject = "Заказали звонок в $hour:$min:$sec $day $$ref_nmonth $year\n";
# print $subject;

# Время для Subject email
sub time_email {
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

  my ($sec ,$min ,$hour, $mday, $mon, $year, $wday ,$yday, $isdst) = gmtime(time);
  $hour = $hour + 3;
  if ($hour <= 9)  {$hour='0'."$hour";}
  if ($hour == 24) {$hour='00';}
  if ($min <= 9)   {$min='0'."$min";}
  if ($sec <= 9)   {$sec='0'."$sec";}
  #print "HOUR===$hour \t MIN===$min \t SEC===$sec \t SEASON_TIME===$isdst ; \n";
  return "$hour:$min:$sec $mday $D_MONTH[$MONTH] $YEAR\n";
}

# Возвращает секунды, минуты, час, день месяца, месяц(ссылку), год
sub get_time {
  use Time::localtime;
  my $tm = localtime;
  my ($DAY, $MONTH, $YEAR) = ($tm->mday, $tm->mon, $tm->year);

  $MONTH=$MONTH+1;
  $YEAR=$YEAR+1900;

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


  my ($sec ,$min ,$hour, $mday, $mon, $year, $wday ,$yday, $isdst) = gmtime(time);
  $hour = $hour + 3;
  if ($hour <= 9)  {$hour='0'."$hour";}
  if ($hour == 24) {$hour='00';}
  if ($min <= 9)   {$min='0'."$min";}
  if ($sec <= 9)   {$sec='0'."$sec";}
  #print "HOUR===$hour \t MIN===$min \t SEC===$sec \t SEASON_TIME===$isdst ; \n";

  return ($sec, $min, $hour,$mday,\$D_MONTH[$MONTH],$YEAR); # Возвращаем название месяца и год
}

1;