#!/usr/bin/perl

use strict;
use 5.016;
use Tie::IxHash;
use Time::HiRes;




sub sort_keys_hash {
  my %hash;
  tie %hash, "Tie::IxHash";
  init(\%hash);

  # %hash = ('москва' => 3, 'воронеж' => 2, 'рязань' => 1);
  # $hash{'москва'} = 3;
  # $hash{'воронеж'} = 2;
  # $hash{'рязань'} = 1;

  foreach my $key (keys %hash) {
    # print "$key === $hash{$key}\n";
  }
}

sub keys_hash {
  my %hash;
  init(\%hash);
  # %hash = ('москва' => 3, 'воронеж' => 2, 'рязань' => 1);
  # $hash{'москва'} = 3;
  # $hash{'воронеж'} = 2;
  # $hash{'рязань'} = 1;

  foreach my $key (keys %hash) {
    # print "$key === $hash{$key}\n";
  }
}


sub init {
  my $refhash = shift;
  for (my $i = 0; $i < 1000000; $i++) {
    $refhash -> {$i} =$i;
  }
}



# run_test('keys_hash',\&keys_hash);
run_test('sort_keys_hash',\&sort_keys_hash);
##########################################
sub run_test {
  my ($test_name,$func,$pre_run)=@_;

  my($seconds1, $microseconds1) = Time::HiRes::gettimeofday();
  &$func();
                                       # 1 параметр старт, 2 параметр текущее, считаем интервал
  my $elapsed=Time::HiRes::tv_interval([$seconds1, $microseconds1], [Time::HiRes::gettimeofday()]);
  print $test_name.' = '.sprintf("%.3f",$elapsed*1000)."ms\n";
}