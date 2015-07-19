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
  my ($refCONTEXT) = @_;

  $refCONTEXT -> {'hash_cgi'} = cgi_url::CGI_hash();
  # Количество ключей в URL
  $refCONTEXT -> {len_cgi_k} = scalar keys %{$refCONTEXT -> {'hash_cgi'}};
  # Построили url из {cgi_key} = cgi_value и сохранили url по ключу formed_url
  $refCONTEXT -> {'formed_url'} = cgi_url::proccesing_url_keys($refCONTEXT -> {'hash_cgi'});

  Routing($refCONTEXT);
}


sub Routing {
  my ($refCONTEXT) = @_;
  my $teacher_id = ($refCONTEXT -> {'hash_cgi'} && $refCONTEXT -> {'hash_cgi'} -> {'teacher'}) ?
                   $refCONTEXT -> {'hash_cgi'} -> {'teacher'} : 1;
  my $cur_url = '';

  # write_env::start('./../env.txt');
  # wf::save_to_file($path_log,'');

  # Главная страница
  if (!$ENV{'QUERY_STRING'} && $ENV{'REQUEST_URI'} eq '/') {
    # $teacher_id = 1;
    $refCONTEXT -> {'teacher_id'} = $teacher_id;
    $cur_url = '/';
    wf::add_to_file($path_log,"Запуск приложения (это главная страница)\n\n");
    &{$refCONTEXT->{App}};
  }
  # Есть параметры в URL
  else {
    exists_param_in_url($refCONTEXT, $cur_url, $teacher_id);
  }
}

sub exists_param_in_url {
  my ($refCONTEXT, $cur_url, $teacher_id) = @_;
  my $formed_url = $refCONTEXT -> {'formed_url'};
  my $len_k = $refCONTEXT -> {len_cgi_k};

  $cur_url = '?'.$ENV{'QUERY_STRING'};
  wf::add_to_file($path_log,"Введенный: $cur_url\n");
  wf::add_to_file($path_log,"Собранный: $formed_url\n");

  # Должно быть заданное количество ключей
  if ($len_k == 1) {
    correct_keys($refCONTEXT,$cur_url, $teacher_id);
  }
  # Слишком много или мало ключей
  else {
    many_or_few_keys($refCONTEXT, $teacher_id);
  }
}

sub correct_keys {
  my ($refCONTEXT, $cur_url, $teacher_id) = @_;
  my $formed_url = $refCONTEXT -> {'formed_url'};
  my $domain = $refCONTEXT -> {domain};

  if ( $formed_url eq $cur_url ) {
    if ($teacher_id<=1) {
      wf::add_to_file($path_log,"Редирект 301(id<=1) на main page $domain\n\n");
      http::redirect(301,$domain);
    }
    elsif (!$refCONTEXT -> {'base_teachers'} -> {$teacher_id}) {
      wf::add_to_file($path_log,"Редирект 302(препод отсуствует в базе) на main page $domain\n\n");
      http::redirect(302,$domain);
    }
    else {
      $refCONTEXT -> {'teacher_id'} = $teacher_id;
      wf::add_to_file($path_log,"Запуск приложения\n\n");
      &{$refCONTEXT->{App}}
    }
  }
  else {
    wf::add_to_file($path_log,"Редирект(не совпали ключи) на собранный url $domain$formed_url \n\n");
    http::redirect(302,$domain.$formed_url);
  }
}


sub many_or_few_keys {
  my ($refCONTEXT, $teacher_id) = @_;
  # Двухмерный массив [ [ключ, значение], ... ]
  my $ar_key_variable = [['teacher',$teacher_id]];
  my $formed_url = $refCONTEXT -> {'formed_url'};
  my $domain = $refCONTEXT -> {domain};
  $formed_url = build_links($domain,$ar_key_variable);
  wf::add_to_file($path_log,"Редирект(лишние ключи) на собранный url $domain$formed_url \n\n");
  http::redirect(302,build_links($domain,$ar_key_variable));
}

# /**
#  * функция построения URL
#  * @param  [строка]  domen домен
#  * @param  [refAr]   ссылка на двухмерный массив (('teacher','1'),('ph','89067893456'))
#  * @return [строка]  полный URL
#  */
sub build_links {
  my ($domain,$ref_ar_keys) = @_;
  my %hash_buld;
  foreach my $e (@$ref_ar_keys) {
    my $k = $e -> [0];
    my $v = $e -> [1];
    $hash_buld{$k} = $v;
  }
  return cgi_url::proccesing_url_keys(\%hash_buld);
}



1;