package module__h_menu;
#!/usr/bin/perl
# use 5.010;
use strict;
# use Data::Dumper;

# ОСНОВНОЕ МЕНЮ

# TODO: Разбить на модули в дальнейшем
# TODO: поменть a на span в меню для 2 пункта
# TODO: добавить стили для на span

#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  assembly_links_teachers_for_js($refCONTEXT);
  menu($refCONTEXT,$key);
  # print $CONTEXT{$key}{'html'};
  # print $CONTEXT{$key}{'css'};
  # print $CONTEXT{$key}{'js'};
}

sub assembly_links_teachers_for_js {
  my $refCONTEXT = shift;

  my $count_subj = 0;

  # Счетчик добавление (не больше 2)
  $refCONTEXT -> {'count_add'} = 0;

  $refCONTEXT ->{'pr_list_links_teacher'} = [];

  Pr_list_links_teacher($refCONTEXT, 'pr_list_links_teacher');
  # print Dumper($refCONTEXT ->{'pr_list_links_teacher'});
  # exit;
  if ( $refCONTEXT -> {'count_add'} < 2 ) {
    Not_pr_list_links_teacher($refCONTEXT, 'pr_list_links_teacher');
  }
  # say Dumper($refCONTEXT -> {'pr_list_links_teacher'});

  # say View_js_ar_links_to_teachers($refCONTEXT, 'pr_list_links_teacher');
  $refCONTEXT -> {'js_ar_links_teacher'} = View_js_ar_links_to_teachers($refCONTEXT, 'pr_list_links_teacher');
  # say $refCONTEXT -> {'js_ar_links_teacher'};

  # exit;
}

# Собираем приоритетных по предмету преподавателей
sub Pr_list_links_teacher {
  my ($refCONTEXT, $key) = @_;
  push_ar_list($refCONTEXT,$key);
}

# Собираем менее приоритетных преподавателей
# TODO: получать subjects из модуля base_subjects.pm
sub Not_pr_list_links_teacher {
  my ($refCONTEXT, $key) = @_;
  my @subjects = ('mathematics', 'russian_language', 'english_language');

  my $hash_teach_links = $refCONTEXT -> {'base_links_to_teachers'} || {};
  my $teacher_id       = $refCONTEXT -> {'teacher'};

  foreach my $sub (@subjects) {
    next if $sub eq $hash_teach_links -> {$teacher_id} -> {subject};
    $hash_teach_links -> {$teacher_id} -> {subject} = $sub;
    push_ar_list($refCONTEXT,$key);
  }

}

# Добавляем в массив подходящих по условию преподавателей
sub push_ar_list {
  my ($refCONTEXT, $key) = @_;
  # my ($ar_links_to_teachers, $count_add ) = @_;
  my $ar_links_to_teachers = $refCONTEXT -> {$key};
  my $count_add            = $refCONTEXT -> {'count_add'};
  my $hash_teach_links     = $refCONTEXT -> {'base_links_to_teachers'};
  my $teacher_id           = $refCONTEXT -> {'teacher'};
  my $subject = $hash_teach_links -> {$teacher_id} -> {subject} || '';

  foreach my $id (keys %$hash_teach_links) {
    next if $id == $teacher_id;
    last if $count_add >= 2; # Не больше двух преподвателей
    my $cur_teach_title   = $hash_teach_links -> {$id} -> {title}   || '';
    my $cur_teach_subject = $hash_teach_links -> {$id} -> {subject} || '';

    if ($cur_teach_title && $subject && $subject eq $cur_teach_subject) {
      my $teacher_link = build_path::build_path_to_teacher_page($refCONTEXT->{domain},$id);
      my $teacher_title = $hash_teach_links->{$id}->{title};
      push(@$ar_links_to_teachers, [$teacher_title,$teacher_link]);
      $count_add++;
    }
  }
  $refCONTEXT -> {'count_add'} = $count_add;
  $refCONTEXT ->{$key} = $ar_links_to_teachers;
}


sub View_js_ar_links_to_teachers {
  my ($refCONTEXT, $key) = @_;
  my $js_ar_links_to_teachers = 'var list_links_teachers = [';

  foreach my $e (@{$refCONTEXT->{$key}}) {
    my $teacher_title = $e -> [0];
    my $teacher_link = $e -> [1];
    $js_ar_links_to_teachers .= "
      ['$teacher_title','$teacher_link'],
    ";

  }
  return $js_ar_links_to_teachers .= ']';
  # return $js_ar_links_to_teachers;
}




# ----------------------------------------------------- МЕНЮ ДЛЯ САЙТА -------------------------------------------------------------
sub menu {
  my ($refCONTEXT,$key) = @_;


  my $html_menu =<<"EOF";
  <div class=main_table_column_h_menu>
    <ul id='h_menu' class=h_menu>

      <li>
        <a id=h_menu_item_1_show class=h_menu_links href="#">Репетиторы</a>
      </li>

      <li>
        <a id=h_menu_item_2_show class=h_menu_links href="#">Разместить резюме репетитора</a>
      </li>

    </ul>
  </div>
EOF

# СТАРЫЙ КОД ДЛЯ КРЕСТИКА
# .cross{
#   font-size: 200%;
#   line-height: .5;
#   width: 2%;
#   margin: 2px 2% 2px 97%;
#   cursor: pointer;
#   color: #666;
#   /*border: 2px solid brown;*/
# }

  my $css_menu = column_css::column_with_param('.main_table_column_h_menu',
                                                'width: 96%;',
                                                'padding: 10px 1%;',
                                                ['margin: 5px auto 35px auto;','/*border: 2px solid red;*/']);
  $css_menu .= '

  .h_menu {
      position:relative;
      margin: 0 auto;
      width: 70%;
      text-align: center;
      line-height: 50px;
      border-radius: 10px;
      background: #128F9A;
      background-image: linear-gradient(to left bottom, #4EC9D4 0%, #128F9A 100%);

      -webkit-box-shadow:0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;
      -moz-box-shadow:0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;
           box-shadow:0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;
      -webkit-box-shadow: 0 15px 10px -10px rgba(0, 0, 0, 0.5), 0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;
      -moz-box-shadow: 0 15px 10px -10px rgba(0, 0, 0, 0.5), 0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;
           box-shadow: 0 15px 10px -10px rgba(0, 0, 0, 0.5), 0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;
  }

  .h_menu ul{
    padding:0;
    margin:0;
    border-radius: 6px;
    border: 1px solid #0e7079;
  }
  .h_menu li{
    display:inline-block;
    list-style:none;
    margin: 5px 2%;
    /*border: 3px solid brown;*/
  }

  /*Ссылки <a> в ul оформляем*/
  .h_menu_links{
    padding:5px 10px;
    color:#fff;
    text-decoration:none;
    border-bottom: 1px solid #fff;
    border-radius: 0 0 7px 7px;
  }

  .h_menu_links:hover{
    background: #138791;
    color: #eee;
    border-radius: 10px;
    border-bottom: 0 solid #138791;
  }

  /*Всплывающий блок и треугольник(стрелка)*/
  .pop_up {
    position:absolute;
    box-shadow: 11px 11px 24px 0px rgba(50, 50, 50, 0.75);
    border: 2px solid #168D98;
    border-radius: 10px;
    background:#fff;
    top: 78px;
    font-size: 80%;
    max-width: 600px;
  }

  .triangle {
    position:absolute;
    width: 0;
    height: 0;
    border-left: 13px solid transparent;
    border-right: 13px solid transparent;
    border-bottom: 13px solid #168D98;
    margin-top: 10px;
    margin-left: 12px;
  }

  /*Крестик и тексты внутри всплывающего блока*/
  .cross{
    float:right;
    width:4%;
    text-align:center;
    margin-right:-5px;
    margin-top:-5px;
    line-height:1;
    color:#666;
    cursor:pointer;
    font-size: 200%;
    /*border: 2px solid brown;*/
  }

  .h_menu_links_teachers p{
    padding: 0 2%;
    margin: 10px auto;
    text-align: justify;
    line-height: 2;
    /*border: 2px solid black*/
  }

  .h_menu_links_teachers a{
    font-size: 95%;
    font-weight: 100;
    color: #33f;
    text-shadow: none;
    text-decoration:underline
  }
  .h_menu_links_teachers a:hover{color:#CC3366;}
  ';

  my $all_teachers_link =
  build_path::teachers_subjects($refCONTEXT->{domain},'all').'#teachers_by_subject';

  # Perl вставляет массив ссылок на преподавателей
  my $js_menu =<<"EOF";
  (function() {

    $refCONTEXT->{'js_ar_links_teacher'},

    itemId = {'item_1_PopUp' : false, 'item_2_PopUp' : false };

    getByID('h_menu').onclick = function(e) {
      var t = e && e.target || e.srcElement,m;
      while(t && !t.id){t=t.parentNode;}
      if (t.id) {
        m = t.id.match(/(h_menu_item_(\\d+)_(\\S+))/);
        if (m && m[1] && m[2] && m[3]) {
          var numId = parseInt(m[2],10);
          var textAfterId = m[3];
          ShowOrHide(textAfterId, m[1], numId);
        }
      }
    };

    function ShowOrHide (textAfterId, id, numId) {
      if (textAfterId === 'show') {
        Repay_Included(numId);
        var k = 'item_' + numId + '_PopUp',
        countPopUp = itemId[k];
        if (countPopUp === false) {
          (numId === 1) ? Insert_Html(assembly_links_teachers(),numId) :
          Insert_Html(assembly_warnings(),numId);
          itemId[k] = true;
          itemId['item_' + numId] = 'on';
        }
        else {
          (itemId['item_' + numId] === 'on') ? Hide(numId) : Show(numId);
        }
      }
      else if (textAfterId === 'hide') {
        Hide(numId);
      }
    }

    function Repay_Included (numId) {
      for (var it in itemId) {
        if (itemId[it] === 'on') {
          it = parseInt(it.replace('item_',''),10);
          (it === numId) ? {} : Hide(it);
        }
      }
    }

    function Show (numId) {
      getByID('h_menu_item_' + numId + '_triangle').style.display = 'block';
      getByID('h_menu_item_' + numId + '_pop_up').style.display = 'block';
      itemId['item_' + numId] = 'on';
    }

    function Hide (numId) {
      getByID('h_menu_item_' + numId + '_triangle').style.display = 'none';
      getByID('h_menu_item_' + numId + '_pop_up').style.display = 'none';
      itemId['item_' + numId] = 'off';
    }


    function Insert_Html(strIn, numId){
      var html ="<div id='h_menu_item_" + numId + "_triangle' class=triangle></div>\\
      <div id='h_menu_item_" + numId + "_pop_up'  class='pop_up h_menu_links_teachers'>\\
        <div id='h_menu_item_" + numId + "_hide' class=cross>&times;</div>" +
        strIn +
      "</div>";
      getByID('h_menu_item_' + numId + '_show').insertAdjacentHTML('beforeEnd', html);
    }

    function assembly_links_teachers() {
      var strIn = '';
      for (var i = 0, l = list_links_teachers.length; i < l; i++) {
        var text = list_links_teachers[i][0];
        var link = list_links_teachers[i][1];
        strIn += '<p><a href="' + link + '">' + text + '</a></p>';
      }
      strIn += '<a style="color:#CC3366;white-space:nowrap;" href="$all_teachers_link">Все репетиторы &#8594;</a>';
      return strIn;
    }

    function assembly_warnings() {
      return "<p>\\
               <span style='color:black;font-style:italic'>Извините, данная возможность в ближайшее время будет доступна!</span>\\
              </p>";
    }
  }());

EOF

  my $js_menu_min =<<"EOF";
EOF

  $js_menu = ( $refCONTEXT -> {'min'} == 1 ) ? $js_menu_min : $js_menu;
  $refCONTEXT -> {$key} -> {'css'} = $css_menu;
  $refCONTEXT -> {$key} -> {'html'} = $html_menu;
  $refCONTEXT -> {$key} -> {'js'} = $js_menu;
}
1;