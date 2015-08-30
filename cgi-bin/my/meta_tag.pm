package meta_tag;
#!/usr/bin/perl
use strict;

# МЕТА ТЭГИ

sub title {
  my $title = shift;
  return '<title>'.$title.'</title>';
}

sub description {
  my $description = shift;
  $description =~s/^\s+//;
  return '<meta name="Description" content="'.$description.'">';
}

sub keywords {
  my $keywords = shift;
  $keywords =~s/^\s+//;
  return '<meta name="Keywords" content="'.$keywords.'">';
}

1;


