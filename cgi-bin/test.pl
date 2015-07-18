#!/usr/bin/perl

use strict;
use 5.016;

my @a =(1,2,3,4);
foreach my $e (@a) {
  if ($e == 2) {next;}
  else {
    say $e;
  }
}
