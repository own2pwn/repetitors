package routing_order_call;
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



# РОУТИНГ ДЛЯ ORDER_CALL.PL

# start(\%CONTEXT);
sub start {
  my ($refCONTEXT,$refApp) = @_;

  $refCONTEXT -> {'hash_cgi'} = cgi_url::CGI_hash();
  # Количество ключей в URL
  $refCONTEXT -> {len_cgi_k} = scalar keys %{$refCONTEXT -> {'hash_cgi'}};
  # Построили url из {cgi_key} = cgi_value и сохранили url по ключу formed_url
  $refCONTEXT -> {'formed_url'} = cgi_url::proccesing_url_keys($refCONTEXT -> {'hash_cgi'});

  Routing($refCONTEXT,$refApp);
}

# /**
#  * роутинг для order_call.pl
#  * @param  [refFunction] $refApp ссылка на функцию выполнение приложения
#  */
sub Routing {
  my ($refCONTEXT,$refApp) = @_;
  my $teacher_id = ($refCONTEXT -> {'hash_cgi'} && $refCONTEXT -> {'hash_cgi'} -> {'teacher'}) ?
                    $refCONTEXT -> {'hash_cgi'} -> {'teacher'} : '';
  my $region = ($refCONTEXT -> {'hash_cgi'} && $refCONTEXT -> {'hash_cgi'} -> {'region'}) ?
                $refCONTEXT -> {'hash_cgi'} -> {'region'} : '';
  my $ph = ($refCONTEXT -> {'hash_cgi'} && $refCONTEXT -> {'hash_cgi'} -> {'ph'})
            ? $refCONTEXT -> {'hash_cgi'} -> {'ph'} : '';

  my $formed_url = $refCONTEXT -> {'formed_url'};
  my $cur_url = '';

  # write_env::start('./../env.txt');
  wf::save_to_file('');

  # Скрипт без параметров
  if (!$ENV{'QUERY_STRING'} && $ENV{'REQUEST_URI'} eq '/cgi-bin/order_call_3.pl') {
    # $teacher_id = 1;
    $CONTEXT{'teacher_id'} = $teacher_id;
    $cur_url = '/';
    wf::add_to_file($path_log,"Редирект 302 (пришли на скрипт $ENV{SCRIPT_NAME} без параметров)\n\n");
    http::redirect(302,$c->{domain});
  }
  # Есть параметры в URL
  else {
    exists_param_in_url($refCONTEXT, $refApp, $cur_url, $teacher_id);
  }
}

sub exists_param_in_url {
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

sub Routing_old {
  my $teacher_id = ($CONTEXT{'hash_cgi'} && $CONTEXT{'hash_cgi'} -> {'teacher'}) ? $CONTEXT{'hash_cgi'} -> {'teacher'} : '';
  my $region = ($CONTEXT{'hash_cgi'} && $CONTEXT{'hash_cgi'} -> {'region'}) ? $CONTEXT{'hash_cgi'} -> {'region'} : '';
  my $ph = ($CONTEXT{'hash_cgi'} && $CONTEXT{'hash_cgi'} -> {'ph'}) ? $CONTEXT{'hash_cgi'} -> {'ph'} : '';

  my $formed_url = $CONTEXT{'formed_url'};
  my $cur_url = '';

  # Главная страница
  if ($ENV{'QUERY_STRING'} eq '' && $ENV{'REQUEST_URI'} eq '/cgi-bin/order_call_3.pl') {
    # $teacher_id = 1;
    $CONTEXT{'teacher_id'} = $teacher_id;
    $cur_url = '/';
    http::redirect(302,$c->{domain});
  }
  # Есть параметры в URL
  else {
    $cur_url = '?'.$ENV{'QUERY_STRING'};
    if ( $formed_url eq $cur_url ) {
      if ( $teacher_id < 1) {
        http::redirect(301,$c->{domain});
      }
      # TODO: Сделать forward на страницу данного преподавателя, а не на главную страницу
      elsif (!$CONTEXT{'base_teachers'} -> {$teacher_id} || $region eq '' || $ph eq '') {
        http::redirect(302,$c->{domain});
      }
      else {
        $CONTEXT{'teacher_id'} = $teacher_id;
        $CONTEXT{'region'} = $region;
        $CONTEXT{'ph'} = $ph;
        App();
      }
    }
    # Если есть лишние ключи
    else {
      http::redirect(302,$c->{domain}.'cgi-bin/order_call_3.pl'.$formed_url);
    }
  }

}

1;