#!/usr/bin/perl 
use strict;

### Скрипт утилита, позволяющий стили(Bootsrap) из одной строчки превратить во много строчек

my $PATH_STYLE_MIN='/Users/dmitrijd/Desktop/marianna_web/marianna_web_2.4/Util/bootsrap_style_min.css';
my $PATH_STYLE_HUMAN='/Users/dmitrijd/Desktop/marianna_web/marianna_web_2.4/Util/bootsrap_style_human.css';
my $style_css;

open (FILE,$PATH_STYLE_MIN);
   while (<FILE>) {
     $_=~s/}/}\n/g;
     $style_css.=$_;
   }
close (FILE);

save_to_txt_file($PATH_STYLE_HUMAN,$style_css);


############
sub save_to_txt_file {
  my($fn,$data)=@_;
  open (RESULT,'>'.$fn);
  print RESULT $data;
  close(RESULT);
}