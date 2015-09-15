#!/usr/bin/perl

use strict;
use 5.016;

# use Data::Dumper;



use Digest::MD5  qw(md5_hex);

my $PASSWD = 'any string…';

get_keys('Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:39.0) Gecko/20100101 Firefox/39.0');

#
sub get_keys {
  my $user_agent = shift;
  my @passset = ('a'..'z','A'..'Z');
  # print Dumper(\@passset);
  my $A = '';
  for (my $i = 0; $i < 12; $i++) { $A.= $passset[int(rand($#passset + 1))]; }
  $A.= time();
  my $B = md5_hex($A, $PASSWD, $user_agent);
  say $A;
  say $B;
  return ($A, $B);
}

#
sub check_keys {
  my($A, $B, $user_agent) = @_;
  return ($B eq md5_hex($A, $PASSWD, $user_agent)) ? 1 : 0;
}