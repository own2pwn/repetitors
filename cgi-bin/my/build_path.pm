package build_path;
#!/usr/bin/perl
use strict;
use CGI;

# use Data::Dumper;

# СКРИПТ СОБИРАЮЩИЕ РАЗНЫЕ ПУТИ



# ---------------------------------------- Формируем URL для ссылок на страницу преподавателя  -------------------------------------------------------------
sub build_path_to_teacher_page {
  my ($domain,$teacher_id) = @_;
  return $domain.cgi_url::proccesing_url_keys({'action' => 'teacher', 'id' => $teacher_id},'&amp;');
}

# ---------------------------------------- Формируем URL для ссылок на преподавателей по определенным предметам  -------------------------------------------------------------
sub teachers_subjects {
  my ($domain,$subject) = @_;
  my $path = $domain.'/cgi-bin/all_teachers/all_teachers.pl/';
  # в конце ссылки добавляем #teachers_by_subject
  # для удобства навигации
  return $path.cgi_url::proccesing_url_keys({'action' => 'all_teachers', 'sub' => $subject},'&amp;').'#teachers_by_subject';
}

# ---------------------------------------- Формируем URL для ссылок на страницу для размещения преподавателя  -------------------------------------------------------------
sub place_teachers {
  my ($domain) = @_;
  my $path = $domain.'/cgi-bin/place_teachers/place_teachers.pl';
  # в конце ссылки добавляем #text_place
  # для удобства навигации
  return $path.cgi_url::proccesing_url_keys({'action' => 'place_teachers'},'&amp;').'#text_place';
}


1;