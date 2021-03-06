package module__links_to_teachers;
#!/usr/bin/perl
use strict;
# use Data::Dumper;

# use lib './';
# use base_links_to_teachers;

# СКРИПТ ДИНАМИЧЕСКИ СОБИРАЮЩИЙ СПИСОК ССЫЛОК НА ПРЕПОДАВАТЕЛЕЙ

# my %CONTEXT = ('min' => 1, 'id' => 1);
# base_links_to_teachers::start(\%CONTEXT,'base_links_to_teachers');

# start(\%CONTEXT,'base_links_to_teachers');


#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  links_to_teachers($refCONTEXT,$key);
  # print $CONTEXT{$key}{html};
  # print $CONTEXT{$key}{css};
  # print $CONTEXT{$key}{js};
}




# ----------------------------------------------------- СОБИРАЕМ ссылки на преподавателей -------------------------------------------------------------
sub links_to_teachers {
  my ($refCONTEXT,$key) = @_;

  my $html_links_to_teachers = '
    <div class=links_teachers>
    <span style="font-family:Comic Sans MS,Helvetica,cursive;font-size: 85%;">
      Преподаватели по другим предметам:
    </span>';

  # { id => { 'title' => 'Репетитор по математике (Люберцы, Балашиха, Железнодорожный, Волжская, Марьино)',}, ..}
  my $hash_teach_links = $refCONTEXT -> {'base_links_to_teachers'};
  my $teacher_id = $refCONTEXT -> {'teacher'};
  my $domain = $refCONTEXT -> {domain};
  foreach my $id (keys %$hash_teach_links) {
    next if $id == $teacher_id;
      if ($hash_teach_links->{$id}->{title}) {
        my $teacher_link = build_path::build_path_to_teacher_page($domain,$id);
        my $teacher_title = $hash_teach_links->{$id}->{title};
        $html_links_to_teachers .= "
        <p style='text-align:left'>
          <a href='$teacher_link'><span>$teacher_title</span></a>
        </p>";
    }
  }
  my $all_teachers_link = build_path::teachers_subjects($domain,'all');

  $html_links_to_teachers .= "
    <div style='font-size:90%;margin-top:30px;border:2px solid #CC3366;border-radius:12px;padding:5px 3%'>
      <a style='color:#CC3366;white-space:nowrap;text-decoration:none;' href='$all_teachers_link'>Все преподаватели &#8594;</a>
    </div>";
  $html_links_to_teachers .= '</div>';
  # print $html_links_to_teachers."\n";
  # exit;

# .links_teachers a:hover{color:#666666}
  my $css_links_to_teachers=<<"EOF";
  .links_teachers {
    margin-top:20px;
    border-top:2px solid #999;
    padding-top:20px
  }
  .links_teachers a {
      font-size: 90%;
      font-weight: 100;
      text-shadow: none;
      color: #3333FF;
      text-decoration: underline;
  }
  .links_teachers a:hover{color:#CC3366}

EOF




  my $js_links_to_teachers ='
  ';

  my $js_links_to_teachers_min ='
  ';
  $js_links_to_teachers = ( $refCONTEXT -> {'min'} == 1 ) ? $js_links_to_teachers_min : $js_links_to_teachers;
  $refCONTEXT -> {$key} -> {'css'} = $css_links_to_teachers;
  $refCONTEXT -> {$key} -> {'html'} = $html_links_to_teachers;
  $refCONTEXT -> {$key} -> {'js'} = $js_links_to_teachers;
}


1;