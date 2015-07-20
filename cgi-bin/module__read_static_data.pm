package module__read_static_data;
#!/usr/bin/perl
use strict;

# ЧИТАЕМ СТАТИЧЕСКИЕ ДАННЫЕ ИЗ ФАЙЛА ПРЕПОДАВАТЕЛЯ

# my %CONTEXT = ('min' => 0, 'teacher' => 2);
# start(\%CONTEXT,2);

#########################
sub start {
  my ($refCONTEXT,$teacher_id) = @_;
  read_static_data($refCONTEXT,$teacher_id);
}

sub read_static_data {
  my ($refCONTEXT,$teacher_id) = @_;
  opendir DIR, "../common_teacher/" or die $!;
  while(my $fname = readdir DIR) {
    if($fname=~/$teacher_id\_teacher/i) {
     # print "<h1>$fname</h1>\n";
     my $path = '../common_teacher/'.$teacher_id.'_teacher';
     read_static($refCONTEXT,$path.'/'.$teacher_id."_static.txt");
    }
    else {
      # print "<p>НЕ папка с учителями $fname</p>\n";
    }
  }
  closedir DIR;
}

sub read_static {
  my ($refCONTEXT, $path) = @_;
  # print "Папка $path\n";
  my $info = read_file_return_str($path);
  # print "Данные из файла $info\n";
  my ($title, $description, $keywords, $about_teacher, $about_classroom, $about_individual, $about_list_districts, $ordering_works) = split(/@@@@/,$info);
  $refCONTEXT -> {'title'} -> {html} = $title;
  $refCONTEXT -> {'description'} -> {html} = $description;
  $refCONTEXT -> {'keywords'} -> {html} = $keywords;
  $refCONTEXT -> {'about_classroom'} -> {html} = $about_classroom;
  $refCONTEXT -> {'about_individual'} -> {html} = $about_individual;
  $refCONTEXT -> {'about_list_districts'} -> {html} = $about_list_districts;
  $refCONTEXT -> {'ordering_works'} -> {html} = $ordering_works;

  # my $face_image = "<img alt='' class=leftimg src='".$teacher_id."_teacher/".$teacher_id."_image_face.jpg'>";
  # $about_teacher=~s/IMAGE_FACE_TEACHER/$face_image/gi;
  $refCONTEXT -> {'about_teacher'} -> {html} = $about_teacher;

  # print "$title\n $description\n $keywords\n $about_teacher\n";
  # <img alt='' class=leftimg src='Photo/Teacher_1.jpg'>

  # print_on_monitor($refCONTEXT);

}

sub read_file_return_str {
  my $path = shift;
  my $ info = '';
  # создаем файловый дескриптор
  open FID, $path or die "FAILED to open $path: $!\n";
  while (<FID>) {
    $info.=$_;
  }
  close FID;
  return $info;
}

sub print_on_monitor {
  my $refCONTEXT = shift;

  my $title = $refCONTEXT -> {'title'} -> {html};
  my $description = $refCONTEXT -> {'description'} -> {html};
  my $keywords = $refCONTEXT -> {'keywords'} -> {html};
  my $about_classroom = $refCONTEXT -> {'about_classroom'} -> {html};

  my $about_individual = $refCONTEXT -> {'about_individual'} -> {html};
  my $about_list_districts = $refCONTEXT -> {'about_list_districts'} -> {html};
  my $ordering_works = $refCONTEXT -> {'ordering_works'} -> {html};
  my $about_teacher = $refCONTEXT -> {'about_teacher'} -> {html};
  print "title === $title\n\n";
  print "description === $description\n\n";
  print "keywords === $keywords\n\n";
  print "about_teacher === $about_teacher\n\n";
  print "about_classroom === $about_classroom\n\n";
  print "about_individual === $about_individual\n\n";
  print "about_list_districts === $about_list_districts\n\n";
  print "ordering_works === $ordering_works\n\n";
  exit;
}

1;