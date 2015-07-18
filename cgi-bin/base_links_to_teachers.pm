package base_links_to_teachers;
#!/usr/bin/perl
use strict;

# ЗАГЛОВКИ ДЛЯ ССЫЛОК НА ПРЕПОДАВАТЕЛЯ

# my %CONTEXT = ('min' => 1);
# start(\%CONTEXT,'footer');

#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  base_links_to_teachers($refCONTEXT,$key);
  # my %hash_teach = %{$CONTEXT{$key}};
  # foreach my $e (keys %hash_teach) {
  #   print "text $hash_teach{$e}->{title}\n";
  # }

}




# ----------------------------------------------------- ХЭШ С ДАННЫМИ ДЛЯ ССЫЛКИ НА ПРЕПОДАВАТЕЛЯ -------------------------------------------------------------
sub base_links_to_teachers {
  my ($refCONTEXT,$key) = @_;

  my %base_links = ();
  $base_links{1} = { 'title' => 'Репетитор по математике (Люберцы, Балашиха, Железнодорожный, Волжская, Марьино)',
                      };

  $base_links{2} = { 'title' => 'Репетитор по русскому языку и литературе (Ясенево, Коньково, Теплый Стан, Беляево, Профсоюзная)',
                      };

  $refCONTEXT -> {$key} = \%base_links;

}
1;