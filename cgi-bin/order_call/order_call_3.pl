#!/usr/bin/perl
use strict;
# use lib '/home/andrey7/www/mat-repetitor.ru/cgi-bin/moduls'; ### Для сервера

# ДАННЫЙ СКРИПТ ПОЛУЧАЕТ ПАРАМЕТРЫ ИЗ URL TEACHER_ID, REGION, PH(ТЕЛЕФОН). ДЕЛЕТ РОУТИНГ, А ЗАТЕМ ПРОВЕРКУ
# ПРАВИЛЬНОСТИ ИМЕНИ РЕГИОНА, НАЛИЧИЯ ИМЕНИ У РЕПЕТИТОРА, ВАЛИДНОСТИ ТЕЛЕФОНА.
# EMAIL НЕ ПОСЫЛАЕМ ТОЛЬКО В СЛУЧАЕ НЕ ВАЛИДНОСТИ ТЕЛЕФОНА

use CGI;

use lib '../';
use config;
my $c = config::settings();


# TODO: ПЕРЕПИСАТЬ В БУДУЩЕМ ПО АНАЛОГИИ С ORDER_CALL_PLACE_TEACHERS.PL
use base_teachers;
use module__metrica_analytics_js;



use lib '../css/';
use module__button_main_page;

use lib '../my/';
use cgi_url;
use http;
use get_time;
use send_mail;
use collapse;
use wf;
use md5;
use cookies;
use check;

use lib './';
use routing_order_call;
use view_order_call;

my %CONTEXT = ('min' => 0, config => $c, collapse => $c->{collapse}, domain => $c -> {domain} );
base_teachers::start(\%CONTEXT,'base_teachers');


$CONTEXT{'hash_cgi'} = cgi_url::CGI_hash();
$CONTEXT{'formed_url'} = cgi_url::proccesing_url_keys($CONTEXT{'hash_cgi'});

$CONTEXT{App} = \&App;
routing_order_call::start(\%CONTEXT);
# test_start();




sub App {
                      print http::header();

                      Validate_Teacher_Name(\%CONTEXT);
                      Validate_Region_Name(\%CONTEXT);
                      Validate_Phone(\%CONTEXT);
                      Assembly_Html(\%CONTEXT);
                      Preparation_For_Sending_Email(\%CONTEXT);

                      $CONTEXT{'path_to_teacher_page'} = build_path_to_teacher_page(\%CONTEXT);
                      module__button_main_page::start(\%CONTEXT,'button_main_page');
                      module__metrica_analytics_js::start(\%CONTEXT,'metrica_analytics_js');

                      view_order_call::start(\%CONTEXT,'view_order_call');

                      print collapse::simple_collapse(\%CONTEXT,$CONTEXT{'view_order_call'});
}

# Нашли у преподавателя полное имя и ввели счетчик ошибок для валидации телефона
# и в случае отсуствия у преподавател имени и неправильного региона
sub Validate_Teacher_Name {
  my $refCONTEXT = shift;
  my $teacher_id = cgi_url::decode($refCONTEXT -> {'teacher'});
  # Счетчик валидации телефона
  # ok –– все правильно, phone_isnot_right –– ошибка в телефоне
  $refCONTEXT -> {'correctness_data'} = 'ok';
  # Счетчик правильности получения данных 0 - ошибок нет, 1 - ошибка есть
  $refCONTEXT -> {'count_error'} = 0;

  my $ref_info_teacher = $refCONTEXT->{'base_teachers'} -> {$teacher_id};
  my $teacher_text_email = '';

  if ($ref_info_teacher -> {'rusFullName'}) {
    $teacher_text_email = $ref_info_teacher -> {'rusFullName'};
  }
  else {
    $teacher_text_email = "Имя преподавателя не определено (нет поля rusFullName). ID: $teacher_id\n";
    $refCONTEXT -> {'count_error'} = 1;
  }

  $refCONTEXT -> {'teacher_text_email'} = $teacher_text_email;
}

# Проверка наличия у преподавателя названия региона
sub Validate_Region_Name {
  my $refCONTEXT = shift;
  my $teacher_id = cgi_url::decode($refCONTEXT -> {'teacher'});
  my $region_url = cgi_url::decode($refCONTEXT -> {'region'});
  my $ph         = cgi_url::decode($refCONTEXT -> {'ph'});

  my $ref_info_teacher = $refCONTEXT->{'base_teachers'} -> {$teacher_id};

  # {'Репетитор в таком-то регионе' => ['имя input и value регион','текст для email'], }
  my $ref_key_regions = $ref_info_teacher -> {'key_regions'}  || {};
  # my $sort_key_regions = $hash_teach -> {$teacher_id} -> {'key_regions_sort_order'} || [];
  my $region_text_email = '';
  if ($ref_key_regions->{$region_url}){
    $region_text_email = $ref_key_regions->{$region_url}->[1];
  }
  # foreach my $region (keys %$ref_key_regions) {
  #   my $field_name = $ref_key_regions -> {$region} -> [0];
  #   if ($field_name eq $region_url) {
  #     # Текст для email
  #     my $email_text = $ref_key_regions -> {$region} -> [1];
  #     $region_text_email = $email_text;
  #   }
  # }
  if ($region_text_email eq '') {
    $region_text_email = "Название региона не определено(в базе ни одно поле не совпало с таким регионом). ID: $teacher_id\n";
    $refCONTEXT -> {'count_error'} = 1;
  }
  $refCONTEXT -> {'region_text_email'} = $region_text_email;

  # print "Имя продавателя: $teacher_name\n <br>";
  # print "Название региона: $region_text_email<br>\n";

}

sub Validate_Phone {
  my $refCONTEXT = shift;
  my $ph = cgi_url::decode($refCONTEXT->{'ph'});
  if ($ph!~/[\d\-\+()]{9,}/i) {
    $refCONTEXT -> {'correctness_data'} = 'phone_isnot_right';
  }
}

# Формируем текст ответа клиенту
sub Assembly_Html {
  my $refCONTEXT = shift;

  # HTML
  my $data = '';
  # Телефон, имя преподавателя, название региона
  my $ph                 = cgi_url::decode($refCONTEXT->{'ph'});
  my $teacher_text_email = cgi_url::decode($refCONTEXT->{'teacher_text_email'});
  my $region_text_email  = cgi_url::decode($refCONTEXT->{'region_text_email'});
  if ($refCONTEXT -> {'correctness_data'} eq 'ok') {
    $data= <<"EOF";
    Спасибо, за заказ. <br>
    Вам позвонят на номер <em> $ph </em>
    в ближайшее время. Преподаватель: $teacher_text_email, $region_text_email.
EOF
  }
  else {
    $refCONTEXT -> {'correctness_data'} = 'phone_isnot_right';
    $data = <<"EOF";
    Вы ввели неверную информацию. Попробуйте ввести еще раз телефон.
    Например  в таком формате: <em> +7(906)1234567 </em>
    или <em> 89061234567 </em>
EOF
  }

  if ( $refCONTEXT -> {'count_error'} == 1){
    $data = <<"EOF";
    Вы ввели неверную информацию. Попробуйте ввести еще раз телефон на странице преподавателя.
    Отсутствует регион или преподаватель.
EOF
    }

  $refCONTEXT -> {'solve_client'} -> {html} = $data;

}

# В случае, если телефон валиден отсылаем email,
# даже если отсуствует имя преподавателя и название региона
sub Preparation_For_Sending_Email {
  my $refCONTEXT = shift;
  # Почтовые ящики
  my @mailboxs = ('qwertyzxcv526@gmail.com', 'marianna.repetitor@gmail.com', 'mat.repetitors@yandex.ru');
  my $subject = 'Заказали звонок '.get_time::time_email();

  my $teacher_text = cgi_url::decode($refCONTEXT -> {'teacher_text_email'});
  my $phone        = cgi_url::decode($refCONTEXT -> {'ph'});
  my $region_text  = cgi_url::decode($refCONTEXT -> {'region_text_email'});

  # Если все правильно или случилась ошибка данных, то отсылаем данные на email,
  # в случае неверного телефона введенного пользователем делаем запись в логи
  if ($refCONTEXT -> {'correctness_data'} eq 'ok') {
    foreach my $mail (@mailboxs) {
      # print ($mail,$subject,"Заказ звонка \n Телефон:".$phone."\n Регион:".$region);
      # print "<p>".$mail.$subject."Заказ звонка \n Телефон:".$phone.
      # "\n Преподаватель: ".$teacher_text."\n Регион: ".$region_text."</p>\n";
      send_mail::send_mail(
        $mail,
        $subject,
        "Заказ звонка \n Телефон: ".$phone."\n Преподаватель: ".$teacher_text."\n Регион: ".$region_text."\n"
      );
    }
  }
  # Будем писать в логи
  # else { }

}

# Строим путь к странице преподавателя: для кнокпки Вернуться на страницу преподавателя и refresh через 30 сек
sub build_path_to_teacher_page {
  my $refCONTEXT = shift;
  return $c -> {domain}.cgi_url::proccesing_url_keys({'action' => 'teacher', 'id' => $refCONTEXT->{'teacher'}},'&amp;');
}


# Тестовая функция запуска без роутинга
sub test_start{
  $CONTEXT{'teacher'} = int(CGI::param("id"));
  $CONTEXT{'region'} = CGI::param("region");
  $CONTEXT{'ph'} = CGI::param("ph");
  App();
}
