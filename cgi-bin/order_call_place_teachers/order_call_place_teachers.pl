#!/usr/bin/perl
use strict;
# use lib '/home/andrey7/www/mat-repetitor.ru/cgi-bin/moduls'; ### Для сервера

# ЗАКАЗ ЗВОНКА НА РАЗМЕЩЕНИЕ ПРЕПОДАВАТЕЛЯ

use CGI;

use lib '../';
use config;
my $c = config::settings();
use Data::Dumper;

use lib '../';
use module__metrica_analytics_js;

use lib '../css/';
use base_css;
use module__button_main_page;

use lib '../my/';
use cgi_url;
use http;
use get_time;
use send_mail;
use collapse;
use build_path;
use wf;
use env;
use meta_tag;

use lib './';
use routing_order_call_place_teachers;
use view_order_call_place_teachers;

my %CONTEXT = ('min' => 0, config => $c, collapse => $c->{collapse}, domain => 'http://'.$ENV{HTTP_HOST});

use lib '../place_teachers/';
use base_types_forms;
base_types_forms::start(\%CONTEXT,'base_types_forms');

$CONTEXT{'hash_cgi'} = cgi_url::CGI_hash();
$CONTEXT{'formed_url'} = cgi_url::proccesing_url_keys($CONTEXT{'hash_cgi'});

# Информация о каждом обрабытаваем параметре (телефон, тип предмета)
my $INFO = {};

$INFO = info();
$CONTEXT{App} = \&App;
routing_order_call_place_teachers::start(\%CONTEXT);


# test_start();



sub App {
                      print http::header();

                      start();

                      $CONTEXT{'path_to_place_teachers'} = build_path::place_teachers($CONTEXT{domain});
                      module__button_main_page::start(\%CONTEXT,'button_main_page');
                      module__metrica_analytics_js::start(\%CONTEXT,'metrica_analytics_js');

                      view_order_call_place_teachers::start(\%CONTEXT,'view_order_call');

                      print collapse::simple_collapse(\%CONTEXT,$CONTEXT{'view_order_call'});
}


sub info {
  my $decode_ph = cgi_url::decode($CONTEXT{'hash_cgi'}{'ph'}) || '';
  return {
     subj => {
        # Валидация отключена
        valid => \&Validate_Subject_On_Place,
        value => cgi_url::decode($CONTEXT{'hash_cgi'}{'sub'}) || '',
        error => 'Неизвестный предмет',
      },
      ph  => {
        valid => \&Validate_Phone,
        value => cgi_url::decode($CONTEXT{'hash_cgi'}{'ph'}) || '',
        error => "Вы ввели неверный телефон: $decode_ph.
                  Попробуйте ввести еще раз.
                  Например  в таком формате: <em> +7(906)1234567 </em>
                  или <em> 89061234567 </em>",
      },
    };
}

# Валидируем значения, если невалидно, то пишем ошибку в результат
# и вываливаемся из цикла
# Если все нормально, то пишем правильный ответ в результат
sub start {
  my $OK = 1;
  my $html_res = '';
  foreach my $k (keys %$INFO) {
    my $p = $INFO -> {$k};
    if (!$p -> {valid}(\%CONTEXT)) {
      $html_res = $p -> {error};
      $OK = 0;
      last;
    }
  }
  if ($OK == 1) {
    $html_res = Assembly_True_Result();
    Preparation_For_Sending_Email();
  }
  $CONTEXT{solve_client}{html} = $html_res;
  # print $CONTEXT{solve_client}{html} || 'NULL';
  # exit;
}

sub Validate_Phone {
  my $ph = $INFO -> {ph} -> {value};
  if ($ph!~/[\d\-\+()]{9,}/i) {
    return 0;
  } else {
    $INFO -> {ph} -> {value} = $ph;
    return 1;
  }
}

#
sub Validate_Subject_On_Place {
  my $refCONTEXT = shift;
  # {'Разместить резюме репетитора по математике:' => ['summary_mathematics_physics','Разместить резюме репетитора по математике(алгебре/геометрии и физике)'],
  #   ,...
  # }
  my $hash_subject_on_place = $refCONTEXT -> {'base_types_forms'};
  # id -- field order
  my $subject_on_place = $INFO -> {subj} -> {value};

  # Отключенная валидация
  # my $ok = 0;
  if ($hash_subject_on_place->{$subject_on_place}) {
    # Текст для email
    my $email_text = $hash_subject_on_place -> {$subject_on_place} -> [1];
    $INFO -> {subj} -> {value} = $email_text;
    # $ok = 1;
  }
  # return ($ok == 1) ? 1 : 0;
  return 1;
}

# Формируем текст правильного ответа клиенту
sub Assembly_True_Result {
  # Телефон, предмет(по которму хочет разместиться репетитор)
  my $ph            = $INFO -> {ph}   -> {value} || '';
  my $subject_place = $INFO -> {subj} -> {value} || '';
  return <<"EOF";
  Спасибо, за заказ. <br>
  Вам позвонят на номер <em> $ph </em>
  в ближайшее время. Предмет: $subject_place.
EOF

}


sub Preparation_For_Sending_Email {
  # Почтовые ящики
  my @mailboxs = ('qwertyzxcv526@gmail.com', 'marianna.repetitor@gmail.com', 'mat.repetitors@yandex.ru');
  my $subject = 'Заказали звонок '.get_time::time_email();

  my $ph            = $INFO -> {ph}   -> {value} || 'not exist phone';
  my $subject_place = $INFO -> {subj} -> {value} || 'not exist subject_place';

  foreach my $mail (@mailboxs) {
    # print "mail = $mail\n<br>";
    # print "subject = $subject\n<br>";
    # print
    # "Заказ звонка на размещение репетитора\n<br>".
    # "Телефон: ".$ph."\n<br>".
    # "Предмет: ".$subject_place."\n<br>".
    # "IP: ".env::get_ip()."\n<br><br>";

    send_mail::send_mail(
      $mail,
      $subject,
      "Заказ звонка на размещение репетитора\n".
      "Телефон: ".$ph."\n".
      "Предмет: ".$subject_place."\n".
      "IP: ".env::get_ip()."\n".
      "User-Agent: ".$ENV{HTTP_USER_AGENT}."\n"
    );
  }
  # Будем писать в логи
  # else { }

}


# Тестовая функция запуска без роутинга
sub test_start{
  $CONTEXT{'hash_cgi'}{'ph'}  = '123456789';
  $CONTEXT{'hash_cgi'}{'sub'}  = 'summary_mathematics_physics';
  $INFO = info();
  App();
}
