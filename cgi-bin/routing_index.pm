package routing_index;
#!/usr/bin/perl
# use 5.016;
use strict;

# use Data::Dumper;

# use lib './';
# use config;
# my $c = config::settings();


use lib './my/';
use logs;
# use cgi_url;
# use http;
# use wf;
# use write_env;


# my %CONTEXT = ('min' => 0, collapse => $c->{collapse}, domain => $c -> {domain});


# РОУТИНГ ДЛЯ INDEX.PL

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
  my $teacher_id = $refCONTEXT -> {'hash_cgi'} -> {'id'} || 1;

  # Главная страница
  if (!$ENV{'QUERY_STRING'} && $ENV{'REQUEST_URI'} eq '/') {
    $refCONTEXT -> {'teacher'} = 1;
    # $cur_url = '/';
    # wf::add_to_file($path_log,"Запуск приложения (это главная страница)\n\n");
    logs::script("Запуск приложения (это главная страница)\n\n");
    &{$refCONTEXT->{App}};
  }
  # Есть параметры в URL
  else {
    $refCONTEXT -> {'teacher'} = $teacher_id;
    exists_param_in_url($refCONTEXT);
  }
}

sub exists_param_in_url {
  my $refCONTEXT = shift;
  my $formed_url = $refCONTEXT -> {'formed_url'};

  my $cur_url = '?'.$ENV{'QUERY_STRING'};
  logs::script("Введенный: $cur_url\n");
  logs::script("Собранный: $formed_url\n");

  my $teacher_id = $refCONTEXT -> {'teacher'};
  my $formed_url = $refCONTEXT -> {'formed_url'};
  my $domain = $refCONTEXT -> {domain};

  if ( $formed_url eq $cur_url ) {
    if ($teacher_id < 1) {
      logs::script("Редирект 301(id<1) на main page $domain\n\n");
      http::redirect(301,$domain);
    }
    elsif (!$refCONTEXT -> {'base_teachers'} -> {$teacher_id}) {
      logs::script("Редирект 302(препод отсуствует в базе) на main page $domain\n\n");
      http::redirect(302,$domain);
    }
    else {
      $refCONTEXT -> {'teacher'} = $teacher_id;
      logs::script("Запуск приложения\n\n");
      &{$refCONTEXT->{App}}
    }
  }
  # Если есть лишние ключи
  else {
    logs::script("Редирект(не совпали ключи) на собранный url $domain$formed_url \n\n");
    http::redirect(302,$domain.$formed_url);
  }
}

1;