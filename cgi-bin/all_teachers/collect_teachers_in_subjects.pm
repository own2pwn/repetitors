package collect_teachers_in_subjects;
#!/usr/bin/perl
use 5.010;
use strict;
# use Data::Dumper;

# use lib './';
# use base_links_to_teachers;

# СКРИПТ ДИНАМИЧЕСКИ СОБИРАЮЩИЙ
# СПИСОК ПРЕПОДАВАТЕЛЕЙ (TITLE, IMAGE, DESCRIPTION) НА ОБЩЕЙ СТРАНИЦЕ
# В СООТВЕТСТВИИ С ЗАДАННЫМ ПРЕДМЕТОМ

# my %CONTEXT = ('min' => 1, 'id' => 1);
# base_links_to_teachers::start(\%CONTEXT,'base_links_to_teachers');

# start(\%CONTEXT,'base_links_to_teachers');


#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  collect_teachers_in_subjects($refCONTEXT,$key);
  # print $CONTEXT{$key}{html};
  # print $CONTEXT{$key}{css};
  # print $CONTEXT{$key}{js};
}




# ----------------------------------------------------- СОБИРАЕМ ссылки на преподавателей по опеределенным предметам -------------------------------------------------------------
sub collect_teachers_in_subjects {
  my ($refCONTEXT,$key) = @_;

  my $subject = $refCONTEXT -> {'subject'};
  say STDERR "subject === $subject\n";
  my $h1 = $refCONTEXT->{base_subjects}->{$subject}->{text} || '';
  my $html_teachers_in_subjects = '<h1 id=teachers_by_subject>'.$h1.'</h1>';
  $html_teachers_in_subjects = '<div>';

  # { id => {
  #         'title' => 'Репетитор по математике (Люберцы, Балашиха, Железнодорожный, Волжская, Марьино)',
  #         'desription' =>
  #         }, ..}
  my $hash_teach       = $refCONTEXT -> {'base_teachers'};
  my $hash_teach_links = $refCONTEXT -> {'base_links_to_teachers'};
  my $sort_teach       = $refCONTEXT -> {'base_links_to_teachers_sort_order'};
  my $domain = $refCONTEXT -> {domain};
  foreach my $id (@$sort_teach) {
    my $one_teacher = $hash_teach_links->{$id};
    if ($one_teacher->{title} && $one_teacher->{desription}) {
      my $teacher_link       = build_path::build_path_to_teacher_page($domain,$id);
      my $teacher_title      = $one_teacher->{title};
      my $teacher_desription = $one_teacher->{desription};
      my $teacher_img        = $domain.'/common_teacher/'.$id.'_teacher/'.$id.'_image_face.jpg';
      my $teacher_sub        = $hash_teach->{$id}->{subject};
      my $data = [$teacher_title, $teacher_link, $teacher_desription, $teacher_img];
      if ($refCONTEXT -> {'subject'} eq 'all') {
        $html_teachers_in_subjects .= html($data);
      }
      elsif ($refCONTEXT -> {'subject'} eq $teacher_sub){
        $html_teachers_in_subjects .= html($data);
      }
    }
  }
  $html_teachers_in_subjects .= "</div>";
  # print $html_teachers_in_subjects."\n";
  # exit;


  my $css_teachers_in_subjects = css();

  my $js_teachers_in_subjects ='
  ';

  my $js_teachers_in_subjects_min ='
  ';
  $js_teachers_in_subjects = ( $refCONTEXT -> {'min'} == 1 ) ? $js_teachers_in_subjects_min : $js_teachers_in_subjects;
  $refCONTEXT -> {$key} -> {'css'} = $css_teachers_in_subjects;
  $refCONTEXT -> {$key} -> {'html'} = $html_teachers_in_subjects;
  $refCONTEXT -> {$key} -> {'js'} = $js_teachers_in_subjects;
}


# ----------------------------------------------------- HTML и CSS -------------------------------------------------------------

sub html {
  my ($data) = @_;
  my ($teacher_title, $teacher_link, $teacher_desription, $teacher_img) = ($data->[0],$data->[1],$data->[2],$data->[3]);
  return
  "<div style='margin:20px auto 30px auto;padding-bottom:20px;border-bottom: 2px solid #eee;'>
    <div class=subj_teachers_left_column>
      <img class=subj_image_face src='$teacher_img' alt=''>
    </div>
    <div class=subj_teachers_right_column>
      <a href='$teacher_link' class=subj_link><span>$teacher_title</span></a>
    </div>

    <div style='clear:both'></div>
    <p>$teacher_desription</p>
    <a href='$teacher_link'>Перейти к преподавателю</a>
  </div>";
}

sub css {
  return <<"EOF";
  .subj_teachers_left_column{
    display:inline-block;
    width:25%;
    padding:0 0.5%;
    float:left;
    vertical-align:top;
    /*border: 2px solid green;*/
  }
  .subj_teachers_right_column{
    display:inline-block;
    width:70%;
    padding:0 0.5%;
    vertical-align:top;
    margin-top:10px;
    text-align:justify;
    /*border: 2px solid red;*/
  }
  .subj_link{text-decoration:underline;}
  .subj_link:hover{color:#CC3366}
  .subj_teachers_descr{
    /*border: 2px solid black;*/
  }
  .subj_image_face{
    width:90%;
    /*border: 2px solid blue;*/
  }
EOF
}

1;