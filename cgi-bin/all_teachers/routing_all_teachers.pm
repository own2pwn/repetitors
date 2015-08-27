package routing_all_teachers;
#!/usr/bin/perl
# use 5.016;
use strict;

# use Data::Dumper;

# use lib './';
# use config;
# my $c = config::settings();


# use lib './my/';
# use cgi_url;
# use http;
# use wf;
# use write_env;


# my %CONTEXT = ('min' => 0, collapse => $c->{collapse}, domain => $c -> {domain});

my $path_log = '../../log/script.txt';



# РОУТИНГ ДЛЯ ROUTING_ALL_TEACHERS.PL

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
  my $subject = $refCONTEXT -> {'hash_cgi'} -> {'sub'} || 'all';

  # write_env::start('./../env.txt');
  # wf::save_to_file($path_log,'');

  # Главная страница
  if (!$ENV{'QUERY_STRING'} && $ENV{'REQUEST_URI'} eq $ENV{SCRIPT_NAME}) {
    $refCONTEXT -> {'subject'} = 'all';
    # $cur_url = '/';
    wf::add_to_file($path_log,
      "Пришли на $ENV{SCRIPT_NAME} (все преподаватели) без параметров редирект на $refCONTEXT->{domain}\n\n");
    http::redirect(302,$refCONTEXT -> {domain});
  }
  # Есть параметры в URL
  else {
    $refCONTEXT -> {'subject'} = $subject;
    exists_param_in_url($refCONTEXT);
  }
}

sub exists_param_in_url {
  my $refCONTEXT = shift;
  my $formed_url = $refCONTEXT -> {'formed_url'};

  my $cur_url = '?'.$ENV{'QUERY_STRING'};
  wf::add_to_file($path_log,"Введенный: $cur_url\n");
  wf::add_to_file($path_log,"Собранный: $formed_url\n");

  my $subject= $refCONTEXT -> {'subject'};
  my $domain = $refCONTEXT -> {domain};
  my $valid_values = $refCONTEXT -> {base_subjects};

  if ( $formed_url eq $cur_url ) {
    if (!$valid_values->{$subject}) {
      wf::add_to_file($path_log,"Редирект 301(не допустимый параметр) на main page $domain\n\n");
      http::redirect(301,$domain);
    }
    else {
      $refCONTEXT -> {'subject'} = $subject;
      wf::add_to_file($path_log,"Запуск приложения all_teachers.pl\n\n");
      &{$refCONTEXT->{App}}
    }
  }
  # Если есть лишние ключи
  else {
    wf::add_to_file($path_log,"Редирект(не совпали ключи) на собранный url $domain$ENV{SCRIPT_NAME}$formed_url \n\n");
    http::redirect(302,$domain.$ENV{SCRIPT_NAME}.$formed_url);
  }
}

1;