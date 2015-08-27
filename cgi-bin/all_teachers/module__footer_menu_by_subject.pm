package module__footer_menu_by_subject;
use strict;
use 5.010;
use Data::Dumper;

# FOOTER с меню с преподавателями по предметам (ДЛЯ СКРИПТОВ НЕ ПРЕПОДАВАТЕЛЕЙ)

# my %CONTEXT = ('min' => 1);
# start(\%CONTEXT,'footer');

#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  footer_without_menu($refCONTEXT,$key);
  # print $CONTEXT{$key}{html};
  # print $CONTEXT{$key}{css};
  # print $CONTEXT{$key}{js};
}




# ----------------------------------------------------- FOOTER с меню с преподавателями по предметам -------------------------------------------------------------
sub footer_without_menu {
  my ($refCONTEXT,$key) = @_;

  my $css_footer = '
  .footer {width:100%;margin-top:25px;border-top:2px solid #999;padding:20px 0;text-align:center}
   .footer a {color:#777;} /*margin:0 50px;*/
   .footer a:hover {color:#f00;text-decoration:underline;}
   .footer p  {margin:30px;}
   .four_column{
       display: inline-block;
       width: 24.5%;
       /*padding: 10px 1%;*/
       vertical-align: top;
       /*border: 2px solid green;*/
   }
  .two_column_contact_footer{
      display: inline-block;
      width: 48%;
      padding: 20px 0;
      vertical-align: top;
      font-size:150%;
  }
  ';
  # Меню с преподами по предметам
  my $menu_subjects_bottom = get_menu_by_subject($refCONTEXT);

  my $html_footer ="
<div class=footer>
  $menu_subjects_bottom
  <div class='commnication_style two_column_contact_footer'> <span id='communication_m_footer'></span></div>
  <div class='commnication_style two_column_contact_footer'> <span id='communication_ph_footer'></span></div>

   <p style='font-size:80%;text-align:center'> © Copyright 2014 &mdash; 2015 </p>
</div>";

  my $js_footer ='
  ';

  my $js_footer_min ='
  ';
  $js_footer = ( $refCONTEXT -> {'min'} == 1 ) ? $js_footer_min : $js_footer;

  $refCONTEXT -> {$key} -> {css}  = $css_footer;
  $refCONTEXT -> {$key} -> {html} = $html_footer;
  $refCONTEXT -> {$key} -> {js}   = $js_footer;

}

# Получаем данные из массива собранного ранее в module__menu_by_subjects.pm
# [['Репетиторы по всем предметам', 'ссылка'],[],...]
sub get_menu_by_subject {
  my $refCONTEXT = shift;
  my $menu_by_subject = $refCONTEXT->{'menu_by_subject'} || [];
  # say Dumper($menu_by_subject);
  my $html = '';
  foreach my $item (@$menu_by_subject) {
    my $subject_text = $item -> [0];
    my $subject_link = $item -> [1];
    $html .=
      "<div class=four_column>
        <a href='$subject_link'>$subject_text</a>
      </div>";
  }
  $html .= "<br>";
  return $html;
}
1;