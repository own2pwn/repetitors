package text_for_place_teachers;
#!/usr/bin/perl
use strict;

# ТЕКСТ ДЛЯ РАЗМЕЩЕНИЯ ПРЕПОДАВАТЕЛЯ


#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  text_for_place_teachers($refCONTEXT,$key);
  # print $CONTEXT{$key}{'html'};
  # print $CONTEXT{$key}{'css'};
  # print $CONTEXT{$key}{'js'};
}




# ----------------------------------------------------- ТЕКСТ ДЛЯ РАЗМЕЩЕНИЯ ПРЕПОДАВАТЕЛЯ-------------------------------------------------------------
sub text_for_place_teachers {
  my ($refCONTEXT,$key) = @_;
  # .paragraph{text-indent:5%}
  #     color: #903;
  #         padding-top:4px;
  # padding-right:8px;
  # padding-left: 3px;
  #     float: left;

    # .paragraph::first-letter{
    # float: left;
    # color: #CC0033;
    # font-size: 75px;
    # line-height: 60px;
    # padding: 4px 2% 1px 4%;
    # font-family: Georgia, serif;
    # }

    # .bukviza:first-letter {
    #   font-family: Georgia, serif;
    #   font-size: 250%;
    #   color: red;
    # }
  my $css_text = "
    .paragraph{text-indent:5%}
    .bukviza:first-letter {
      font-family: Georgia, serif;
      font-size: 250%;
      color: red;
      padding-right: .4%;
      line-height: 60px;
    }
    .list {
        padding-left: 5%;
        text-align:left;
    }

    .list li {
        background: url('$refCONTEXT->{domain}/Photo/list.png') no-repeat left center;
        padding-left: 10%;
        padding-top: 15px;
    }
  ";
  # Для этого Вам нужно зарегистрироваться на сайте как репетитор и внести Ваши данные - анкета сразу появится на сайте.
  # После размещения Вашей анкеты на сайте, мы обязательно проверим её и, при необходимости, откорректируем её или позвоним Вам для выяснения некоторых моментов.
  # После этого ученики смогут писать Вам личные сообщения, связываться с Вами по контактам, которые Вы укажете в анкете, а также отправлять Вам заявки на обучение.
  # Мы также будем подбирать Вам учеников, исходя из Ваших пожеланий (цены, специализации и т.п.), и связываемся с Вами сразу, как только будет появляться подходящий ученик.

  # Таблица , в который 2 ячейки: левая это красивый заголовок, а правая это контакты
  my $html_text = $refCONTEXT->{base_seo}->{h1}->{html} || '';
  $html_text .="

  <p class='paragraph bukviza'>
    Здесь вы можете сделать заказ на размещение своего резюме репетитора (<b style='color:black;font-family:Georgia,serif'>бесплатно</b>).
    После этого в самый короткий срок с Вами свяжется наш менеджер.
    Мы бесплатно создадим для Вас интернет-страницу, которая в дальнейшем будет рекламировать Ваши услуги также совершенно бесплатно для Вас.
  </p>
  <p>
    Ученики для каждого репетитора подбираются в удобном для него районе Москвы и ближайшем Подмосковье,
    что позволит существенно экономить Ваше время и силы.
    Вы сами определяет время и стоимость занятий.
    Плата за размещение и рекламу на нашем сайте не зависит от количества занятий с учениками.
    Вы платите за каждого подобранного клиента только один раз сумму в размере 50% от стоимости одного проведенного занятия.
  </p>

  Наши преимущества:
  <ul class=list>
    <li>Низкие цены           (Вдвое меньше берем за первое занятие, чем на других агрегаторах)</li>
    <li>Оперативность         (Круглосуточно обрабатываем звонки от клиентов) </li>
    <li>Индивидуальный подход (Возможность заказать индвидуальный дизайн страницы)</li>
    <li>Учет всех ваших пожеланий</li>
  </ul>
  ";

  my $js_text ="
  ";

  my $js_text_min ='
  ';

  $js_text = ( $refCONTEXT -> {'min'} == 1 ) ? $js_text_min : $js_text;
  $refCONTEXT -> {$key} -> {'css'} = $css_text;
  $refCONTEXT -> {$key} -> {'html'} = $html_text;
  $refCONTEXT -> {$key} -> {'js'} = $js_text;
}
1;