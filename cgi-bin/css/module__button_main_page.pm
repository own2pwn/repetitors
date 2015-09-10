package module__button_main_page;
#!/usr/bin/perl
use strict;

# КНОПКА ВОЗВРАЩЕНИЯ НА СТРАНИЦУ ПРЕПОДАВАТЕЛЯ


# my %CONTEXT;
# start(\%CONTEXT);

#########################
sub start {
  my ($refCONTEXT,$key) = @_;

  button_main_page($refCONTEXT,$key);
  # print $CONTEXT{$key}{'html'};
  # print $CONTEXT{$key}{'css'};
  # print $CONTEXT{$key}{'js'};
}




# ----------------------------------------------------- КНОПКА ВОЗВРАТА НА ПЕРВУЮ СТРАНИЦУ САЙТА -------------------------------------------------------------
sub button_main_page {
  my ($refCONTEXT,$key) = @_;

  my ($path, $text_for_button) = ('Назад', $refCONTEXT->{domain});
  # Путь на обратную страницу и соотвествующий текст
  if ($refCONTEXT->{'path_to_teacher_page'}){
    $path = $refCONTEXT->{'path_to_teacher_page'};
    $text_for_button = 'Вернуться на страницу преподавателя';
  }
  elsif ($refCONTEXT->{'path_to_place_teachers'}){
    $path = $refCONTEXT->{'path_to_place_teachers'};
    $text_for_button = 'Вернуться на страницу размещения преподавателей';
  }
  # my $path = $refCONTEXT->{'path_to_teacher_page'} || $refCONTEXT->{'path_to_place_teachers'};

  # Ссылка на предыдущую страницу
  # (стр преподавателя или размещения репетитора)
  my $html_button_main_page = "<br style='margin-bottom:15px;'><a href='$path' class='button'>$text_for_button</a>";
  my $css_button_main_page = <<"EOF";
  a.button {
    font-weight: 700;
    color: white;
    text-decoration: none;
    padding: .3em 1em calc(.3em + 3px);
    border-radius: 3px;
    background: rgb(64,199,129);
    box-shadow: 0 -3px rgb(53,167,110) inset;
    transition: 0.2s;
    white-space:nowrap;
  }
 a.button:hover { background: rgb(53, 167, 110); }
 a.button:active {
   background: rgb(33,147,90);
   box-shadow: 0 3px rgb(33,147,90) inset;
 }
EOF
  $refCONTEXT -> {$key} -> {html} = $html_button_main_page;
  $refCONTEXT -> {$key} -> {css} = $css_button_main_page;
}
1;