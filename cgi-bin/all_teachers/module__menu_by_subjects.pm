package module__menu_by_subjects;
#!/usr/bin/perl
use 5.010;
use strict;
# use Data::Dumper;

# use lib './';
# use base_links_to_teachers;

# СКРИПТ ДИНАМИЧЕСКИ СОБИРАЮЩИЙ
# ССЫЛКИ НА ПРЕПОДАВАТЕЛЕЙ ПО ОПРЕДЕЛЕННЫМ ПРЕДМЕТАМ

# my %CONTEXT = ('min' => 1, 'id' => 1);
# base_links_to_teachers::start(\%CONTEXT,'base_links_to_teachers');

# start(\%CONTEXT,'base_links_to_teachers');

# TODO: Сделать это одним модулем с модулем навигации по странице преподавателя
#       (возможно)
#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  menu_by_subjects_teachers($refCONTEXT,$key);
  # print $CONTEXT{$key}{html};
  # print $CONTEXT{$key}{css};
  # print $CONTEXT{$key}{js};
}




# ----------------------------------------------------- СОБИРАЕМ МЕНЮ ПРЕПОДАВАТЕЛИ ПО ПРЕДМЕТАМ -------------------------------------------------------------
sub menu_by_subjects_teachers {
  my ($refCONTEXT,$key) = @_;

  my $html_by_subjects_teachers = "
    <span style='font-family:Comic Sans MS,Helvetica,cursive;font-size:85%;'>Навигация:</span>
    <ul id=menu>";

  # { subject => {
  #         text =>       'Репетиторы по всем предметам',
  #         title =>      {html=>{},css=>{}},
  #         keywords =>   {html=>{},css=>{}},
  #         desription => {html=>{},css=>{}},
  #         }, ..}
  my $hash_subj = $refCONTEXT -> {'base_subjects'};
  my $sort_subj = $refCONTEXT -> {'base_subjects_sort_order'};
  my $subject   = $refCONTEXT -> {'subject'} || '';

  my $domain = $refCONTEXT -> {domain};
  # Массив вида [['Репетиторы по всем предметам', 'ссылка'],[],...],который передадим
  # в модуль module__footer_menu_by_subject.pm
  my @menu_by_subject = ();
  foreach my $subj (@$sort_subj) {
    my $one_subject = $hash_subj -> {$subj};
    if ($subj ne $subject) {
      my $subject_text = $one_subject -> {text};
      my $subject_link = build_path::teachers_subjects(
                          $domain.'/cgi-bin/all_teachers/all_teachers.pl/',
                          $subj).'#teachers_by_subject';
      $html_by_subjects_teachers.= "<li><a href='$subject_link'>$subject_text</a></li>";
      push(@menu_by_subject, [$subject_text,$subject_link]);
    }
  }
  $html_by_subjects_teachers .= '</ul>';
  $refCONTEXT->{'menu_by_subject'} = \@menu_by_subject;
  # print $html_teachers_in_subjects."\n";
  # exit;


  my $css_by_subjects_teachers = <<"EOF";
   #content { /*элемент с идентификатором content - наш блок*/
     width: 100%; /*ширина содержательной части элемента*/
     margin: 0 auto; /*внешние отступы 0, браузер сам определяет значение отступа*/
  }

  #menu { /*элемент с идентификатором menu - наш список*/
     margin: 1em auto 0 auto; /*внешние отступы сверху, справа, снизу, слева*/
  }

  #menu li { /*элемент li элемента с идентификатором menu*/
     list-style-type: none; /*задаем стиль отображения маркеров или нумерации для элементов списка - отобразить без маркера*/
     margin: 0 0 5px; /*внешние отступы сверху, справа-слева, снизу*/
     font-size: 15px; /*размер шрифта*/
     background: #ccc; /*цвет фоновой заливки*/
     padding: 10px 9%; /*внутренние отступы все*/
     -webkit-box-shadow: inset 0px 0px 10px rgba(0,0,0, .3); /*расширения для браузеров эффект тени*/
     -moz-box-shadow: inset 0px 0px 10px rgba(0,0,0, .3);
     box-shadow: inset 0px 0px 10px rgba(0,0,0, .3); /*эффект тени элементу - внутренняя, параметры*/
     -webkit-transition: .2s ease-in-out; /*расширения для браузеров, свойство, к изменению которого будет применен плавный переход, время, в течение которого этот переход будет совершаться, способ расчета промежуточных значений перехода и задержку перед переходом*/
     -moz-transition: .2s ease-in-out;
     -o-transition: .2s ease-in-out;
  }


  #menu a, #menu a:visited { /*ссылка, ссылка посещенная*/
     color: #194d3b ; /*цвет #444*/
     text-decoration: none; /*подчеркивание отсутствует*/
  }

  #menu li:hover { /*элемент li элемента с идентификатором menu при наведении курсора*/
     margin-left: -1em; /*внешние отступы слева*/
     margin-right: 1em; /*внешние отступы справа*/
     background: #fff; /*цвет фоновой заливки*/
     box-shadow: 0px 0px 10px rgba(0,0,0, .3); /*эффект тени элементу - параметры*/
  }
EOF




  my $js_by_subjects_teachers ='
  ';

  my $js_by_subjects_teachers_min ='
  ';
  $js_by_subjects_teachers = ( $refCONTEXT -> {'min'} == 1 ) ? $js_by_subjects_teachers_min : $js_by_subjects_teachers;
  $refCONTEXT -> {$key} -> {'css'} = $css_by_subjects_teachers;
  $refCONTEXT -> {$key} -> {'html'} = $html_by_subjects_teachers;
  $refCONTEXT -> {$key} -> {'js'} = $js_by_subjects_teachers;
}


1;