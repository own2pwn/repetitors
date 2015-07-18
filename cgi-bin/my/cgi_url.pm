package cgi_url;
use strict;
use CGI;

# Скрипт обрабатывающий парметры из URL (CGI)






# ----------------------------------------------------- Формируем хэш из параметров пришедших в URL -------------------------------------------------------------
sub CGI_hash {
  # Построили хэш {cgi_key} = cgi_value;
  my %hash_cgi = ();
  foreach my $k (CGI::param()) {
    my $value = CGI::param($k);
    $hash_cgi{$k} = $value if $value;
  }
  return \%hash_cgi;
}


# ----------------------------------------------------- ПОСТРОЕНИЯ URL -------------------------------------------------------------
sub proccesing_url_keys{
  my ($ref_hash_cgi) = @_;
  my @ar_key_mandatory = ('teacher','region','ph');
  my $url = '?';
  my $count = 0;

  if ($ref_hash_cgi) {
    foreach my $k (@ar_key_mandatory) {
      if ($ref_hash_cgi -> {$k}) {
        $url.="$k=$ref_hash_cgi->{$k}&";
        $count++;
      }
    }
    $url =~s/&$//ig;
  }
  else {
    # print "Не существует параметров для url!\n";
    return '';
  }
  if ($count == 0) { return '';}
  return $url;

}
1;