package module__list_districts;
use strict;

# СКРИПТ ДИНАМИЧЕСКИ СОБИРАЮЩИЙ МАРКИРОВАННЫЙ СПИСОК РЕГИОНОВ, КУДА ВЫЕЗЖАЕТ ПРЕПОДАВАТЕЛЬ

# my %CONTEXT = ('min' => 1, 'id' => 1);
# start(\%CONTEXT,'list_districts');

#########################
sub start {
  my ($refCONTEXT,$key) = @_;

  my %hash_teach = %{$refCONTEXT -> {'base_teachers'}};
  my $teacher_id = $refCONTEXT -> {'teacher_id'};

  if ($hash_teach{$teacher_id}) {
    my $refhash = $hash_teach{$teacher_id}->{$key};
    $refCONTEXT -> {data} = $refhash;
    # $refCONTEXT -> {data} = {'станции метро Калининской линии' => 1,'станции метро Арбатско покровской линии' => ['Семеновская','Партизанская'],};
    # print "OK\n";
  }
  else {
    print " NOT OK\n";
    exit;
  }
  list_districts($refCONTEXT,$key);
  # print $CONTEXT{$key}{html};
  # print $CONTEXT{$key}{css};
  # print $CONTEXT{$key}{js};
}




# ----------------------------------------------------- СОБИРАЕМ маркированный список регионов где прохрдят занятия TABLE PRICE -------------------------------------------------------------
sub list_districts {
  my ($refCONTEXT,$key) = @_;

  my %hash = %{$refCONTEXT -> {data}};

  my $html_list_districts ="<ul style='width:90%' class=rectangle-list>\n";
  foreach my $key (sort { $hash{$b} cmp $hash{$a} } keys %hash) {

    $html_list_districts.= "<li><span style='color:#B84444;' class=branches_subway>$key</span>\n";
    if ($hash{$key} != 1) {
      $html_list_districts.= "\t<ul>\n";
      foreach my $el (@{ $hash{$key} }) {
        $html_list_districts.= "\t<li><span>$el</span></li>\n";
      }
      $html_list_districts.= "\t</ul>\n";
    }

  }
  $html_list_districts.="</li></ul>";
  # print "$html_list_districts\n";
  # exit;

  my $css_list_districts ="
  .rectangle-list ul li {margin-left:40px;}

   .rectangle-list span {
      position: relative;
      display: block;
      padding: .4em .4em .4em 4%;
      *padding: .4%;
      margin: .5em 0 .5em 2.5em;
      background: #ddd;
      color: #444;
      text-decoration: none;
      -webkit-transition: all .3s ease-out;
      -moz-transition: all .3s ease-out;
      -ms-transition: all .3s ease-out;
      -o-transition: all .3s ease-out;
      transition: all .3s ease-out;

  }

  .rectangle-list span:hover {
      background: #eee;
  }

  .rectangle-list span:before {
      content: counter(1);
      counter-increment: 1;
      position: absolute;
      left: -2.5em;
      top: 50%;
      margin-top: -1em;
      background: #fa8072;
      height: 2em;
      width: 2em;
      line-height: 2em;
      text-align: center;
      font-weight: bold;
  }

  .rectangle-list span:after {
      position: absolute;
      content: '';
      border: .5em solid transparent;
      left: -1em;
      top: 50%;
      margin-top: -.5em;
      -webkit-transition: all .3s ease-out;
      -moz-transition: all .3s ease-out;
      -ms-transition: all .3s ease-out;
      -o-transition: all .3s ease-out;
      transition: all .3s ease-out;
  }

  .rectangle-list span:hover:after {
      left: -.5em;
      border-left-color: #fa8072;
  }

  .branches_subway {
      font-family: 'lucida sans unicode','lucida grande','sans-serif';
      font-size:16px;
      font-weight:bold;
      font-style:italic;
  }
  ";




  my $js_list_districts ='
  ';

  my $js_list_districts_min ='
  ';
  $js_list_districts = ( $refCONTEXT -> {'min'} == 1 ) ? $js_list_districts_min : $js_list_districts;
  $refCONTEXT -> {$key} -> {'css'} = $css_list_districts;
  $refCONTEXT -> {$key} -> {'html'} = $html_list_districts;
  $refCONTEXT -> {$key} -> {'js'} = $js_list_districts;
}
1;