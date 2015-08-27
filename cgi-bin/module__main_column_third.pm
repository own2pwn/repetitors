package module__main_column_third;
use strict;

# FOOTER СКРИПТА ПРЕПОДАВАТЕЛЯ

# my %CONTEXT = ('min' => 1);
# start(\%CONTEXT,'footer');

#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  main_table_column_third($refCONTEXT,$key);
  # print $CONTEXT{$key}{html};
  # print $CONTEXT{$key}{css};
  # print $CONTEXT{$key}{js};
}




# ----------------------------------------------------- ТРЕТЬЯ КОЛОНКА САЙТА с общей для всех картинкой -------------------------------------------------------------
sub main_table_column_third {
  my ($refCONTEXT,$key) = @_;

  my $css_main_table_column_third = '
  ';

  my $html_main_table_column_third =<<"EOF";
  <img class=right_img style="width:100%;display:block;border-radius:10px 10px 0 0;" alt="" src="$refCONTEXT->{domain}/All.jpg">
  <img class=right_img style="width:100%;display:block;border-radius:0 0 10px 10px;" alt="" src="$refCONTEXT->{domain}/All.jpg">
EOF

  my $js_main_table_column_third ='
  ';

  my $js_main_table_column_third_min ='
  ';
  $js_main_table_column_third = ( $refCONTEXT -> {'min'} == 1 ) ? $js_main_table_column_third_min : $js_main_table_column_third;
  $refCONTEXT -> {$key} -> {'css'} = $css_main_table_column_third;
  $refCONTEXT -> {$key} -> {'html'} = $html_main_table_column_third;
  $refCONTEXT -> {$key} -> {'js'} = $js_main_table_column_third;
}
1;