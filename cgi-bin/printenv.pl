#!/usr/bin/perl

use strict;
use lib './my/';
use http;


print http::header();

# foreach my $key( keys( %ENV ) ) {
# print "$key - $ENV{ $key }&lt;br&gt;\n";
# }

my $env='';
foreach my $e (keys %ENV) {
  $env.= "<p>$e = $ENV{$e}</p>\n";
}

print <<"EOF";
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Document</title>
</head>
<body>
  $env
</body>
</html>
EOF
;
