package wf;
use strict;

# Работа с файлами

# Дозапись в произвольной кодировке
sub add_to_file {
  my($fn,$data)=@_;
  open (RESULT,'>>'.$fn);
  print RESULT $data;
  close(RESULT);
}

# Дозапись в кодировке utf8
sub add_to_file_utf8 {
  my($fn,$data)=@_;
  open (RESULT,'>>utf8',$fn);
  print RESULT $data;
  close(RESULT);
}

# Запись в кодировке utf8
##############
sub save_to_file_utf8 {
  my($fn,$data)=@_;
  open (RESULT,'>utf8',$fn);
  print RESULT $data;
  close(RESULT);
}

# Читаем файл и возвращаем строку
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
1;