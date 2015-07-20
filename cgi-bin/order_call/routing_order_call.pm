package routing_order_call;
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



# РОУТИНГ ДЛЯ ORDER_CALL.PL

# start(\%CONTEXT);
sub start {
  my ($refCONTEXT) = @_;

  $refCONTEXT -> {'hash_cgi'} = cgi_url::CGI_hash() || {};
  # Построили url из {cgi_key} = cgi_value и сохранили url по ключу formed_url
  $refCONTEXT -> {'formed_url'} = cgi_url::proccesing_url_keys($refCONTEXT -> {'hash_cgi'});
  Routing($refCONTEXT);
}


sub Routing {
  my $refCONTEXT = shift;
  $refCONTEXT -> {'teacher'} = $refCONTEXT -> {'hash_cgi'} -> {'id'} || 1;
  $refCONTEXT -> {'region'} = $refCONTEXT -> {'hash_cgi'} -> {'region'} || '';
  $refCONTEXT -> {'ph'} = $refCONTEXT -> {'hash_cgi'} -> {'ph'} || '';

  # write_env::start('./../env.txt');
  wf::save_to_file($path_log,'');

  # Главная страница /cgi-bin/order_call/order_call_3.pl
  if (!$ENV{'QUERY_STRING'} && $ENV{'REQUEST_URI'} eq $ENV{SCRIPT_NAME}) {
    wf::add_to_file($path_log,
      "Пришли на $ENV{SCRIPT_NAME} (заказ звонка) без параметров редирект на $refCONTEXT->{domain}\n\n");
    http::redirect(302,$refCONTEXT -> {domain});
  }
  # Есть параметры в URL
  else {
    exists_param_in_url($refCONTEXT);
  }
}

sub exists_param_in_url {
  my $refCONTEXT = shift;
  my $formed_url = $refCONTEXT -> {'formed_url'};

  my $cur_url = '?'.$ENV{'QUERY_STRING'};
  wf::add_to_file($path_log,"Введенный: $cur_url\n");
  wf::add_to_file($path_log,"Собранный: $formed_url\n");

  correct_keys($refCONTEXT,$cur_url);
}

sub correct_keys {
  my ($refCONTEXT, $cur_url) = @_;

  my $teacher_id = $refCONTEXT -> {'teacher'};
  my $region = $refCONTEXT -> {'region'};
  my $ph = $refCONTEXT -> {'ph'};

  my $formed_url = $refCONTEXT -> {'formed_url'};
  my $domain = $refCONTEXT -> {domain};

  if ( $formed_url eq $cur_url ) {
    if ($teacher_id < 1) {
      wf::add_to_file($path_log,"Редирект 301(id<1) c $ENV{SCRIPT_NAME} на main page $domain\n\n");
      http::redirect(301,$domain);
    }
    # TODO: Сделать forward на страницу данного преподавателя, а не на главную страницу
    elsif (!$refCONTEXT -> {'base_teachers'} -> {$teacher_id} || !$region || !$ph) {
      wf::add_to_file($path_log,
        "Редирект 302 (препод отсуствует в базе || !$ph || !$region) c $ENV{SCRIPT_NAME} на main page $domain\n\n");
      http::redirect(302,$domain);
    }
    else {
      $refCONTEXT -> {'teacher'} = $teacher_id;
      $refCONTEXT -> {'region'} = $region;
      $refCONTEXT -> {'ph'} = $ph;
      wf::add_to_file($path_log,"Запуск приложения $ENV{SCRIPT_NAME}\n\n");
      &{$refCONTEXT->{App}}
    }
  }
  # Если есть лишние ключи
  else {
    wf::add_to_file($path_log,"Редирект(не совпали ключи) c $ENV{SCRIPT_NAME} на собранный url $domain$formed_url \n\n");
    http::redirect(302,$domain.$ENV{SCRIPT_NAME}.$formed_url);
  }
}


1;