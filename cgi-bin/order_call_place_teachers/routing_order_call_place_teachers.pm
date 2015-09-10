package routing_order_call_place_teachers;
#!/usr/bin/perl
# use 5.016;
use strict;

# use Data::Dumper;

# use lib '../';
# use config;
# my $c = config::settings();


# use lib '../my/';
# use cgi_url;
# use http;
# use wf;
# use write_env;


# my %CONTEXT = ('min' => 0, collapse => $c->{collapse}, domain => $c -> {domain});

my $path_log = '../../log/script.txt';



# РОУТИНГ ДЛЯ ORDER_CALL_PLACE_TEACHERS.PL

# start(\%CONTEXT);
sub start {
  my ($refCONTEXT) = @_;

  # $refCONTEXT -> {'hash_cgi'} = cgi_url::CGI_hash() || {};
  # Построили url из {cgi_key} = cgi_value и сохранили url по ключу formed_url
  # $refCONTEXT -> {'formed_url'} = cgi_url::proccesing_url_keys($refCONTEXT -> {'hash_cgi'});
  Routing($refCONTEXT);
}


sub Routing {
  my $refCONTEXT = shift;
  #  предмет по которому хочет разместиться репетитор
  $refCONTEXT -> {'sub'} = cgi_url::decode($refCONTEXT -> {'hash_cgi'} -> {'sub'}) || '';
  $refCONTEXT -> {'ph'}  = cgi_url::decode($refCONTEXT -> {'hash_cgi'} -> {'ph'})  || '';

  wf::save_to_file($path_log,"");
  # wf::save_to_file($path_log,"sub = ".$refCONTEXT -> {'sub'}."\n\n");
  # wf::save_to_file($path_log,"ph = ".$refCONTEXT -> {'ph'}."\n\n");

  # Главная страница /cgi-bin/order_call_place_teachers/order_call_place_teachers.pl
  if (!$ENV{'QUERY_STRING'} && $ENV{'REQUEST_URI'} eq $ENV{SCRIPT_NAME}) {
    wf::add_to_file($path_log,
      "Пришли на $ENV{SCRIPT_NAME} (заказ звонка для размещения преподавателя) без параметров редирект на $refCONTEXT->{domain}\n\n");
    http::redirect(302,$refCONTEXT -> {domain});
  }
  # Есть параметры в URL
  else {
    exists_param_in_url($refCONTEXT);
  }
}

sub exists_param_in_url {
  my $refCONTEXT = shift;
  my $formed_url = $refCONTEXT -> {formed_url};
  my $domain     = $refCONTEXT -> {domain};

  my $cur_url = '?'.$ENV{'QUERY_STRING'};
  wf::add_to_file($path_log,"Введенный: $cur_url\n");
  wf::add_to_file($path_log,"Собранный: $formed_url\n");

  my $sub = $refCONTEXT -> {'sub'};
  my $ph  = $refCONTEXT -> {'ph'};

  if ( $formed_url eq $cur_url ) {
    if (!$sub || !$ph) {
      wf::add_to_file($path_log,
        "Редирект 302 (!phone || !subject) c $ENV{SCRIPT_NAME} на main page $domain\n\n");
      http::redirect(302,$domain);
    }
    else {
      $refCONTEXT -> {'sub'} = $sub;
      $refCONTEXT -> {'ph'} = $ph;
      wf::add_to_file($path_log,"Запуск приложения $ENV{SCRIPT_NAME}\n\n");
      &{$refCONTEXT->{App}};
    }
  }
  # Если есть лишние ключи
  else {
    wf::add_to_file($path_log,"Редирект(не совпали ключи) c $ENV{SCRIPT_NAME} на собранный url $domain$ENV{SCRIPT_NAME}$formed_url \n\n");
    http::redirect(302,$domain.$ENV{SCRIPT_NAME}.$formed_url);
  }
}


1;