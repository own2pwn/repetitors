package build_path;
#!/usr/bin/perl
use strict;
use CGI;

# use 5.010;
# use Data::Dumper;

# СКРИПТ СОБИРАЮЩИЕ РАЗНЫЕ ПУТИ



# ----------------------------------------------------- Формируем URL для ссылок на страницу преподавателя  -------------------------------------------------------------
sub build_path_to_teacher_page {
  my ($domain,$teacher_id) = @_;
  return $domain.cgi_url::proccesing_url_keys({'action' => 'teacher', 'id' => $teacher_id},'&amp;');
}

1;