package view_index;
#!/usr/bin/perl
use strict;

# ШАБЛОН ОТОБРАЖЕНИЯ ПЕРВОЙ СТРАНИЦЫ И СТРАНИЦ ПРЕПОДАВАТЕЛЕЙ

use lib './css';
use base_css;
use column_css;

#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  base_css::start($refCONTEXT,'base_css');
  view_index($refCONTEXT,$key);
  # print $CONTEXT{$key};
}



# ----------------------------------------------------- VIEW ПЕРВОЙ СТРАНИЦЫ И СТРАНИЦ ПРЕПОДАВАТЕЛЕЙ -------------------------------------------------------------
sub view_index {
  my ($refCONTEXT,$key) = @_;

my $teacher_id = $refCONTEXT -> {'teacher'};
my $yandex_verifycation = '';
if ($teacher_id == 1) {$yandex_verifycation = "<meta name='yandex-verification' content='5f315588ebc8a9c3' />";}

  my $data = <<"EOF";
  <!DOCTYPE html>
  <html><head>
  <meta charset=utf-8>
  $refCONTEXT->{'title'}->{html}

  $yandex_verifycation
  $refCONTEXT->{'description'}->{html}
  $refCONTEXT->{'keywords'}->{html}
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <style>

  /*Базовые стили*/
  $refCONTEXT->{'base_css'}->{css}

  /* Cтили для контактов в header и в footer*/
  .commnication_style {font-family: "Comic Sans MS",cursive;font-size: 1em;color: #5E1C1C;}
  /*Классы для заголовка "Вас приглашет Марианна Камаева и т.д." */
  .headline {font-weight:normal;font-size:120%;text-align:center;color:#5E1C1C;display:block}

  .leftimg {
    width:170px;
    float:left; /* Выравнивание по левому краю */
    margin: 7px 7px 7px 0; /* Отступы вокруг картинки */
  }

  .some_photo{width:100%}

  /* Маскируем тэг <h1> под тэг <p> */
  .mask_under_p {
    display:inline;
    text-align:justify;
    font-weight:normal;
    font-family: Arial, Helvetica, sans-serif;
    font-size: 98%;
    font-weight: bold;
  }
EOF
  # Задаем основные три колонки сайта
  $data.= column_css::column('.main_table_column_first',  'width: 18%;', 'padding: 10px 1%;');
  $data.= column_css::column('.main_table_column_second', 'width: 53%;', 'padding: 10px 1%;');
  $data.= column_css::column('.main_table_column_third',  'width: 20%;', 'padding: 10px 1%;');

  $data.= $refCONTEXT->{'header'}->{css} || '';
  $data.= $refCONTEXT->{'main_menu'}->{css} || '';
  $data.= $refCONTEXT->{'teacher_menu'}->{css} || '';
  $data.= $refCONTEXT->{'form_order_call'}->{css} || '';
  $data.= $refCONTEXT->{'links_to_teachers'}->{css} || '';
  $data.= $refCONTEXT->{'branch_price'}->{css} || '';
  $data.= $refCONTEXT->{'list_districts'}->{css} || '';
  $data.= $refCONTEXT->{'vk_comments'}->{css} || '';
  $data.= $refCONTEXT->{'footer'}->{css} || '';


$data .= <<"EOF";
    \@media screen and (max-width: 980px) {
      .logo{font-size: 340%;}
      /*Если меньше 980, то картинку All.jpg убираем*/
      .right_img{display:none!important;}

      /*Убираем третью колонку с картинкой*/
      .main_table_column_third{display:none}

      /*HEADER из двух колоночного становится одно колоночным*/
      .header_two_column{width:95%}

      /*Делаем основное тело сайта двухколоночным*/
      .main_table_column_first{width:35%}
      .main_table_column_second{width:55%}
      /*МЕНЮ в FOOTER делаем из 4 колоночного 2 колоночным*/
      .four_column{width:48%}

      /*FOOTER из двух колоночного становится одно колоночным*/
      .two_column_contact_footer{width:95%;padding: 10px 0;}
      .simple-little-table tr td:first-child{padding-left: 1%;}


    }
    \@media screen and (max-width: 640px) {
      .logo{font-size:270%}
      /*Делаем основное тело сайта одноколоночным*/
      .main_table_column_first{width:95%}
      .main_table_column_second{width:95%}

      #content{width:50%}

      /*МЕНЮ в FOOTER из двух колоночного становится одно колоночным*/
      .four_column{width:95%}
      /*Уменьшаем шрифт таблице*/
      .table_price {font-size:55%}
      /*Возможность переноса слов в email и в телефоне (HEADER,FOOTER)*/
      .two_column_contact_footer{word-break:break-all;}
      #communication{word-break:break-all;}

      img{max-width:100%!important;height:auto!important}
    }


  </style>
  </head>
EOF

$data .= <<"EOF";
  <body>
  <!-- Главный div , в который все завернуто-->
  <div style="max-width:1000px;margin:0px auto;">

    $refCONTEXT->{'header'}->{'html'}
    $refCONTEXT->{'main_menu'}->{'html'}

    <!-- Таблица , в который 3 ячейки: первая это меню, вторая  это тексты, а третья это колонка картинок -->

    <div class="main_table_column_first">
EOF
       $data.= $refCONTEXT->{'teacher_menu'}->{html};
       if ($teacher_id == 1) {
         $data.= $refCONTEXT->{'form_order_call'}->{html};
         $data.= $refCONTEXT->{links_to_teachers}->{html};
       }
       else {
        $data.= $refCONTEXT->{links_to_teachers}->{html};
        $data.= $refCONTEXT->{'form_order_call'}->{html};
       }
       $data.= $refCONTEXT->{'social_net'}->{html}
    .'</div>';
$data.= <<"EOF";
    <div class="main_table_column_second">
      $refCONTEXT->{'about_teacher'}->{html}

      $refCONTEXT->{'about_individual'}->{html}
      $refCONTEXT->{'individual_price'}->{html}
      $refCONTEXT->{'about_classroom'}->{html}
      $refCONTEXT->{'branch_price'}->{html}
      $refCONTEXT->{'about_list_districts'}->{html}
      $refCONTEXT->{'list_districts'}->{html}

      $refCONTEXT->{'ordering_works'}->{html}

      $refCONTEXT->{'contacts_filials'}->{html}
      $refCONTEXT->{'vk_comments'}->{html}

    </div>

    <div class="main_table_column_third">
      $refCONTEXT->{'column_page'}->{'html'}
    </div>

  </div>

  $refCONTEXT->{'footer'}->{'html'}

  <script>
    var D = document;
    var H = D.getElementsByTagName("head")[0];
    /*Функция рисующая бордеры для всех элементов рандомного цвета*/
     drawBorders(0);
       function drawBorders(trigger) {
         if (trigger===1) {
             [].forEach.call(document.querySelectorAll("*"),function(a){a.style.outline="2px solid #"+(~~(Math.random()*(1<<24))).toString(16)})
         }
     }
     function getByID (id) {
       return document.getElementById(id);
     }
    $refCONTEXT->{'insert_contact_js'}->{js}
    $refCONTEXT->{'form_order_call'}->{js}
    $refCONTEXT->{'header'}->{js}
    $refCONTEXT->{'main_menu'}->{js}
    $refCONTEXT->{'contacts_filials'}->{js}
    $refCONTEXT->{'insert_cookieks'}->{js}
  </script>

EOF
  $data .= ($refCONTEXT->{api_js} == 1) ? $refCONTEXT->{'vk_comments'}->{js} : '';
  $data .= ($refCONTEXT->{api_js} == 1) ? $refCONTEXT->{'metrica_analytics_js'}->{js} : '';

  $data .= '</body>';

# $refCONTEXT->{'metrica_analytics_js'}->{js}

  $refCONTEXT -> {$key} = $data;

}
1;