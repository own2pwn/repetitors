#!/usr/bin/perl
use strict;
# use lib '/home/andrey7/www/mat-repetitor.ru/cgi-bin/moduls'; ### Для сервера

# ДАННЫЙ СКРИПТ ПОЛУЧАЕТ ПАРАМЕТРЫ ИЗ URL TEACHER_ID, REGION, PH(ТЕЛЕФОН). ДЕЛЕТ РОУТИНГ, А ЗАТЕМ ПРОВЕРКУ
# ПРАВИЛЬНОСТИ ИМЕНИ РЕГИОНА, НАЛИЧИЯ ИМЕНИ У РЕПЕТИТОРА, ВАЛИДНОСТИ ТЕЛЕФОНА.
# EMAIL НЕ ПОСЫЛАЕМ ТОЛЬКО В СЛУЧАЕ НЕ ВАЛИДНОСТИ ТЕЛЕФОНА

use CGI;

use lib './';
use config;
my $c = config::settings();


# TODO: Разбить на модули данный скрипт!!!
use base_teachers;
use module__metrica_analytics_js;

use view_order_call;

use lib './css/';
use module__button_main_page;

use lib './my/';
use cgi_url;
use http;
use get_time;
use send_mail;
use collapse;

my %CONTEXT = ('min' => 0, config => $c, collapse => $c->{collapse} );
base_teachers::start(\%CONTEXT,'base_teachers');


$CONTEXT{'hash_cgi'} = cgi_url::CGI_hash();
$CONTEXT{'formed_url'} = cgi_url::proccesing_url_keys($CONTEXT{'hash_cgi'});

Routing();
# test_start();


sub Routing {
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
    http::redirect(302,$c->{domen});
  }
  # Есть параметры в URL
  else {
    $cur_url = '?'.$ENV{'QUERY_STRING'};
    if ( $formed_url eq $cur_url ) {
      if ( $teacher_id < 1) {
        http::redirect(301,$c->{domen});
      }
      elsif (!$CONTEXT{'base_teachers'} -> {$teacher_id} || $region eq '' || $ph eq '') {
        http::redirect(302,$c->{domen});
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
      http::redirect(302,$c->{domen}.'cgi-bin/order_call_3.pl'.$formed_url);
    }
  }

}


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
  my $teacher_id = $refCONTEXT -> {'teacher_id'};
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
  my $teacher_id = $refCONTEXT -> {'teacher_id'};
  my $region_url = $refCONTEXT -> {'region'};
  my $ph = $refCONTEXT -> {'ph'};

  my $ref_info_teacher = $refCONTEXT->{'base_teachers'} -> {$teacher_id};

  # {'Репетитор в таком-то регионе' => ['имя input и value регион','текст для email'], }
  my $ref_key_regions = $ref_info_teacher -> {'key_regions'};
  my $region_text_email = '';
  foreach my $region (keys %$ref_key_regions) {
    my $field_name = $ref_key_regions -> {$region} -> [0];
    if ($field_name eq $region_url) {
      # Текст для email
      my $email_text = $ref_key_regions -> {$region} -> [1];
      $region_text_email = $email_text;
    }
  }
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
  my $ph = $refCONTEXT->{'ph'};
  if ($ph!~/[\d\-\+()]+/i) {
    $refCONTEXT -> {'correctness_data'} = 'phone_isnot_right';
  }
}

# Формируем текст ответа клиенту
sub Assembly_Html {
  my $refCONTEXT = shift;

  # HTML
  my $data = '';
  # Телефон, имя преподавателя, название региона
  my $ph = $refCONTEXT->{'ph'};
  my $teacher_text_email = $refCONTEXT->{'teacher_text_email'};
  my $region_text_email = $refCONTEXT->{'region_text_email'};
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
  my @mailboxs = ('qwertyzxcv526@gmail.com', 'marianna.repetitor@gmail.com');
  my $subject = 'Заказали звонок '.get_time::time_email();

  my $teacher_text = $refCONTEXT -> {'teacher_text_email'};
  my $phone = $refCONTEXT -> {'ph'};
  my $region_text = $refCONTEXT -> {'region_text_email'};

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
  my %hash_buld;
  $hash_buld{'teacher'} = $refCONTEXT -> {'hash_cgi'} -> {'teacher'};
  return $c -> {domen}.cgi_url::proccesing_url_keys(\%hash_buld);
}


# Тестовая функция запуска без роутинга
sub test_start{
  $CONTEXT{'teacher_id'} = int(CGI::param("teacher"));
  $CONTEXT{'region'} = CGI::param("region");
  $CONTEXT{'ph'} = CGI::param("ph");
  App();
}
