package http;
#!/usr/bin/perl
use strict;

# HTTP

# print header();
# HTTP header with no-cache
sub header {

my $stop_browser_cache = "Expires: Mon, 26 Jul 1997 05:00:00 GMT\r\nCache-Control: no-cache, must-revalidate\r\nPragma: no-cache\r\n";
my $head ="Status: 200 OK\r\nX-FRAME-OPTIONS: DENY\r\nContent-type: text/html; charset=UTF-8\r\n";
        $head.= $stop_browser_cache;
        $head.="\r\n";


return $head;

}



# Редирект с no-cache
sub redirect {
  my ($redirect_status, $url)=@_; # // 301 - Permanently // 302 - Temporarily
  my $stop_browser_cache = "Expires: Mon, 26 Jul 1997 05:00:00 GMT\r\nCache-Control: no-cache, must-revalidate\r\nPragma: no-cache\r\n";
  print "Status: ".$redirect_status."\r\n".$stop_browser_cache.'Location: '.$url."\r\n\r\n";
}
1;