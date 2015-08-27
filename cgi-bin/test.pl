#!/usr/bin/perl

use strict;
use 5.016;
use lib './';
use global_name qw/Test Test1/;

use Data::Dumper;
my $a = [];
push($a,[1,2,3,]);
say Dumper($a);
Test();
Test1();