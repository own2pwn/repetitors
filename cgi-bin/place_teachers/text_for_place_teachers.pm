package text_for_place_teachers;
#!/usr/bin/perl
use strict;

# ТЕКСТ ДЛЯ РАЗМЕЩЕНИЯ ПРЕПОДАВАТЕЛЯ


#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  text_for_place_teachers($refCONTEXT,$key);
  # print $CONTEXT{$key}{'html'};
  # print $CONTEXT{$key}{'css'};
  # print $CONTEXT{$key}{'js'};
}




# ----------------------------------------------------- ТЕКСТ ДЛЯ РАЗМЕЩЕНИЯ ПРЕПОДАВАТЕЛЯ-------------------------------------------------------------
sub text_for_place_teachers {
  my ($refCONTEXT,$key) = @_;

  my $css_text = '
  ';

  # Таблица , в который 2 ячейки: левая это красивый заголовок, а правая это контакты
  my $html_text ="
  <h1>Репетитор разместиться</h1>
  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Saepe, modi fugit earum distinctio libero accusamus reiciendis dicta aut corporis odit sunt eius minima eos praesentium voluptatum. Ut quisquam aliquam nesciunt!</p>
  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Saepe, modi fugit earum distinctio libero accusamus reiciendis dicta aut corporis odit sunt eius minima eos praesentium voluptatum. Ut quisquam aliquam nesciunt!</p>
  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Saepe, modi fugit earum distinctio libero accusamus reiciendis dicta aut corporis odit sunt eius minima eos praesentium voluptatum. Ut quisquam aliquam nesciunt!</p>
  ";

  my $js_text ="
  ";

  my $js_text_min ='
  ';

  $js_text = ( $refCONTEXT -> {'min'} == 1 ) ? $js_text_min : $js_text;
  $refCONTEXT -> {$key} -> {'css'} = $css_text;
  $refCONTEXT -> {$key} -> {'html'} = $html_text;
  $refCONTEXT -> {$key} -> {'js'} = $js_text;
}
1;