package write_env;
#!/usr/bin/perl
use strict;


# Запись переменных окружения в файл

use lib './';
use wf;


sub start {
  my $path = shift;
  my $env='';
  foreach my $e (keys %ENV) {
    $env.= "$e = $ENV{$e}\n\n";
  }
  wf::save_to_file_utf8($path, $env);
}
1;
