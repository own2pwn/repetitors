#!/usr/bin/perl
# use 5.016;
use strict;
# use utf8;
# binmode(STDOUT,':utf8');

use Data::Dumper;

my %CONTEXT=();
$CONTEXT{'hash_cgi'} = cgi_url::CGI_hash_new();
$CONTEXT{'formed_url'} = cgi_url::proccesing_url_keys($CONTEXT{'hash_cgi'});

use lib './my/';
use cgi_url;
use http;

print http::header();
print "
<form action='http://127.0.0.1/cgi-bin/test_encode.pl/'>
  <input type='text' name=action value=test />
  <input type='text' name=sub />
  <input type='text' name=ph />
  <input type='submit' value='button'/>
</form>";

print "formed_url => ".$CONTEXT{'formed_url'}."<br>";
print "hash_cgi => ".Dumper($CONTEXT{'hash_cgi'});

# print "hash_cgi   =>\t".'?action=test&sub='.encode($CONTEXT{'hash_cgi'}{'sub'}).'&ph='.encode($CONTEXT{'hash_cgi'}{'ph'})."<br>";
# print "formed_url =>\t".encode($CONTEXT{'formed_url'});



# print decode(encode(' привет'))."\n\n";


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


