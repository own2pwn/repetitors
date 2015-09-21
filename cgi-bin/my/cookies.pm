package cookies;
#!/usr/bin/perl
use strict;

# use Data::Dumper;

# РАБОТАЕМ С КУКИ



# ------------------------------------ ПОЛУЧАЕМ HASH C COOKIES -------------------------------------------------------------
sub get_cookies {
  # warn "cookies = $ENV{HTTP_COOKIE}\n\n";
  my @cookies = split(/;\s+/, $ENV{HTTP_COOKIE});
  # warn "cookieks array = ".join (', ', @cookies)."\n\n";
  my %hash = ();
  foreach my $c (@cookies) {
    my ($key, $value)= split(/=/, $c);
    $hash{$key} = cgi_url::decode($value);
  }
  # print STDERR Dumper(\%hash);
  return \%hash;
}

1;