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
# my $res = proccesing_url_keys({'action' => 'place_teachers'});
# say Dumper($res);


# ----------------------------------------------------- Формируем хэш из параметров пришедших в URL -------------------------------------------------------------
sub CGI_hash {
  # Построили хэш {cgi_key} = cgi_value;
  my %hash_cgi = ();
  foreach my $k (CGI::param()) {
    my $value = CGI::param($k);
    $hash_cgi{$k} = encode($value) if $value;
  }
  return \%hash_cgi;
}


# ----------------------------------------------------- ПОСТРОЕНИЯ URL -------------------------------------------------------------
sub proccesing_url_keys{
  my ($ref_hash_cgi, $amp) = @_;
  $amp = ($amp) ? $amp : '&';
  my %page_type = ( 'teacher'        => ['id'],
                    'order_call'     => ['id','region','ph'],
                    'all_teachers'   => ['sub'],
                    'place_teachers' => [],
                    'order_call_place_teachers' => ['sub', 'ph'],
                    'test' => ['sub', 'ph'],
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
    # print STDERR "Не существует параметров для url!\n";
    return '';
  }
  if ($count == 0) { return '';}
  # print STDERR "Here url === $url\n";
  return $url;

}

# ----------------------------------------------------- ПОСТРОЕНИЯ URL -------------------------------------------------------------
sub proccesing_url_keys_new{
  my ($ref_hash_cgi, $amp) = @_;
  $amp = ($amp) ? $amp : '&';
  my %page_type = ( 'teacher'        => ['id'],
                    'order_call'     => ['id','region','ph'],
                    'all_teachers'   => ['sub'],
                    'place_teachers' => [],
                    'order_call_place_teachers' => ['sub', 'ph'],
                    'test' => ['sub', 'ph'],
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
        # $url.="$k=".decode($ref_hash_cgi->{$k}).$amp;
        $url.="$k=$ref_hash_cgi->{$k}".$amp;
        $count++;
      }
    }
    $url =~s/$amp$//ig;
  }
  else {
    # print STDERR "Не существует параметров для url!\n";
    return '';
  }
  if ($count == 0) { return '';}
  # print STDERR "Here url === $url\n";
  return $url;

}


# кодировать
sub encode {
  my $str = shift;
  $str=~s/([^^A-Za-z0-9\-_.!~*'()])/cgi_unpack($1)/eig;
  return $str;
}

# декодировать
sub decode {
  my $str = shift;
  $str=~s/%([a-f0-9][a-f0-9])/chr(hex($1))/eig;
  return $str;
}

sub cgi_unpack { return '%'.unpack('H*',$_[0]); }


# ----------------------------------------------------- Формируем хэш из параметров пришедших в URL -------------------------------------------------------------
sub CGI_hash_old {
  # Построили хэш {cgi_key} = cgi_value;
  my %hash_cgi = ();
  foreach my $k (CGI::param()) {
    my $value = CGI::param($k);
    $hash_cgi{$k} = $value if $value;
  }
  return \%hash_cgi;
}


1;