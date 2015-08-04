package module__contacts_filials;
use strict;

# СКРИПТ C КОНТАКТАМИ ФИЛИАЛОВ (ТЕКСТИЛЬЩИКИ И КУЗЬМИНКИ): СКРИПТ ПРЕПОДАВАТЕЛЬ

# my %CONTEXT = ('min' => 1, 'id' => 1);
# start(\%CONTEXT,'contacts_filials');

#########################
sub start {
  my ($refCONTEXT,$key) = @_;

  contacts_filials($refCONTEXT,$key);
  # print $CONTEXT{$key}{html};
  # print $CONTEXT{$key}{css};
  # print $CONTEXT{$key}{js};
}




# ----------------------------------------------------- СОБИРАЕМ контакты филиалов (Текстильщики и Кузьминки) -------------------------------------------------------------
sub contacts_filials {
  my ($refCONTEXT,$key) = @_;

  my $html_contacts_filials ='
   <h2 id=contacts> Местонахождение филиалов</h2>
   <p> Занятия проходят в двух филиалах в Текстильщиках и Кузьминках.
   </p>
   <p> <b> Текстильщики: </b> </p>
   <p> Филиал находится по адресу ул. 11-ая Текстильщиков д.11, метро Текстильщики.
                   <span style="font-style:italic">
                   Запись производится по телефону
                   <b style="color:black"><span id=communication_ph1></span> </b>
                   </span>
   </p>

   <div id=show_map_1 style=text-align:center><button type="button" class=button style=width:50%>Показать карту</button></div>
   <div id=map_1></div>

   <p>Как добраться:</p>
   <p>
      Выходим из первого вагона из центра (метро Текстильщики), выход к
      спортивному комплексу "Москвич" (к Волгорадскому проспекту),
      после стеклянных дверей направо. Идем прямо, вдоль Волгоградского проспекта,
      проходим мимо  стадион, ледовой дворец, идем вдоль длинного железного забора.
      Доходим до жилого здания, где находится медцентр (д.11), заходим во двор,
      проходим ремонт обуви и жилой подъезд, следующий вход в образовательный центр
      (распологается в самом углу).
   </p>


   <img class=some_photo alt="" src="Photo/Where_exit_textile.jpg">
   <img class=some_photo alt="" src="Photo/Textile_output.jpg">
   <img class=some_photo alt="" src="Photo/Textile_input.jpg">

   <p> <b> Кузьминки: </b> </p>
   <p>
     Филиал находится по адресу ул. Окская д.5 корп. 3, метро Кузьминки,
     <span style="font-style:italic;"> Запись производится по телефону
       <b style="color:black;"><span id=communication_ph2> </span></b>
     </span>
   </p>

  <div id=show_map_2 style=text-align:center><button type="button" class=button style=width:50%>Показать карту</button></div>
  <div id=map_2></div>


    <p> Как добраться:</p>
    <p> На автобусе:  </p>
    <p>
      Выходим  из первого вагона из центра (метро Кузьминки), выход
      к "Площади славы, Волгоградский проспект",после стеклянных дверей налево
      и поступенькам направо. Остановка будет с правой стороны. Для того чтобы добраться
      подходят  автобусы 143, 169к, проезжаем две остановки ( "Зеленодольская ул" ,
      "Жигулевская ул" ) и    выходим на третьей "Окская улица, 18",после чего идем несколько минут
      пешком до дом 5 корп 3 на улице Окская. Кроме того, подходят так же маршрутки 433м, 443м.
   </p>

   <img class=some_photo alt="" src="Photo/Where_exit_kuzminki_bus.jpg">

   <p> Пешком:  </p>
   <p>
     Выходим  из последнего вагона из центра (метро Кузьминки), выход
     к "улица Жигулевская",после стеклянных дверей направо
     и по ступенькам налево. Около выхода будет магазин "Домашний мастер".
     После чего идти пешком около 20 минут до филиала образовательного центра.
   </p>

   <img class=some_photo alt="" src="Photo/Where_exit_kuzminki_foot.jpg">

   <img class=some_photo alt="" src="Photo/Kuzminki_output.jpg">
  ';


  my $css_contacts_filials ='
  ';




  my $js_contacts_filials =<<"EOF";
  (function  () {

    var maps = ['<iframe src="https://www.google.com/maps/embed?pb=!1m27!1m12!1m3!1d2247.856786223689!2d37.73958956517625!3d55.70886109300684!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m12!1i0!3e2!4m5!1s0x414ab51ba43fa50d%3A0x5595bad365e6ee4f!2z0KLQtdC60YHRgtC40LvRjNGJ0LjQutC4!3m2!1d55.709036!2d37.733424!4m3!3m2!1d55.7077471!2d37.7431682!5e0!3m2!1sru!2sru!4v1413533394421"\\
                 width="99%" height="350"  style="border:0">\\
                 </iframe>',
                 '<iframe src="https://www.google.com/maps/embed?pb=!1m27!1m12!1m3!1d4495.631558819302!2d37.766067278829624!3d55.70957385767488!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m12!1i0!3e2!4m3!3m2!1d55.7057685!2d37.7671899!4m5!1s0x414ab50d006fd19d%3A0x5fe0001efaf023c2!2z0J7QutGB0LrQsNGPINGD0LsuLCA1INC60L7RgNC_0YPRgSAzLCDQnNC-0YHQutCy0LAsIDEwOTExNw!3m2!1d55.714822999999996!2d37.75674!5e0!3m2!1sru!2sru!4v1413551981169"\\
                 width="99%" height="350" style="border:0">\\
                 </iframe>'
                 ];


    for (var i = 1; i <= 2; i++) {
      (function(j) {
        var button = getByID('show_map_' + j);
        button.onclick = function() {
          button.style.display = 'none';
          getByID('map_' + j).innerHTML = maps[j - 1];
        }
      }(i));
    }

  }());
EOF
  # Рабочая минификация (проверено)
  my $js_contacts_filials_min =<<"EOF";
  !function(){for(var a=['<iframe src="https://www.google.com/maps/embed?pb=!1m27!1m12!1m3!1d2247.856786223689!2d37.73958956517625!3d55.70886109300684!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m12!1i0!3e2!4m5!1s0x414ab51ba43fa50d%3A0x5595bad365e6ee4f!2z0KLQtdC60YHRgtC40LvRjNGJ0LjQutC4!3m2!1d55.709036!2d37.733424!4m3!3m2!1d55.7077471!2d37.7431682!5e0!3m2!1sru!2sru!4v1413533394421"               width="99%" height="350"  style="border:0">               </iframe>','<iframe src="https://www.google.com/maps/embed?pb=!1m27!1m12!1m3!1d4495.631558819302!2d37.766067278829624!3d55.70957385767488!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m12!1i0!3e2!4m3!3m2!1d55.7057685!2d37.7671899!4m5!1s0x414ab50d006fd19d%3A0x5fe0001efaf023c2!2z0J7QutGB0LrQsNGPINGD0LsuLCA1INC60L7RgNC_0YPRgSAzLCDQnNC-0YHQutCy0LAsIDEwOTExNw!3m2!1d55.714822999999996!2d37.75674!5e0!3m2!1sru!2sru!4v1413551981169"               width="99%" height="350" style="border:0">               </iframe>'],b=1;2>=b;b++)!function(b){var c=getByID("show_map_"+b);c.onclick=function(){c.style.display="none",getByID("map_"+b).innerHTML=a[b-1]}}(b)}();
EOF

  $js_contacts_filials = ( $refCONTEXT -> {'min'} == 1 ) ? $js_contacts_filials_min : $js_contacts_filials;
  $refCONTEXT -> {$key} -> {'css'} = $css_contacts_filials;
  $refCONTEXT -> {$key} -> {'html'} = $html_contacts_filials;
  $refCONTEXT -> {$key} -> {'js'} = $js_contacts_filials;
}
1;