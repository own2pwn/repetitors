package cgi_url;
#!/usr/bin/perl
use strict;
use CGI;

# use 5.010;
# use Data::Dumper;

# СКРИПТ ОБРАБАТЫВАЮЩИЙ ПАРМЕТРЫ ИЗ URL (CGI)



# my $res = proccesing_url_keys({'teacher' => 1,'region' => 2,'ph' => 3});
# my $res = proccesing_url_keys({'action' => 'teacher', 'id' => 2, 'priv' => 123});
# my $res = proccesing_url_keys({'action' => 'all', 'id' => 1});
# my $res = proccesing_url_keys({'action' => 'order_call', 'id' => 1, 'region' => 'balashiza', 'ph' => '234567','monkey' => 'hello'});
# my $res = proccesing_url_keys({'action' => 'order_call', 'id' => 1, 'region' => 'balashiza', 'ph' => '234567'});
# say Dumper($res);


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
  my ($ref_hash_cgi, $amp) = @_;
  $amp = ($amp) ? $amp : '&';
  my %page_type = ( 'teacher'    => ['id'],
                    'order_call' => ['id','region','ph']
                   );
  my $url = '?';
  my $count = 0; # Счетчик, прибавления, хотя бы одного параметра к url

  if ($ref_hash_cgi) {
    my $action = $ref_hash_cgi->{'action'} || 'teacher';
    my $ar_key_mandatory = $page_type{$action} || [];

    $url.= 'action='.$action.$amp;
    foreach my $k (@$ar_key_mandatory) {
      if ($ref_hash_cgi -> {$k}) {
        # Проверка на то, не первая ли это страница
        if ($action eq 'teacher' && $ref_hash_cgi->{'id'} == 1) {return '';}
        $url.="$k=$ref_hash_cgi->{$k}".$amp;
        $count++;
      }
    }
    $url =~s/$amp$//ig;
  }
  else {
    # print "Не существует параметров для url!\n";
    return '';
  }
  if ($count == 0) { return '';}
  return $url;

}

# СТАРЫЙ КОД ДЛЯ ПОСТРОЕНИЯ URL
sub proccesing_url_keys_old{
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