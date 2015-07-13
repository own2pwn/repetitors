package column_css;
#!/usr/bin/perl
use strict;

# СОБИРАЕМ КОЛОНКИ CSS




# print column('.main_table_column_first',  'width: 18%;', 'padding: 10px 1%;');

# ----------------------------------------------------- СОБИРАЕМ КОЛОНКИ CSS -------------------------------------------------------------
sub column {
  my ($column_name, $width, $padding) = @_;

  my $css_column_css = "
  $column_name\{
    display: inline-block;
    $width
    $padding
    vertical-align: top;
    border-radius:15px;
  \}
  ";

  return $css_column_css;

}
1;