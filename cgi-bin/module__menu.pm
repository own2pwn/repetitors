package module__menu;
#!/usr/bin/perl
use strict;

# ОСНОВНОЕ МЕНЮ

#########################
sub start {
  my ($refCONTEXT,$key) = @_;

  menu($refCONTEXT,$key);
  # print $CONTEXT{$key}{'html'};
  # print $CONTEXT{$key}{'css'};
  # print $CONTEXT{$key}{'js'};
}



# ----------------------------------------------------- МЕНЮ ДЛЯ САЙТА -------------------------------------------------------------
sub menu {
  my ($refCONTEXT,$key) = @_;


  my $html_menu =<<"EOF";
  <div class="main_table_column">
    <div class=h_menu>
      <ul>
        <li><a href="#">Репетиторы</a></li>
        <li><a href="#">Разместить резюме репетитора</a></li>
      </ul>
    </div>
  </div>
EOF

  my $css_menu = '
  .main_table_column{
    display: inline-block;
    width: 100%;
    padding: 10px 0.5%;
    vertical-align: top;
    margin: 5px auto 35px auto;
  }

  .h_menu {
      margin: 0 auto;
      width: 70%;
      text-align: center;
      line-height: 50px;
      border-radius: 10px;
      background: #128F9A;
      background-image: linear-gradient(to left bottom, #4EC9D4 0%, #128F9A 100%);

      -webkit-box-shadow:0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;
         -moz-box-shadow:0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;
              box-shadow:0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;
      -webkit-box-shadow: 0 15px 10px -10px rgba(0, 0, 0, 0.5), 0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;
         -moz-box-shadow: 0 15px 10px -10px rgba(0, 0, 0, 0.5), 0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;
              box-shadow: 0 15px 10px -10px rgba(0, 0, 0, 0.5), 0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;

  }
    .h_menu ul{
      padding:0;
      margin:0;
      border-radius: 6px;
      border: 1px solid #0e7079;
    }
      .h_menu li{
        display: inline;
        list-style:none;
        margin: 5px 10px;
      }
         .h_menu a{
            padding:5px 10px;
            color:#fff;
            text-decoration: none;
         }
           .h_menu a:hover{
              background: #138791;
              color: #eee;
              border-radius: 10px;
              border: 1px solid #138791;
           }
  ';

  my $js_menu ="
  ";

  my $js_menu_min ='
  ';
  $js_menu = ( $refCONTEXT -> {'min'} == 1 ) ? $js_menu_min : $js_menu;
  $refCONTEXT -> {$key} -> {'css'} = $css_menu;
  $refCONTEXT -> {$key} -> {'html'} = $html_menu;
  $refCONTEXT -> {$key} -> {'js'} = $js_menu;
}
1;