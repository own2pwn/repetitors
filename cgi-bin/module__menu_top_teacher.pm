package module__menu_top_teacher;
#!/usr/bin/perl
use strict;

# МЕНЮ ДЛЯ НАВГАЦИИ ПО СТРАНИЦЕ ПРЕПОДАВАТЕЛЯ

#########################
sub start {
  my ($refCONTEXT,$key) = @_;

  menu_top_teacher($refCONTEXT,$key);
  # print $CONTEXT{$key}{'html'};
  # print $CONTEXT{$key}{'css'};
  # print $CONTEXT{$key}{'js'};
}



# ----------------------------------------------------- МЕНЮ ДЛЯ НАВГАЦИИ ПО СТРАНИЦЕ ПРЕПОДАВАТЕЛЯ -------------------------------------------------------------
sub menu_top_teacher {
  my ($refCONTEXT,$key) = @_;

  my %hash_teach = %{$refCONTEXT -> {'base_teachers'}};
  my $teacher_id = $refCONTEXT -> {'teacher'};

  my @teacher_menu = @{$hash_teach{$teacher_id} -> {'teacher_menu'}};
  my $html_menu =<<"EOF";
    <span style='font-family:Comic Sans MS,Helvetica,cursive;font-size: 85%;'>Навигация:</span>
    <div id=menu>\n
EOF
  # old link в виде li(не кликался весь блок)
  # foreach my $el_menu (@teacher_menu) {
  #   my $text_menu = $el_menu->[0];
  #   my $link_menu = $el_menu->[1];
  #   $html_menu.="<li><a href='$link_menu'>$text_menu</a></li>\n";
  # }

 # TODO: убрать лишний код (css, html избавиться от ul,
 # заменить его на div)

 # new в виде display:block <a>(кликается весь блок)
 foreach my $el_menu (@teacher_menu) {
    my $text_menu = $el_menu->[0];
    my $link_menu = $el_menu->[1];
    $html_menu.="<a href='$link_menu'>$text_menu</a>\n";
  }
  $html_menu.= "</div>\n";
  # print "$html_menu\n";
  # exit;

  # new в виде display:block <a>(кликается весь блок)
  my $css_menu = '
   #content { /*элемент с идентификатором content - наш блок*/
     width: 100%; /*ширина содержательной части элемента*/
     margin: 0 auto; /*внешние отступы 0, браузер сам определяет значение отступа*/
  }

  #menu { /*элемент с идентификатором menu - наш список*/
     margin: 1em auto 0 auto; /*внешние отступы сверху, справа, снизу, слева*/
  }

  #menu a { /*элемент li элемента с идентификатором menu*/
     display: block;
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

  #menu a:hover { /*элемент li элемента с идентификатором menu при наведении курсора*/
     margin-left: -1em; /*внешние отступы слева*/
     margin-right: 1em; /*внешние отступы справа*/
     background: #fff; /*цвет фоновой заливки*/
     box-shadow: 0px 0px 10px rgba(0,0,0, .3); /*эффект тени элементу - параметры*/
  }
  ';

  # old css old link в виде li(не кликался весь блок)
  # my $css_menu = '
  #  #content { /*элемент с идентификатором content - наш блок*/
  #    width: 100%; /*ширина содержательной части элемента*/
  #    margin: 0 auto; /*внешние отступы 0, браузер сам определяет значение отступа*/
  # }

  # #menu { /*элемент с идентификатором menu - наш список*/
  #    margin: 1em auto 0 auto; /*внешние отступы сверху, справа, снизу, слева*/
  # }

  # #menu li { /*элемент li элемента с идентификатором menu*/
  #    list-style-type: none; /*задаем стиль отображения маркеров или нумерации для элементов списка - отобразить без маркера*/
  #    margin: 0 0 5px; /*внешние отступы сверху, справа-слева, снизу*/
  #    font-size: 15px; /*размер шрифта*/
  #    background: #ccc; /*цвет фоновой заливки*/
  #    padding: 10px 9%; /*внутренние отступы все*/
  #    -webkit-box-shadow: inset 0px 0px 10px rgba(0,0,0, .3); /*расширения для браузеров эффект тени*/
  #    -moz-box-shadow: inset 0px 0px 10px rgba(0,0,0, .3);
  #    box-shadow: inset 0px 0px 10px rgba(0,0,0, .3); /*эффект тени элементу - внутренняя, параметры*/
  #    -webkit-transition: .2s ease-in-out; /*расширения для браузеров, свойство, к изменению которого будет применен плавный переход, время, в течение которого этот переход будет совершаться, способ расчета промежуточных значений перехода и задержку перед переходом*/
  #    -moz-transition: .2s ease-in-out;
  #    -o-transition: .2s ease-in-out;
  # }


  # #menu a, #menu a:visited { /*ссылка, ссылка посещенная*/
  #    color: #194d3b ; /*цвет #444*/
  #    text-decoration: none; /*подчеркивание отсутствует*/
  # }

  # #menu li:hover { /*элемент li элемента с идентификатором menu при наведении курсора*/
  #    margin-left: -1em; /*внешние отступы слева*/
  #    margin-right: 1em; /*внешние отступы справа*/
  #    background: #fff; /*цвет фоновой заливки*/
  #    box-shadow: 0px 0px 10px rgba(0,0,0, .3); /*эффект тени элементу - параметры*/
  # }
  # ';

  my $js_menu ="
  ";

  my $js_menu_min ='
  ';
  $js_menu = ( $refCONTEXT -> {'min'} == 1 ) ? $js_menu_min : $js_menu;
  $refCONTEXT -> {$key} -> {'css'} = $css_menu;
  $refCONTEXT -> {$key} -> {'html'} = $html_menu;
  $refCONTEXT -> {$key} -> {'js'} = $js_menu;
}
1;