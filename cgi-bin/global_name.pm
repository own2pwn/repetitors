#!/usr/bin/perl

package global_name;
use strict;
use Exporter 'import';

our @EXPORT_OK = qw/Test Test1/;

sub Test {
  print "global_name - Test Ok!\n";
}

sub Test1 {
  print "global_name - Test1 Ok!\n";
}

1;
