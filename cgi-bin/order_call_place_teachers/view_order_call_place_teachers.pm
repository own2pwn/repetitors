package view_order_call_place_teachers;
#!/usr/bin/perl
use strict;

# ШАБЛОН ОТОБРАЖЕНИЯ СТРАНИЦЫ ЗАКАЗА ЗВОНКА




#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  base_css::start($refCONTEXT,'base_css');
  view_index($refCONTEXT,$key);
  # print $CONTEXT{$key};
}




# ----------------------------------------------------- VIEW СТРАНИЦЫ ЗАКАЗА ЗВОНКА (ДЛЯ РАЗМЕЩЕНИЯ ПРЕПОДАВАТЕЛЯ)-------------------------------------------------------------
sub view_index {
  my ($refCONTEXT,$key) = @_;

  # Путь на обратную страницу
  my $path = $refCONTEXT->{'path_to_teacher_page'} || $refCONTEXT->{'path_to_place_teachers'};

  my $data = <<"EOF";
  <!DOCTYPE html>
<html><head>

<meta charset=UTF-8>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">

<meta http-equiv="Refresh" Content="120; URL=$path">

<title>Заказ звонка</title>
  <style>

  /*Базовые стили*/
  $refCONTEXT->{'base_css'}->{css}

body {padding:10px}
p{text-align:center;}

\@import "http://webfonts.ru/import/permian.css";
/* Permian Sans, 400, 400 italic, 700 */
.indent_width {margin:20% auto;width:20%}
.text_reply{
  text-align:center;
  color: rgba(78,78,78,1);
  font-family: 'Permian Sans';font-size: 28px;
  font-weight: 400;
  line-height: 1.6em;
  width: 700px;
}

$refCONTEXT->{'button_main_page'}->{css}

</style>
</head>

  <body>
    <div class="text_reply indent_width" style="display:block">
      <p>
      $refCONTEXT->{'solve_client'}->{html}
      $refCONTEXT->{'button_main_page'}->{html}
      </p>
    </div>

  <script>

  </script>

  $refCONTEXT->{'metrica_analytics_js'}->{js}

  </body>
EOF


  $refCONTEXT -> {$key} = $data;

}
1;