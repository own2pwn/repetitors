#!/usr/bin/perl

use strict;
use CGI;
use Data::Dumper;

use lib '../';
use config;
my $c = config::settings();

my %CONTEXT = ('min' => 0, collapse => $c->{collapse}, domain => 'http://'.$ENV{HTTP_HOST}, api_js => $c -> {api_js});

use lib '../all_teachers/';
use base_subjects;
base_subjects::start(\%CONTEXT,'base_subjects');
use collect_teachers_in_subjects;
use module__menu_by_subjects;
use module__footer_menu_by_subject;

use lib '../';
# use base_teachers;
use base_links_to_teachers;
# base_teachers::start(\%CONTEXT,'base_teachers');
base_links_to_teachers::start(\%CONTEXT,'base_links_to_teachers');

use module__header;
use module__h_menu;
use module__social_net;
use module__main_column_third;
use module__footer;

use module__insert_contact_js;
use module__metrica_analytics_js;
use module__insert_cookieks;

use lib './';
use base_types_forms;
base_types_forms::start(\%CONTEXT,'base_types_forms');
use base_seo_for_place_teach;
use form_order_call_teachers;
use text_for_place_teachers;
use routing_place_teachers;
use view_place_teachers;

use lib '../my/';
use cgi_url;
use build_path;
use http;
use collapse;
use wf;
use md5;
use md5;

use lib '../css/';
use base_css;
use column_css;


$CONTEXT{'hash_cgi'} = cgi_url::CGI_hash();
# Построили url из {cgi_key} = cgi_value и сохранили url по ключу formed_url
$CONTEXT{'formed_url'} = cgi_url::proccesing_url_keys($CONTEXT{'hash_cgi'});

# $CONTEXT{App} = \&App;
# routing_place_teachers::start(\%CONTEXT);
test_start();




sub App {
                      print http::header();
                      base_seo_for_place_teach::start(\%CONTEXT,'base_seo');
                      module__header::start(\%CONTEXT,'header');
                      module__h_menu::start(\%CONTEXT,'main_menu');
                      module__social_net::start(\%CONTEXT,'social_net');
                      module__menu_by_subjects::start(\%CONTEXT,'menu_teachers_by_subjects');

                      text_for_place_teachers::start(\%CONTEXT,'text_for_place_teachers');
                      form_order_call_teachers::start(\%CONTEXT,'form_order_call');

                      module__main_column_third::start(\%CONTEXT,'column_page');

                      module__footer_menu_by_subject::start(\%CONTEXT,'footer');

                      module__insert_contact_js::start(\%CONTEXT,'insert_contact_js');
                      module__metrica_analytics_js::start(\%CONTEXT,'metrica_analytics_js');
                      module__insert_cookieks::start(\%CONTEXT,'insert_cookieks');

                      view_place_teachers::start(\%CONTEXT,'view_all_teachers');

                      print collapse::simple_collapse(\%CONTEXT,$CONTEXT{'view_all_teachers'});
}



sub test_start {
  $CONTEXT{'subject'} = 'all';
  App();
}

