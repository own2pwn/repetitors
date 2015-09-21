#!/usr/bin/perl

use strict;
use CGI;

use lib './';
use config;
my $c = config::settings();

use base_teachers;
use base_links_to_teachers;

use module__read_static_data;
use module__header;
use module__h_menu;
use module__menu_top_teacher;
use module__social_net;
use module__form_order_call;
use module__links_to_teachers;
use module__table_price;
use module__list_districts;
use module__contacts_filials;
use module__main_column_third;
use module__comments_vk;
use module__footer;

use module__insert_contact_js;
use module__metrica_analytics_js;
use module__insert_cookieks;

use routing_index;
use view_index;

use lib './my/';
use cgi_url;
use build_path;
use http;
use collapse;
use wf;
use md5;

my %CONTEXT = ('min' => 0, collapse => $c->{collapse}, domain => $c -> {domain}, api_js => $c -> {api_js});
base_teachers::start(\%CONTEXT,'base_teachers');
base_links_to_teachers::start(\%CONTEXT,'base_links_to_teachers');


$CONTEXT{'hash_cgi'} = cgi_url::CGI_hash();
# Построили url из {cgi_key} = cgi_value и сохранили url по ключу formed_url
$CONTEXT{'formed_url'} = cgi_url::proccesing_url_keys($CONTEXT{'hash_cgi'});

$CONTEXT{App} = \&App;
routing_index::start(\%CONTEXT);
# test_start();




sub App {
                      print http::header();

                      module__read_static_data::start(\%CONTEXT,$CONTEXT{'teacher'});

                      module__header::start(\%CONTEXT,'header');
                      module__h_menu::start(\%CONTEXT,'main_menu');
                      module__menu_top_teacher::start(\%CONTEXT,'teacher_menu');
                      module__social_net::start(\%CONTEXT,'social_net');
                      module__form_order_call::start(\%CONTEXT,'form_order_call');
                      module__links_to_teachers::start(\%CONTEXT,'links_to_teachers');

                      module__table_price::start(\%CONTEXT,'branch_price');
                      module__table_price::start(\%CONTEXT,'individual_price');
                      module__list_districts::start(\%CONTEXT,'list_districts');
                      module__contacts_filials::start(\%CONTEXT,'contacts_filials');
                      module__comments_vk::start(\%CONTEXT,'vk_comments');
                      module__main_column_third::start(\%CONTEXT,'column_page');

                      module__footer::start(\%CONTEXT,'footer');

                      module__insert_contact_js::start(\%CONTEXT,'insert_contact_js');
                      module__metrica_analytics_js::start(\%CONTEXT,'metrica_analytics_js');
                      module__insert_cookieks::start(\%CONTEXT,'insert_cookieks');


                      view_index::start(\%CONTEXT,'view_index');

                      print collapse::simple_collapse(\%CONTEXT,$CONTEXT{'view_index'});;
}



sub test_start {
  $CONTEXT{'teacher'} = 1;
  App();
}

