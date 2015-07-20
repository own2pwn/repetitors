#!/usr/bin/perl

use strict;
use CGI;
use lib './';

use base_teachers;


my $stop_browser_cache = "Expires: Mon, 26 Jul 1997 05:00:00 GMT\r\nCache-Control: no-cache, must-revalidate\r\nPragma: no-cache\r\n";
my $head ="Status: 200 OK\r\nX-FRAME-OPTIONS: DENY\r\nContent-type: text/html; charset=UTF-8\r\n";
        $head.= $stop_browser_cache;
        $head.="\r\n";

my %CONTEXT = ();

start();
sub start{
  base_teachers::start(\%CONTEXT,'base_teachers');

  # Построили хэш {cgi_key} = cgi_value;
  CGI_hash('hash_cgi');
  # Построили url из {cgi_key} = cgi_value и сохранили url по ключу formed_url
  Proccesing_Url_Keys('hash_cgi','formed_url');
  Routing();
}


sub CGI_hash {
  my ($key) = @_;
  my @array_cgi = CGI::param();
  # Построили хэш {cgi_key} = cgi_value;
  my %hash_cgi = ();
  foreach my $k (@array_cgi) {
    # if (value) {} в случае
    $hash_cgi{$k} = CGI::param($k);
  }
  $CONTEXT{$key} = \%hash_cgi;
}

sub Proccesing_Url_Keys{
  my ($key_cgi,$key_url) = @_;
  my @ar_key_mandatory = ('teacher','ph');
  my $url = '?';

  if ($CONTEXT{$key_cgi}) {
    my $hash_cgi = $CONTEXT{$key_cgi};
    foreach my $k (@ar_key_mandatory) {
      if ($hash_cgi -> {$k}) {
        $url.="$k=$hash_cgi->{$k}&";
      }
    }
    $url =~s/&$//ig;
  }
  else {
    # print "Не существует параметров для url!\n";
  }

  $CONTEXT{$key_url} = $url;

}

sub Routing {
  my $teacher_id = $CONTEXT{'hash_cgi'} -> {'teacher'};
  my $formed_url = $CONTEXT{'formed_url'};
  # my $cur_url = '?'.$ENV{'QUERY_STRING'};
  my $cur_url = '';

  # print "<p>Введенный: $cur_url</p>";
  # print "<p>Собранный: $formed_url</p>";

  if ($ENV{'QUERY_STRING'} eq '' && $ENV{'REQUEST_URI'} eq '/cgi-bin/test.pl') {
    # $teacher_id = 1; $CONTEXT{'teacher'} = 1;
    print $head;
    $cur_url = '/';
    print "<p>Текущий url $cur_url</p>";
    print "<b>Запуск приложения!</b>";
    App();
  }
  else {
    $cur_url = '?'.$ENV{'QUERY_STRING'};
    if ( $formed_url eq $cur_url ) {
      print "<b>Правильные ключи для $formed_url</b>";
      if ($teacher_id<=1) {
        redirect(301,'http://127.0.0.1/');
        # print "<br><b> Редирект 301 на http://127.0.0.1/</b>";
      }
      elsif (!$CONTEXT{'base_teachers'} -> {$teacher_id}) {
        redirect(302,'http://127.0.0.1/');
        # print "<br><b> Редирект 302 на http://127.0.0.1/</b>";
      }
      else {
        # $CONTEXT{'teacher'} = $teacher_id;
        print $head;
        print "<br><b>Запуск приложения!</b>";
        App();
      }
    }
    # Если есть лишние ключи
    else {
      # print $head;
      # print "<b>Редирект на $formed_url</b>";
      redirect(302,'http://127.0.0.1/'.$formed_url);
    }
  }

}


sub App {
  my %build_url;
  # Набили параметры для примера
  $build_url{'teacher'} = 125;
  $build_url{'ph'} = 89163412070;
  $CONTEXT{'build_url'} = \%build_url;
  # Построили из них url
  Proccesing_Url_Keys('build_url','formed_url');
  print " <p>$CONTEXT{'formed_url'}\n</p>";
}

sub redirect {
  my ($redirect_status, $url)=@_; # // 301 - Permanently // 302 - Temporarily
  my $stop_browser_cache = "Expires: Mon, 26 Jul 1997 05:00:00 GMT\r\nCache-Control: no-cache, must-revalidate\r\nPragma: no-cache\r\n";
  print "Status: ".$redirect_status."\r\n".$stop_browser_cache.'Location: '.$url."\r\n\r\n";
}