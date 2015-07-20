package module__table_price;
use strict;

# СКРИПТ ДИНАМИЧЕСКИ СОБИРАЮЩИЙ ТАБЛИЦУ СО СТОИМОСТЬЮ ЗАНЯТИЙ

# my %CONTEXT = ('min' => 1, 'id' => 1);
# start(\%CONTEXT,'table_price');

#########################
sub start {
  my ($refCONTEXT,$key) = @_;

  my %hash_teach = %{$refCONTEXT -> {'base_teachers'}};
  my $teacher_id = $refCONTEXT -> {'teacher'};

  if ($hash_teach{$teacher_id}) {
    my $refarray = $hash_teach{$teacher_id}->{$key};
    # print join(',',$refarray)."\n";
    $refCONTEXT -> {data} = $refarray;
    # print "OK\n";
  }
  else {
    print " NOT OK\n";
    exit;
  }
  # if ($CONTEXT{'id'} == 1) {
  #   $refCONTEXT -> {data} = [[1,2,3],[4,5,6]];
  # }
  table_price($refCONTEXT,$key);
  # print $CONTEXT{'$key'}{html};
  # print $CONTEXT{'$key'}{css};
  # print $CONTEXT{'$key'}{js};
}



# TODO: Пераработать проблему с бордерами у th
# TODO: Разбить на несколько модулей
# TODO: Сделать комментарии
# TODO: ПЕРЕПИСАТЬ ВЕСЬ CSS ДЛЯ ТАБЛИЦЫ
# ----------------------------------------------------- СОБИРАЕМ таблицу стоимости TABLE PRICE -------------------------------------------------------------
sub table_price {
  my ($refCONTEXT,$key) = @_;
  # print join(',',@{$refCONTEXT -> {data}})."\n";

  my @array = @{$refCONTEXT -> {data}};
  my $count = 0;

  # Таблица цен на услуги
  my $html_table_price ="<table class=table_price>\n";

  foreach my $el_ar (@array) {
    # print "Элементы массива данных $el_ar\n";
    $html_table_price.="<tr>\n";
    foreach my $el (@{ $el_ar }) {
      if ($count == 0) {
        $html_table_price.= "<th>$el</th>\n";
      }
      else {
        $html_table_price.= "<td>$el</td>\n"
      }
    }
  $html_table_price.="</tr>\n";
  $count = 1;
  }
  $html_table_price.="\n</table>";
  # print "$html_table_price\n";
  # exit;

  my $css_table_price ='
  .table_price {
    font-family:Arial, Helvetica, sans-serif;
    color:#666;
    font-size:80%;
    text-shadow: 1px 1px 0px #fff;
    background:#eaebec;
    margin:20px 0;
    border:#ccc 1px solid;
    border-collapse:separate;
    border-spacing:0px;

    border-radius:3px;

    box-shadow: 0 1px 2px #d1d1d1;
  }

  .table_price th {
    border-right: 1px solid #e0e0e0;
    font-weight:bold;
    padding:21px 5% 22px 5%;
    border-top:1px solid #fafafa;
    border-bottom:1px solid #e0e0e0;

    background: #ededed;
    background: -webkit-gradient(linear, left top, left bottom, from(#ededed), to(#ebebeb));
    background: -moz-linear-gradient(top,  #ededed,  #ebebeb);
  }

  .table_price th:first-child{
    text-align: left;
  }

  .table_price tr:first-child th:first-child{
    border-top-left-radius:3px;
  }

  .table_price tr:first-child th:last-child{
    border-top-right-radius:3px;
  }
  .table_price tr{
    text-align: center;
  }

  .table_price tr td:first-child{
    text-align: left;
    padding-left:10%;
    border-left: 0;
  }

  .table_price tr td {
    min-width:5%;
    padding:18px 5%;
    border-top: 1px solid #ffffff;
    border-bottom:1px solid #e0e0e0;
    border-left: 1px solid #e0e0e0;

    background: #fafafa;
    background: -webkit-gradient(linear, left top, left bottom, from(#fbfbfb), to(#fafafa));
    background: -moz-linear-gradient(top,  #fbfbfb,  #fafafa);
  }

  .table_price tr:nth-child(even) td{
    background: #f6f6f6;
    background: -webkit-gradient(linear, left top, left bottom, from(#f8f8f8), to(#f6f6f6));
    background: -moz-linear-gradient(top,  #f8f8f8,  #f6f6f6);
  }

  .table_price tr:last-child td{
    border-bottom:0;
  }

  .table_price tr:last-child td:first-child{
     border-bottom-left-radius:3px;
  }
  .table_price tr:last-child td:last-child{
     border-bottom-right-radius:3px;
  }

  .table_price tr:hover td{
    background: #f2f2f2;
    background: -webkit-gradient(linear, left top, left bottom, from(#f2f2f2), to(#f0f0f0));
    background: -moz-linear-gradient(top,  #f2f2f2,  #f0f0f0);
  }

  .table_price a:active,
  .table_price a:hover {
    color: #bd5a35;
    text-decoration:underline;
  }
  ';




  my $js_table_price ='
  ';

  my $js_table_price_min ='
  ';
  $js_table_price = ( $refCONTEXT -> {'min'} == 1 ) ? $js_table_price_min : $js_table_price;
  $refCONTEXT -> {$key} -> {'css'} = $css_table_price;
  $refCONTEXT -> {$key} -> {'html'} = $html_table_price;
  $refCONTEXT -> {$key} -> {'js'} = $js_table_price;
}
1;