package logs;
#!/usr/bin/perl
use strict;

use lib './';
use wf;

use lib '../';
use config;
my $c = config::settings();

# ЛОГИ

# логирование состояния страниц при заходе на них:
# (совпал url или нет, лишние ключи или надо отправить на редирект)
# script("Привет пес
#   , я здесь\n\n");
sub script {
  my $text = shift;
  my $path_log = $c->{main_path}.'log/script.txt' || '../../log/script.txt';
  if ($c->{log_temp}) {
    # мносторочный текст превращаем в однострочный
    $text =~s/(\S+\s*)\n(\s*\S+\s*)/$1 $2/g;
    # убираем множественные пробелы перед словом
    $text =~s/\s+(\S+)/ $1/g;
    wf::add_to_file($path_log, $text);
  }
}
1;