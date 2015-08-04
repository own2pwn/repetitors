package column_css;
#!/usr/bin/perl
use strict;
use 5.010;
use Data::Dumper;
# СОБИРАЕМ КОЛОНКИ CSS




# print column('.main_table_column_first',  'width: 18%;', 'padding: 10px 1%;');

# ----------------------------------------------------- СОБИРАЕМ КОЛОНКИ CSS -------------------------------------------------------------
sub column {
  my ($column_name, $width, $padding) = @_;

  my $css_column_css = "
  $column_name\{
    display: inline-block;
    vertical-align: top;
    $width
    $padding
  \}
  ";

  return $css_column_css;

}

# print column_with_param('.main_table_column_first',  'width: 18%;', 'padding: 10px 1%;', ['margin: 5px auto 35px auto;','/*border: 2px solid red;*/']);


# ----------------------------------------------------- СОБИРАЕМ КОЛОНКИ CSS (с передачей дополнительных параметров) -------------------------------------------------------------
sub column_with_param {
  my ($column_name, $width, $padding, $other_param) = @_;

  my $str_other_param = '';
  # это массив
  if ($other_param) {
    # foreach my $e (keys @$other_param) {
    foreach my $e (0..$#$other_param) {
      $str_other_param .= $other_param -> [$e];
    }
  }

  my $css_column_css = "
  $column_name\{
    display: inline-block;
    vertical-align: top;
    $width
    $padding
    $str_other_param
  \}
  ";

  return $css_column_css;

}
1;