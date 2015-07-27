package wf;
use strict;

# Работа с файлами

# Дозапись в произвольной кодировке
sub add_to_file {
  my($fn,$data)=@_;
  open (RESULT,'>>'.$fn) ||  print STDERR "FAILED sub add_to_file: $!\n";
  print RESULT $data;
  close(RESULT);
}

# Запись в произвольной кодировке
##############
sub save_to_file {
  my($fn,$data)=@_;
  open (RESULT,'>',$fn) ||  print STDERR "FAILED sub save_to_file: $!\n";
  print RESULT $data;
  close(RESULT);
}

# Дозапись в кодировке utf8
sub add_to_file_utf8 {
  my($fn,$data)=@_;
  open (RESULT,'>>utf8',$fn) ||  print STDERR "FAILED sub add_to_file_utf8: $!\n";
  print RESULT $data;
  close(RESULT);
}

# Запись в кодировке utf8
##############
sub save_to_file_utf8 {
  my($fn,$data)=@_;
  open (RESULT,'>utf8',$fn) ||  print STDERR "FAILED sub save_to_file_utf8: $!\n";
  print RESULT $data;
  close(RESULT);
}


# Читаем файл и возвращаем строку
sub read_file_return_str {
  my $path = shift;
  my $ info = '';
  # создаем файловый дескриптор
  open FID, $path ||  print STDERR "FAILED to open $path: $!\n";
  while (<FID>) {
    chomp;
    $info.=$_;
  }
  close FID;
  return $info;
}
1;