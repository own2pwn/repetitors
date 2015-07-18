package routing_index;
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

my $path_log = '../log/script.txt';



# РОУТИНГ ДЛЯ INDEX.PL

# start(\%CONTEXT);
sub start {
  my ($refCONTEXT,$refApp) = @_;

  $refCONTEXT -> {'hash_cgi'} = cgi_url::CGI_hash();
  # Построили url из {cgi_key} = cgi_value и сохранили url по ключу formed_url
  $refCONTEXT -> {'formed_url'} = cgi_url::proccesing_url_keys($refCONTEXT -> {'hash_cgi'});

  Routing($refCONTEXT,$refApp);
}

# /**
#  * роутинг для index.pl
#  * @param  [refFunction] $refApp ссылка на функцию выполнение приложения
#  */
sub Routing {
  my ($refCONTEXT,$refApp) = @_;
  my $teacher_id = ($refCONTEXT -> {'hash_cgi'} && $refCONTEXT -> {'hash_cgi'} -> {'teacher'}) ? $refCONTEXT -> {'hash_cgi'} -> {'teacher'} : 1;
  my $formed_url = $refCONTEXT -> {'formed_url'};
  my $cur_url = '';
  my $domain = $refCONTEXT->{domain};

  # write_env::start('./../env.txt');

  # Главная страница
  if (!$ENV{'QUERY_STRING'} && $ENV{'REQUEST_URI'} eq '/') {
    # $teacher_id = 1;
    $refCONTEXT -> {'teacher_id'} = $teacher_id;
    $cur_url = '/';
    wf::add_to_file($path_log,"Запуск приложения (это главная страница)\n\n");
    &$refApp();
  }
  # Есть параметры в URL
  else {
    $cur_url = '?'.$ENV{'QUERY_STRING'};
    wf::add_to_file($path_log,"Введенный: $cur_url\n");
    wf::add_to_file($path_log,"Собранный: $formed_url\n");

    if ( $formed_url eq $cur_url ) {
      # print "<b>Правильные ключи для $formed_url</b>";
      if ($teacher_id<=1) {
        wf::add_to_file($path_log,"Редирект 301(id<=1) на main page $domain\n\n");
        http::redirect(301,$domain);
        # print "<br><b> Редирект 301 на http://127.0.0.1/</b>";
      }
      elsif (!$refCONTEXT -> {'base_teachers'} -> {$teacher_id}) {
        wf::add_to_file($path_log,"Редирект 302(препод отсуствует в базе) на main page $domain\n\n");
        http::redirect(302,$domain);
        # print "<br><b> Редирект 302 на http://127.0.0.1/</b>";
      }
      else {
        $refCONTEXT -> {'teacher_id'} = $teacher_id;
        # print $head;
        # print "<br><b>Запуск приложения!</b>";
        wf::add_to_file($path_log,"Запуск приложения\n\n");
        &$refApp();
      }
    }
    # Если есть лишние ключи
    else {
      # print $head;
      # print "<b>Редирект на $formed_url</b>";
      wf::add_to_file($path_log,"Редирект(лишние ключи) на собранный url $domain$formed_url \n\n");
      http::redirect(302,$domain.$formed_url);
    }
  }

}
1;