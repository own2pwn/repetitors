package module__footer;
use strict;

# FOOTER СКРИПТА ПРЕПОДАВАТЕЛЯ

# my %CONTEXT = ('min' => 1);
# start(\%CONTEXT,'footer');

#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  footer($refCONTEXT,$key);
  # print $CONTEXT{$key}{html};
  # print $CONTEXT{$key}{css};
  # print $CONTEXT{$key}{js};
}




# ----------------------------------------------------- FOOTER -------------------------------------------------------------
sub footer {
  my ($refCONTEXT,$key) = @_;

  my $css_footer = '
  .footer {width:100%;margin-top:25px;border-top:2px solid #999;padding:20px 0;text-align:center}
  .footer a {color:#777;} /*margin:0 50px;*/
  .footer a:hover {color:#f00;text-decoration:underline;}
  .footer p  {margin:30px;}
  .four_column{
      display: inline-block;
      width: 24.5%;
      /*padding: 10px 1%;*/
      vertical-align: top;
      /*border: 2px solid green;*/
  }
  .two_column_contact_footer{
      display: inline-block;
      width: 48%;
      padding: 20px 0;
      vertical-align: top;
      font-size:150%;
      /*background-color:#F7F7F7;
      border-radius:15px;*/
  }
  ';

  ## Таблица , в который 2 ячейки: левая это красивый заголовок, а правая это контакты
  my $html_footer ='
  <div class=footer>

  <div class=four_column>
    <a href="#teacher">        Преподаватель
    </a>
  </div>
  <div class=four_column>
    <a href="#cost">           Стоимость занятий
    </a>
  </div>
  <div class=four_column>
    <a href="#order_solution"> Заказать выполнение работы
    </a>
  </div>
  <div class=four_column>
    <a href="#contacts">       Как нас найти
    </a>
  </div><br>

  <div class="commnication_style two_column_contact_footer"> <span id="communication_m_footer"></span>  </div>
  <div class="commnication_style two_column_contact_footer">  <span id="communication_ph_footer"></span> </div>

   <p style="font-size:80%;text-align:center"> © Copyright 2015 </p>

</div>
  ';

  my $js_footer ='
  ';

  my $js_footer_min ='
  ';
  $js_footer = ( $refCONTEXT -> {'min'} == 1 ) ? $js_footer_min : $js_footer;

  $refCONTEXT -> {$key} = { css => $css_footer, html => $html_footer, js => $js_footer};

}
1;