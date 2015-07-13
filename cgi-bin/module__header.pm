package module__header;
#!/usr/bin/perl
use strict;

# HEADER СКРИПТА ПРЕПОДАВАТЕЛЯ


#########################
sub start {
  my ($refCONTEXT,$key) = @_;

  my %hash_teach = %{$refCONTEXT -> {'base_teachers'}};
  my $teacher_id = $refCONTEXT -> {'teacher_id'};
  my $name = ($hash_teach{$teacher_id} && $hash_teach{$teacher_id} -> {'name'}) ? $hash_teach{$teacher_id} -> {'name'} : 'Mat';
  $refCONTEXT -> {'start_logo'} = $name;
  header($refCONTEXT,$key);
  # print $CONTEXT{$key}{'html'};
  # print $CONTEXT{$key}{'css'};
  # print $CONTEXT{$key}{'js'};
}




# ----------------------------------------------------- HEADER -------------------------------------------------------------
sub header {
  my ($refCONTEXT,$key) = @_;

  my $css_header = '
  /* Google-шрифт для символа заголовка в левом верхнем углу Marianna-repetitor */
  .logo{ font-family: \'Tangerine\', serif; font-size: 440%; text-shadow: 4px 4px 4px #aaa;}
  .header_two_column{
      display: inline-block;
      width: 48%;
      padding: 10px 0.5%;
      vertical-align: top;
      /*background-color:#F7F7F7;
      border-radius:15px;*/
  }
  ';

  ## Таблица , в который 2 ячейки: левая это красивый заголовок, а правая это контакты
  my $html_header ="
  <div class=header_two_column>
    <p style='color:red;'  class='logo'>$refCONTEXT->{'start_logo'}-repetitor!</p>
  </div>
  <div  style='font-size:150%' class=header_two_column>
     <p style='text-align:right' id='communication_ph' class=commnication_style> </p>
     <p style='text-align:right' id='communication'  class=commnication_style> </p>
  </div>
  ";

  my $js_header ='
  ';

  my $js_header_min ='
  ';
  $js_header = ( $refCONTEXT -> {'min'} == 1 ) ? $js_header_min : $js_header;
  $refCONTEXT -> {$key} -> {'css'} = $css_header;
  $refCONTEXT -> {$key} -> {'html'} = $html_header;
  $refCONTEXT -> {$key} -> {'js'} = $js_header;
}
1;