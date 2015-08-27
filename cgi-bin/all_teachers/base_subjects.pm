package base_subjects;
#!/usr/bin/perl
use strict;

# БАЗА ВОЗВМОЖНЫХ ПРЕДМЕТОВ

# my %CONTEXT = ('min' => 1);
# start(\%CONTEXT,'footer');

#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  base_subjects($refCONTEXT,$key);
  # my %hash_subjects = %{$CONTEXT{$key}};
  # foreach my $e (keys %hash_subjects) {
  #   print "text $hash_subjects{$e}->{title}\n";
  # }

}




# ----------------------------------------------------- ХЭШ С ДАННЫМИ ДЛЯ ССЫЛКИ НА ПРЕПОДАВАТЕЛЯ -------------------------------------------------------------
sub base_subjects {
  my ($refCONTEXT,$key) = @_;

  my %valid_values = ();

  $valid_values{'all'} = {
                          text => 'Репетиторы по всем предметам',
  };
  $valid_values{'mathematics'} = {
                          text => 'Репетиторы по математике (алгебра, геометрия, физика)',
  };
  $valid_values{'russian_language'} = {
                          text => 'Репетиторы по русскому языку (литературе)',
  };
  $valid_values{'english_language'} = {
                          text => 'Репетиторы по английскому языку',
  };

  $refCONTEXT -> {$key} = \%valid_values;
  $refCONTEXT -> {$key.'_sort_order'} = ['all', 'mathematics', 'russian_language','english_language'];

}
1;