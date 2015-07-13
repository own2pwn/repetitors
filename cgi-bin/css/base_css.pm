package base_css;
use strict;

# БАЗОВЫЕ CSS СТИЛИ

# my %CONTEXT = ('min' => 1);
# start(\%CONTEXT,'footer');

#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  base_css($refCONTEXT,$key);
  # print $CONTEXT{$key}{html};
  # print $CONTEXT{$key}{css};
  # print $CONTEXT{$key}{js};
}




# ----------------------------------------------------- БАЗОВЫЙ CSS -------------------------------------------------------------
sub base_css {
  my ($refCONTEXT,$key) = @_;

  my $css_base_css = '
  *{margin:0;padding:0}
  body{font-family:Arial,Helvetica,sans-serif;font-size: 120%;line-height:1.5}
  ul,li{list-style:none}

  img{border:0;}
  table{border:0;border-collapse:collapse;}
  table tr{vertical-align:top}
  table td{padding:0}
  a{color:#1a50bd;text-decoration:none}
    a:visited{color:#551A8B}
    a:active, a:focus, img{outline:0}

  h1{display:inline;font-weight:normal;font-size:110%} /*color:#AB3C3C;*/
  h2{
    width:90%;
    padding:2px 0.5%;
    border-top:2px solid #AAA;
    border-bottom:2px solid #AAA;
    margin:55px auto 15px;
    font-family: verdana,sans-serif;
    font-weight: normal;
    font-size: 130%;
    text-align: center;
    color: #8C7B3C;
  }
  p{margin-top: 12px;margin-bottom: 12px;text-align: justify}
  em{font-weight:bold;color:#0099CC}
  strong{color:#AB3C3C}
  b{color:#0099CC}

  ';

  $refCONTEXT -> {$key} = { css => $css_base_css};

}
1;