#!/usr/bin/perl

use strict;
use CGI;
# use lib '/home_1/andrey7/www/mat-repetitor.ru/cgi-bin/';
use lib './';
use config;
my $c = config::settings();

use base_teachers;
use module__read_static_data;
use module__header;
use module__menu;
use module__social_net;
use module__form_order_call;
use module__table_price;
use module__list_districts;
use module__contacts_filials;
use module__main_column_third;
use module__footer;

use module__insert_contact_js;
use module__metrica_analytics_js;

use view_index;

use lib './my/';
use cgi_url;
use http;
use collapse;

my %CONTEXT = ('min' => 0, collapse => $c->{collapse});
# print $CONTEXT{collapse};exit;
base_teachers::start(\%CONTEXT,'base_teachers');

# my $teacher_id = int(CGI::param("teacher"));


$CONTEXT{'hash_cgi'} = cgi_url::CGI_hash();
# Построили url из {cgi_key} = cgi_value и сохранили url по ключу formed_url
$CONTEXT{'formed_url'} = cgi_url::proccesing_url_keys($CONTEXT{'hash_cgi'});
Routing();



sub Routing {
  my $teacher_id = ($CONTEXT{'hash_cgi'} && $CONTEXT{'hash_cgi'} -> {'teacher'}) ? $CONTEXT{'hash_cgi'} -> {'teacher'} : 1;
  my $formed_url = $CONTEXT{'formed_url'};
  my $cur_url = '';
  # print "<p>Введенный: $cur_url</p>";
  # print "<p>Собранный: $formed_url</p>";

  # Главная страница
  if ($ENV{'QUERY_STRING'} eq '' && $ENV{'REQUEST_URI'} eq '/') {
    # $teacher_id = 1;
    $CONTEXT{'teacher_id'} = $teacher_id;
    $cur_url = '/';
    App();
  }
  # Есть параметры в URL
  else {
    $cur_url = '?'.$ENV{'QUERY_STRING'};
    if ( $formed_url eq $cur_url ) {
      # print "<b>Правильные ключи для $formed_url</b>";
      if ($teacher_id<=1) {
        http::redirect(301,$c->{domen});
        # print "<br><b> Редирект 301 на http://127.0.0.1/</b>";
      }
      elsif (!$CONTEXT{'base_teachers'} -> {$teacher_id}) {
        http::redirect(302,$c->{domen});
        # print "<br><b> Редирект 302 на http://127.0.0.1/</b>";
      }
      else {
        $CONTEXT{'teacher_id'} = $teacher_id;
        # print $head;
        # print "<br><b>Запуск приложения!</b>";
        App();
      }
    }
    # Если есть лишние ключи
    else {
      # print $head;
      # print "<b>Редирект на $formed_url</b>";
      http::redirect(302,$c->{domen}.$formed_url);
    }
  }

}


sub App {
                      print http::header();

                      module__read_static_data::start(\%CONTEXT,$CONTEXT{'teacher_id'});

                      module__header::start(\%CONTEXT,'header');
                      module__menu::start(\%CONTEXT,'teacher_menu');
                      module__social_net::start(\%CONTEXT,'social_net');
                      module__form_order_call::start(\%CONTEXT,'form_order_call');
                      module__table_price::start(\%CONTEXT,'branch_price');
                      module__table_price::start(\%CONTEXT,'individual_price');
                      module__list_districts::start(\%CONTEXT,'list_districts');
                      module__contacts_filials::start(\%CONTEXT,'contacts_filials');
                      module__main_column_third::start(\%CONTEXT,'column_page');
                      module__footer::start(\%CONTEXT,'footer');

                      module__insert_contact_js::start(\%CONTEXT,'insert_contact_js');
                      module__metrica_analytics_js::start(\%CONTEXT,'metrica_analytics_js');


                      view_index::start(\%CONTEXT,'view_index');

                      print collapse::simple_collapse(\%CONTEXT,$CONTEXT{'view_index'});;
}



sub test_start {
  $CONTEXT{'teacher_id'} = 1;
  App();
}

# sub Assembly {

# my $data = $CONTEXT{'view_index'};
# my $stop_browser_cache = "Expires: Mon, 26 Jul 1997 05:00:00 GMT\r\nCache-Control: no-cache, must-revalidate\r\nPragma: no-cache\r\n";
# my $head ="Status: 200 OK\r\nX-FRAME-OPTIONS: DENY\r\nContent-type: text/html; charset=UTF-8\r\n";
#         $head.= $stop_browser_cache;
#         $head.="\r\n";
# }

