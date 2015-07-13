#!/usr/bin/perl
use strict;
 use utf8;
binmode(STDOUT,':utf8');







my $PATH='/home_1/andrey7/www/mat-repetitor.ru/index.html';# Формируем файл для сервера


# --------------------------JavaScript----------------------------------------

# ----------------------------------------------------------------------------------------------------



# ----------------------------------------------------------------------------------------------------

## Яндекс Метрика и Google Analytics
my $js_metrica='<!-- Yandex.Metrika counter -->
<script type="text/javascript">
(function (d, w, c) {
    (w[c] = w[c] || []).push(function() {
        try {
            w.yaCounter26904114 = new Ya.Metrika({id:26904114,
                    webvisor:true,
                    clickmap:true,
                    trackLinks:true,
                    accurateTrackBounce:true});
        } catch(e) { }
    });

    var n = d.getElementsByTagName("script")[0],
        s = d.createElement("script"),
        f = function () { n.parentNode.insertBefore(s, n); };
    s.type = "text/javascript";
    s.async = true;
    s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js";

    if (w.opera == "[object Opera]") {
        d.addEventListener("DOMContentLoaded", f, false);
    } else { f(); }
})(document, window, "yandex_metrika_callbacks");
</script>
<noscript><div><img src="//mc.yandex.ru/watch/26904114" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
<!-- /Yandex.Metrika counter -->


     ';

my $js_analytics="

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-56326628-1', 'auto');
  ga('send', 'pageview');

</script>



     ";



# ------------------------------------------------------------------------------------------------



# ----------------------------------------------------------------------------------------------------

## JavaScript для КОНТАКТОВ возвращает по id utf8 и функция рисующая БОРДЕРЫ
my $js_contacts='

  var mail = ["communication","communication_m","communication_m_footer"];

  for (var i=0,l=mail.length; i<l; i++) {
     document.getElementById(mail[i]).innerHTML="\u006d\u0061\u0072\u0069\u0061\u006E\u006E\u0061\u002E\u0072\u0065\u0070\u0065\u0074\u0069\u0074\u006F\u0072\u0040\u0067\u006d\u0061\u0069\u006C\u002E\u0063\u006F\u006d";
  }

  var phones = {
    "\u0038\u0028\u0039\u0031\u0036\u0029\u002D\u0033\u0034\u0031\u002D\u0032\u0030\u0037\u0030":["communication_ph","communication_ph1","communication_ph2","communication_ph_footer","communication_ph_individual","communication_ph_contractual"],
    "\u0028\u0034\u0039\u0035\u0029\u0037\u0030\u0039\u002D\u0036\u0030\u002D\u0038\u0034":["communication_ph_textile_workers"]
    };
  for(var ph in phones) {
    var ids=phones[ph];
    for (var i=0,l=ids.length; i<l; i++) {
     document.getElementById(ids[i]).innerHTML=ph;
     }
  }



   /*Функция рисующая бордеры для всех элементов рандомного цвета*/
    drawBorders(0);
      function drawBorders(trigger) {
        if (trigger===1) {
            [].forEach.call(document.querySelectorAll("*"),function(a){a.style.outline="2px solid #"+(~~(Math.random()*(1<<24))).toString(16)})
        }
    }




  <!--communication это id для получения почты в header -->


  <!--communication_ph это id для получения phone(marianna) в header -->


  <!--communication это id для получения почты в раздел заказов заданий(order_solution) -->


  <!--communication_ph это id для получения phone(marianna) в раздел contacts в первый раз -->


  <!--communication_ph это id для получения phone(marianna) в раздел contacts во второй раз -->


  <!--communication_ph_textile_workers это id для получения phone(Текстильщиков)  в раздел contacts -->


  <!--communication_ph_individual это id для получения phone(marianna) в разделе индивидуальных занятий в ТОП-5 регионах -->


  <!--communication_ph_contractual это id для получения phone(marianna) в разделе договрных цен -->


    ';

# ----------------------------------------------------------------------------------------------------



# ----------------------------------------------------------------------------------------------------


# Классы для текстов(<p>) заголовков(<h1>,<h2>), а так же класс для заглав буквы и абзаца
my $classes_text='


.text_symbol{ font-family: \'Tangerine\', serif; font-size: 88px; text-shadow: 4px 4px 4px #aaa;}
/*Класс .text_symbol Стили для Google-шрифт для символа заголовка в левом верхнем углу Marianna-repetitor */

.commnication_style {font-family: "Comic Sans MS",cursive;font-size: 1em;color: #5E1C1C;}
/*Класс .commnication_style Стили для контактов в правом верхнем углу*/

.leftimg {
    width:170px;
    float:left; /* Выравнивание по левому краю */
    margin: 7px 7px 7px 0; /* Отступы вокруг картинки */
   }

/*Классы для текста*/

  .article1{text-align:justify;}
  .article1 p{margin-top:12px;} /*margin-bottom:15px;*/
  .article1 p.abzats{text-indent:5%;}

 /* .article h1{font-weight:normal;font-size:120%;text-align:center;color: #5E1C1C;}  */
  /* border:1px solid orange; for <h2>  */

  h2{width:90%;padding:2px 0.5%;border-top:2px solid #AAA;border-bottom:2px solid #AAA;margin:55px auto 15px; font-family: verdana,sans-serif;font-weight: normal;font-size: 130%;text-align: center;color: #8C7B3C;}
  .text { font-family: Arial, Helvetica, sans-serif; /* Гарнитура шрифта основного текста */
      font-size: 98%; /* Размер шрифта */   }

  .bukviza:first-letter {font-family: "Times New Roman", Times, serif; /* Гарнитура шрифта первой буквы */
      font-size: 250%; /* Размер шрифта первого символа */
      color: red; }


/* Маскируем тэг <h1> под тэг <p> */
.mask_under_p {
     display:inline;
     text-align:justify;
     font-weight:normal;
     font-family: Arial, Helvetica, sans-serif; /* Гарнитура шрифта основного текста */
     font-size: 98%; /* Размер шрифта */
     /* font-style:oblique; */
     font-weight: bold;
  }

';


# ----------------------------------------------------------------------------------------------------



# ----------------------------------------------------------------------------------------------------



## Таблица , в который 2 ячейки: левая это красивый заголовок, а правая это контакты
## (header сайта)
my $table_header='
  <!-- Таблица , в который 2 ячейки: левая это красивый заголовок, а правая это контакты -->
  <div class="header_two_column">
    <p style="color:red;"  class="text_symbol">Marianna-repetitor!</p>
  </div>
  <div  style="font-size:150%" class="header_two_column">
     <p style="text-align:right" id="communication_ph" class="commnication_style"> </p>
     <p style="text-align:right" id="communication"  class="commnication_style"> </p>
  </div>
    ';


# ------------------------------------------------------------------------------------------------

# ----------------------------------Html 5.0 and CSS-------------------

# ----------------------------------------------------------------------------------------------------

## Оформление текстов для ФОРМ ЗАКАЗА ЗВОНКА
my $classes_field_call="
/* Оформление текста для заказа звонка */
.phrase_form {font-family: \"Comic Sans MS\",cursive;font-size: 90%;font-style: italic;}

/* Бордер(серая рамка), отступы(внутри и снаружи), ширина, для формы заказа звонка */
.frame {
      border-radius:15px;
      border:2px solid #eaedf0;
      width:100%;
      margin:25px 0px;
      padding:5px 2%
    }
";

## Кнопки с формой для ЗАКАЗА ЗВОНКА #D13C22
my $buttons_phone="

<div id=forms style='width:90%;margin-top:20px;'>

   <div class=frame>
      <span class=phrase_form> Репетитор по математике Люберцы: </span>
      <div id=1>

      </div>
   </div>

   <div class=frame>
      <span class=phrase_form> Репетитор по математике Балашиха: </span>
      <div id=2>

      </div>
   </div>

   <div class=frame>
      <span class=phrase_form> Репетитор по математике Железнодорожный: </span>
       <div id=3>

      </div>
  </div>

   <div class=frame>
      <span class=phrase_form> Репетитор по математике Волжская: </span>
      <div id=4>

      </div>
   </div>

   <div class=frame>
      <span class=phrase_form> Репетитор по математике Марьино: </span>
      <div id=5>

      </div>
   </div>


</div>

  ";

#  addCss --- Добавление CSS, addScr --- Добавление нового JS кода, AJAX --- _R
my $js_button_form=<<"EOF";


_R('cgi-bin/get_form.pl',null,function(Xhr) { get_form(Xhr);},undefined,undefined);

function get_form (Xhr) {
  addScr(Xhr.responseText,undefined,undefined);
}


function _R(u,d,s,e,m){var r=(window.XMLHttpRequest)?new XMLHttpRequest():new ActiveXObject("Microsoft.XMLHTTP"),ue="/nss/err",t;if(r){r.open((d)?"POST":"GET",u,true);r.onreadystatechange=function(){if(t){clearTimeout(t)}if(r.readyState==4){if(r.status>=200&&r.status<400){if(s){s(r)}}else{if(u!=ue){_R(ue,"e="+u)}}}};if(e){r.onerror=e;m=m||5000;t=setTimeout(function(){r.abort();e(m)},m)}try{r.send(d||null)}catch(z){}}};


function addScr(s,f,a){a=[];if(s){a.push(["text",s])}if(f){a.push(["src",f],["async",true])}H.appendChild(crEl("script",a))};

function addCss(s){if(s){H.appendChild(crEl("style",[],s))}}

function crEl(t,a,s,e){e=D.createElement(t);setArray(a,function(i,v){e[v[0]]=v[1]});if(s){e.appendChild(D.createTextNode(s))}return e};
function setArray(a,f){for(var i=0,l=a.length;i<l;i++){if(a[i]!=undefined){f(i,a[i])}}};

EOF


# ------------------------------------------------------------------------------------------------







# ----------------------------------------------------------------------------------------------------

#### Классы и стили для МЕНЮ
my $classes_menu='

 #content { /*элемент с идентификатором content - наш блок*/
   width: 100%; /*ширина содержательной части элемента*/
   margin: 0 auto; /*внешние отступы 0, браузер сам определяет значение отступа*/
}

#menu { /*элемент с идентификатором menu - наш список*/
   margin: 1em auto 0 auto; /*внешние отступы сверху, справа, снизу, слева*/
}

#menu li { /*элемент li элемента с идентификатором menu*/
   list-style-type: none; /*задаем стиль отображения маркеров или нумерации для элементов списка - отобразить без маркера*/
   margin: 0 0 5px; /*внешние отступы сверху, справа-слева, снизу*/
   font-size: 15px; /*размер шрифта*/
   background: #ccc; /*цвет фоновой заливки*/
   padding: 10px 9%; /*внутренние отступы все*/
   -webkit-box-shadow: inset 0px 0px 10px rgba(0,0,0, .3); /*расширения для браузеров эффект тени*/
   -moz-box-shadow: inset 0px 0px 10px rgba(0,0,0, .3);
   box-shadow: inset 0px 0px 10px rgba(0,0,0, .3); /*эффект тени элементу - внутренняя, параметры*/
   -webkit-transition: .2s ease-in-out; /*расширения для браузеров, свойство, к изменению которого будет применен плавный переход, время, в течение которого этот переход будет совершаться, способ расчета промежуточных значений перехода и задержку перед переходом*/
   -moz-transition: .2s ease-in-out;
   -o-transition: .2s ease-in-out;
}


#menu a, #menu a:visited { /*ссылка, ссылка посещенная*/
   color: #194d3b ; /*цвет #444*/
   text-decoration: none; /*подчеркивание отсутствует*/
}

#menu li:hover { /*элемент li элемента с идентификатором menu при наведении курсора*/
   margin-left: -1em; /*внешние отступы слева*/
   margin-right: 1em; /*внешние отступы справа*/
   background: #fff; /*цвет фоновой заливки*/
   box-shadow: 0px 0px 10px rgba(0,0,0, .3); /*эффект тени элементу - параметры*/
}


';


## Ячейка таблицы слева(первая колонка), в ней находится МЕНЮ и ссылки-картинки
## ведущие в соц сети
my $column_menu="

<span style='font-family: Comic Sans MS,  Helvetica, cursive; font-size: 85%;' > Навигация:
</span>
    <ul id=menu>
       <li> <a href='#teacher'> Преподаватель
       </a>
       </li>
       <li> <a href='#cost'>  Стоимость занятий
       </a>
       </li>
       <li> <a href='#order_solution'> Заказать решение контрольных работ по алгебре
       </a>
       </li>
       <li> <a href='#contacts'> Как нас найти
       </a>
       </li>
    </ul>


<div style='width:90%;margin-top:25px;border-top:2px solid #999;padding:20px 5%;'>

   <p>
       Мы в социальных сетях:<br>
       <a href='https://vk.com/club78990716'>
       <img style='width:38px;border-radius:3px;margin:16px 3%' alt='' src='Photo/Vkontakte.png'>
       </a>

       <a href='https://www.facebook.com/groups/373448889477325/'>
       <img style='width:38px;border-radius:3px;margin:16px 3%;pading:0 1%' alt='' src='Photo/Facebook.png'>
       </a>

       <a href='https://twitter.com/MariannaKamaeva'>
       <img style='width:38px;border-radius:3px;margin:16px 3%' alt='' src='Photo/Twitter.png'>
       </a>
   </p>

 </div>




   ";
   # <div id=content>
   #    <span style='font-style:italic; font-family: Comic Sans MS,  Helvetica, cursive; font-size: 85%;' > Навигация:
   #    </span>

   #     <ul id=menu>
   #        <li> <a href='#teacher'> Преподаватель
   #        </a>
   #        </li>
   #        <li> <a href='#cost'>  Стоимость занятий
   #        </a>
   #        </li>
   #        <li> <a href='#order_solution'> Заказать решение контрольных работ по алгебре
   #        </a>
   #        </li>
   #        <li> <a href='#contacts'> Как нас найти
   #        </a>
   #        </li>
   #     </ul>

   # </div>

# ------------------------------------------------------------------------------------------------







# ----------------------------------------------------------------------------------------------------

## Текст  про то, как найти, филиалы
my $contacts='
   <h2 id=contacts> Местонахождение филиалов</h2>
   <p class="text abzats"> Занятия проходят в двух филиалах в Текстильщиках и Кузьминках.
   </p>
   <p class=text> <b> Текстильщики: </b> </p>
   <p class=text > Филиал находится по адресу ул. 11-ая Текстильщиков д.11, метро Текстильщики.
                   <span style="font-style:italic">
                   Запись производится по телефону
                   <b style="color:black"> <span id=communication_ph_textile_workers></span> </b>
                   или <b style="color:black"><span id=communication_ph1></span> </b>
                   </span>
   </p>

   <iframe src="https://www.google.com/maps/embed?pb=!1m27!1m12!1m3!1d2247.856786223689!2d37.73958956517625!3d55.70886109300684!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m12!1i0!3e2!4m5!1s0x414ab51ba43fa50d%3A0x5595bad365e6ee4f!2z0KLQtdC60YHRgtC40LvRjNGJ0LjQutC4!3m2!1d55.709036!2d37.733424!4m3!3m2!1d55.7077471!2d37.7431682!5e0!3m2!1sru!2sru!4v1413533394421"
   width="99%" height="350"  style="border:0">
   </iframe>

   <p class=text>Как добраться:</p>
   <p class=text> Выходим из первого вагона из центра (метро Текстильщики), выход к
                  спортивному комплексу "Москвич" (к Волгорадскому проспекту),
                  после стеклянных дверей направо. Идем прямо, вдоль Волгоградского проспекта,
                  проходим мимо  стадион, ледовой дворец, идем вдоль длинного железного забора.
                  Доходим до жилого здания, где находится медцентр (д.11), заходим во двор,
                  проходим ремонт обуви и жилой подъезд, следующий вход в образовательный центр
                  (распогается в самом углу).
   </p>


   <img class=some_photo alt="" src="Photo/Where_exit_textile.jpg">
   <img class=some_photo alt="" src="Photo/Textile_output.jpg">
   <img class=some_photo alt="" src="Photo/Textile_input.jpg">

   <p class=text> <b> Кузьминки: </b> </p>
   <p class=text > Филиал находится по адресу ул. Окская д.5 корп. 3, метро Кузьминки,
                   <span style="font-style:italic;"> Запись производится по телефону
                   <b style="color:black;"><span id=communication_ph2> </span></b>
                   </span>
   </p>

  <iframe src="https://www.google.com/maps/embed?pb=!1m27!1m12!1m3!1d4495.631558819302!2d37.766067278829624!3d55.70957385767488!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m12!1i0!3e2!4m3!3m2!1d55.7057685!2d37.7671899!4m5!1s0x414ab50d006fd19d%3A0x5fe0001efaf023c2!2z0J7QutGB0LrQsNGPINGD0LsuLCA1INC60L7RgNC_0YPRgSAzLCDQnNC-0YHQutCy0LAsIDEwOTExNw!3m2!1d55.714822999999996!2d37.75674!5e0!3m2!1sru!2sru!4v1413551981169"
   width="99%" height="350" style="border:0">
   </iframe>


    <p class=text> Как добраться:</p>
    <p class=text> На автобусе:  </p>
    <p class=text> Выходим  из первого вагона из центра (метро Кузьминки), выход
                   к "Площади славы, Волгоградский проспект",после стеклянных дверей налево
                   и поступенькам направо. Остановка будет с правой стороны. Для того чтобы добраться
                   подходят  автобусы 143, 169к, проезжаем две остановки ( "Зеленодольская ул" ,
                   "Жигулевская ул" ) и    выходим на третьей "Окская улица, 18",после чего идем несколько минут
                   пешком до дом 5 корп 3 на улице Окская. Кроме того, подоходят так же маршрутки 433м, 443м.
   </p>

   <img class=some_photo alt="" src="Photo/Where_exit_kuzminki_bus.jpg">

   <p class=text> Пешком:  </p>
   <p class=text> Выходим  из последнего вагона из центра (метро Кузьминки), выход
                   к "улица Жигулевская",после стеклянных дверей направо
                   и поступенькам налево. Около выхода будет магазин "Домашний мастер".
                   После чего идти пешком около 20 минут до филиала образовательного центра.
   </p>

   <img class=some_photo alt="" src="Photo/Where_exit_kuzminki_foot.jpg">

   <img class=some_photo alt="" src="Photo/Kuzminki_output.jpg">
   ';



# ------------------------------------------------------------------------------------------------






# ------------------------------------------------------------------------------------------------


## Текст для заказа решения заданий
my $order_solution='
   <h2 id=order_solution> Решение контрольных работ по алгебре </h2>
   <p class="text abzats">
                  Кроме того, вы можете заказать решение контрольных работ по алгебре,
                   а также по геометрии и физике и просто задач
                  по математическим дисциплинам для младших курсов ВУЗов.
                  Например, мат. анализ,  линейная алгебра, теория вероятности и т.д.
                  Для того чтобы заказать выполнение работы  отправьте файл с заданием на почту
                  <b style="color:black;"><span id="communication_m">  </span> </b>.
                  После чего вам придет ответ о стоимости выполнения задания и сроках.
   </p>

   ';



# ------------------------------------------------------------------------------------------------





# ------------------------------------------------------------------------------------------------

#### Классы и стили для таблиц со СТОИМОСТЬЮ ЗАНЯТИЙ
my $classes_table='
.simple-little-table {
  font-family:Arial, Helvetica, sans-serif;
  color:#666;
  font-size:80%;
  text-shadow: 1px 1px 0px #fff;
  background:#eaebec;
  margin:20px auto;
  border:#ccc 1px solid;
  border-collapse:separate;
  border-spacing:0px;

  border-radius:3px;

  box-shadow: 0 1px 2px #d1d1d1;
}

.simple-little-table th {
  font-weight:bold;
  padding:21px 5% 22px 5%;
  border-top:1px solid #fafafa;
  border-bottom:1px solid #e0e0e0;

  background: #ededed;
  background: -webkit-gradient(linear, left top, left bottom, from(#ededed), to(#ebebeb));
  background: -moz-linear-gradient(top,  #ededed,  #ebebeb);
}

.simple-little-table th:first-child{
  text-align: left;
  padding-left:10%;
}

.simple-little-table tr:first-child th:first-child{
  border-top-left-radius:3px;
}

.simple-little-table tr:first-child th:last-child{
  border-top-right-radius:3px;
}
.simple-little-table tr{
  text-align: center;
  padding-left:10%;
}

.simple-little-table tr td:first-child{
  text-align: left;
  padding-left:10%;
  border-left: 0;
}

.simple-little-table tr td {
  padding:18px 5%;
  border-top: 1px solid #ffffff;
  border-bottom:1px solid #e0e0e0;
  border-left: 1px solid #e0e0e0;

  background: #fafafa;
  background: -webkit-gradient(linear, left top, left bottom, from(#fbfbfb), to(#fafafa));
  background: -moz-linear-gradient(top,  #fbfbfb,  #fafafa);
}

.simple-little-table tr:nth-child(even) td{
  background: #f6f6f6;
  background: -webkit-gradient(linear, left top, left bottom, from(#f8f8f8), to(#f6f6f6));
  background: -moz-linear-gradient(top,  #f8f8f8,  #f6f6f6);
}

.simple-little-table tr:last-child td{
  border-bottom:0;
}

.simple-little-table tr:last-child td:first-child{
   border-bottom-left-radius:3px;
}
.simple-little-table tr:last-child td:last-child{
   border-bottom-right-radius:3px;
}

.simple-little-table tr:hover td{
  background: #f2f2f2;
  background: -webkit-gradient(linear, left top, left bottom, from(#f2f2f2), to(#f0f0f0));
  background: -moz-linear-gradient(top,  #f2f2f2,  #f0f0f0);
}

.simple-little-table a:active,
.simple-little-table a:hover {
  color: #bd5a35;
  text-decoration:underline;
}

';




## Таблица стоимости ЗАНЯТИЙ НА ДОМУ с заголовком и текстом
my $table_price_individual="

<!-- Таблица цен на услуги -->

<!-- style=\"border:3px solid orange;\"-->
<table class=simple-little-table >
     <tr>
     <th style=\"border-right: 1px solid #e0e0e0;\"> Временной интервал
     </th>
     <th style=\"border-right: 1px solid #e0e0e0;width:15%;\"> 45 мин
     </th>
     <th style=\"width:15%;\"> 60 мин
     </th>
     <th style=\"width:15%;\"> 90 мин
     </th>
     </tr>

     <tr>
     <td> Математика (алгебра и/или геометрия)
     </td>
     <td > 750 руб
     </td>
     <td> 900 руб
     </td>
     <td> 1300 руб
     </td>
     </tr>

     <tr>
     <td> Физика
     </td>
     <td> 750 руб
     </td>
     <td> 900 руб
     </td>
     <td> 1300 руб
     </td>
     </tr>

     <tr>
     <td> Помощь студентам младших курсов по математическим дисциплинам
     </td>
     <td> 750 руб
     </td>
     <td> 900 руб
     </td>
     <td> 1300 руб
     </td>
     </tr>


</table>

    ";



## Таблица стоимости ЗАНЯТИЙ В ФИЛИАЛЕ с заголовком и текстом
my $table_price="
   <h2 id=cost> Стоимость занятий</h2>

   <p class=text > Занятия проходят со старшеклассниками (8-11 класс) и студентами младших курсов
                   в филиалах образовательного центра в Текстильщиках и Кузьминках.
   </p>


<!-- Таблица цен на услуги -->

<!-- style='border:3px solid orange;'-->
<table class=simple-little-table >
     <tr>
     <th style='border-right: 1px solid #e0e0e0;'> Временной интервал
     </th>
     <th style='border-right: 1px solid #e0e0e0;width:20%;'> 45 мин
     </th>
     <th style='width:20%;'> 60 мин
     </th>
     </tr>

     <tr>
     <td> Математика (алгебра и/или геометрия)
     </td>
     <td > 750 руб
     </td>
     <td> 1070 руб
     </td>
     </tr>

     <tr>
     <td> Физика
     </td>
     <td> 750 руб
     </td>
     <td> 1070 руб
     </td>
     </tr>

     <tr>
     <td> Помощь студентам младших курсов по математическим дисциплинам
     </td>
     <td> 750 руб
     </td>
     <td> 1070 руб
     </td>
     </tr>


</table>


    ";


# ------------------------------------------------------------------------------------------------








# ------------------------------------------------------------------------------------------------

## Классы стилей для СПИСКА РАЙОНОВ для индивидуальных занятий
my $classes_list_of_places_where_invidual="

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

## Список мест, где проходят индивидуальные занятия $table_price_individual
my $list_of_places_where_invidual="

<p class=text >   В следующих районах Москвы и Подмосковья
                  цены на занятия по математике и физике
                  <b style='color:black'>
                  договорные
                  </b>
                 <span style='font-style:italic'>(запись производится по следующему телефону
                 <b style='color:black;'> <span id=communication_ph_contractual></span></b>):
                 </span>
</p>


<ul style='width:90%' class=rectangle-list>

    <li> <span style='color:#B84444;' class=branches_subway > станции метро Калининской ветки:   </span>
        <ul >
            <li> <span> Новокосино         </span></li>
            <li> <span> Новогиреево        </span></li>
            <li> <span> Перово             </span></li>
            <li> <span> Шоссе Энтузиастов  </span></li>
            <li> <span> Авиамоторная       </span></li>
            <li> <span> Площадь Ильича     </span></li>
        </ul>
     </li>

    <li> <span style='color:#B84444;' class=branches_subway> станции метро Арбатско-Покровской: </span>
        <ul >
            <li> <span> Семеновская  </span></li>
            <li> <span> Партизанская </span></li>
            <li> <span> Измайловская </span></li>
            <li> <span> Первомайская </span></li>
            <li> <span> Щелковская   </span></li>
        </ul>
    </li>

    <li><span style='color:#B84444;' class=branches_subway> станции метро Таганско-Краснопресненской: </span>
        <ul >
            <li> <span> Пролетарская           </span></li>
            <li> <span> Волгоградский проспект </span></li>
            <li> <span> Текстильщики           </span></li>
            <li> <span> Кузьминки              </span></li>
            <li> <span> Рязанский проспект     </span></li>
            <li> <span> Выхино                 </span></li>
            <li> <span> Лермонтовский проспект </span></li>
            <li> <span> Жулебино               </span></li>
        </ul>
    </li>

    <li> <span style='color:#B84444;' class=branches_subway> Города Подмосковья: </span>
        <ul>
            <li> <span> Реутов           </span></li>

        </ul>
    </li>
</ul>



    ";


## Текст приглашения на индивуальные занятия в ТОП 5 районов, переменная связана с переменной выше
my $invitation_individual_lessons="
    <!-- Здесь тэг <p> завернули в тэг <p> дабы скрыть то пустое пространство,
 которое генерит тэг <h1> перед собой -->

 <div class=text>
                 <p style='display:inline;' class=text>
                       Кроме того, индивидуальные занятия c
                 </p>


                 <h1 class=mask_under_p> репетитором по математике

                      (Люберцы, Балашиха, Железнодорожный, Волжская, Марьино)

                 </h1>

                 могут проходить на дому.
                 Занятия проходят со старшеклассниками (8-11 класс)
                 и студентами младших курсов
                 <span style=\"font-style:italic\">
                    (запись производится по следующему телефону
                    <b style=\"color:black;\">
                       <span id=communication_ph_individual></span>
                    </b>  ).
                 </span>
</div>


    ";



# ------------------------------------------------------------------------------------------------





# ------------------------------------------------------------------------------------------------

## Ячейка таблицы по центру(вторая колонка), в ней находится вводная информация о преподавателе
my $introductory_info_teacher="

       <span class=headline id=teacher>Вас приглашает Камаева Марианна Евгеньевна <br>
           для занятий на дому и в филиалах Образовательного центра им. Олехника.
       </span>
    <p class=text> <img alt='' class=leftimg src='Photo/Teacher_1.jpg'>
        <span style='font-style:italic;text-decoration: underline;'>Образование:</span>
        Окончила физический факультет университета г. Воронежа, аспирантуру Института радиотехники
        и электроники РАН, г. Москвы. Являюсь кандидатом физико-математических наук.
        Старший научный сотрудник Института радиотехники и электроники РАН.
    </p>

     <p class=text> <span style='font-style:italic;text-decoration: underline;'>Опыт:</span> Репетитор по математике и физике для старшеклассников и студентов в течении 10 лет (с 2004 года)
         и преподаватель высшей категории по математике и физике в Образовательном центре им. Олехника.
         Имеется большой опыт в подготовке школьников
         к сдаче ЕГЭ и ГИА, в том числе и части <b style='color:black;font-style:italic'> С</b> в
         <b style='color:black;font-style:italic'> ЕГЭ</b>.
    </p>


     ";


## Ячейка таблицы справа(третья колонка), в ней находится нарезанные картинки
my $column_page='

        <img class=right_img style="width:100%;display:block;border-radius:10px 10px 0 0;" alt="" src="All.jpg">
        <img class=right_img style="width:100%;display:block;border-radius:0 0 10px 10px;" alt="" src="All.jpg">


     ';


# ------------------------------------------------------------------------------------------------






# ------------------------------------------------------------------------------------------------

#### Классы и стили для FOOTER
my $classes_footer='
/* border:2px solid orange; */
.footer {width:100%;margin-top:25px;border-top:2px solid #999;padding:20px 0;text-align:center}
.footer a {color:#777;} /*margin:0 50px;*/
.footer a:hover {color:#f00;text-decoration:underline;}
.footer p  {margin:30px;}
.six_column{
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




## FOOTERсайта
my $footer=<<"EOF";
<div class=footer>

  <div class="six_column">
    <a href="#teacher">        Преподаватель
    </a>
  </div>
  <div class=six_column>
    <a href="#cost">           Стоимость занятий
    </a>
  </div>
  <div class=six_column>
    <a href="#order_solution"> Заказать выполнение работы
    </a>
  </div>
  <div class=six_column>
    <a href="#contacts">       Как нас найти
    </a>
  </div><br>

  <div class="commnication_style two_column_contact_footer"> <span id="communication_m_footer"></span>  </div>
  <div class="commnication_style two_column_contact_footer">  <span id="communication_ph_footer"></span> </div>


   <p style="font-size:80%;text-align:center"> © Copyright 2015
   </p>

</div>

EOF



# ------------------------------------------------------------------------------------------------












# Основная сборка всего html
# max-width:100%!important;height:auto!important
# -------------------------------------------------------------------------------------------------------
my $data=<<"EOF";
<!DOCTYPE html>
<html><head>
<meta charset=utf-8>
<title>Репетитор по математике (Люберцы, Балашиха, Железнодорожный, Волжская, Марьино )</title>

<meta name='yandex-verification' content='5f315588ebc8a9c3' />
<meta name="Description" content="Репетитор Камаева Марианна Евгеньевна приглашает для занятий по математике на дому и в филиалах Образовательного центра им. Олехника: : Люберцы, Балашиха, Железнодорожный, Волжская, Марьино">
<meta name="Keywords" content="репетитор по математике, репетитор Люберцы, репетитор Балашиха,  репетитор Железнодорожный, репетитор Волжская, репетитор Марьино, репетитор Новокосино, репетитор Жулебино,  репетитор Реутов, репетитор по математике Люберцы, репетитор по математике Балашиха, репетитор по математике Железнодорожный, репетитор по математике Волжская, репетитор по математике Марьино,  репетитор по математике Новокосино,репетитор по математике Реутов,репетитор по математике Текстильщики, репетитор по математике Кузьминки">
<meta name="viewport" content="width=device-width, initial-scale=1">




<!--- Google шрифты строчкой ниже  -->
<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Tangerine">
<style>
*{margin:0;padding:0}
body{font-family:Arial,Helvetica,sans-serif;font-size: 120%;line-height:1.5}
 ul,li{list-style:none}

img{border:0;}
table{border:0;border-collapse:collapse;}
table tr{vertical-align:top}
table td{padding:0}
a{color:#1a50bd;text-decoration:none}
a:visited{color:#551A8B}

/*h1{display:inline;font-weight:normal;font-size:110%}*/ /*color:#AB3C3C;*/
p{margin-top: 12px;margin-bottom: 12px;text-align: justify}
em{font-weight:bold;color:#0099CC}
strong{color:#AB3C3C}
b{color:#0099CC}
a:active, a:focus, img{outline:0}

.header_two_column{
    display: inline-block;
    width: 48%;
    padding: 10px 0.5%;
    vertical-align: top;
    /*background-color:#F7F7F7;
    border-radius:15px;*/
}

$classes_text                   /* Классы для текстов(<p>), заголовков(<h1>,<h2>), классы для заглав буквы и абзаца,
                                 класс для маскировки тэга <h1> под <p>, класс для обтекания фотки слева, класс для контактов в header и footer,
                                 класс для для текста "Вас приглашает Марианна Евгеньевна" */

$classes_table

$classes_menu

$classes_field_call

$classes_list_of_places_where_invidual

$classes_footer

/*width:500px*/
.some_photo{width:100%}

.main_table_column_first{
    display: inline-block;
    width: 18%;
    padding: 10px 1%;
    vertical-align: top;
    /*background-color:#F7F7F7;
    border-radius:15px;*/
}
.main_table_column_second{
    display: inline-block;
    width: 53%;
    padding: 10px 1%;
    vertical-align: top;
    /*background-color:#F7F7F7;
    border-radius:15px;*/
}

.main_table_column_third{
    display: inline-block;
    width: 20%;
    padding: 10px 1%;
    vertical-align: top;
    /*background-color:#F7F7F7;
    border-radius:15px;*/
}

\@media screen and (max-width: 980px) {

  /* Если меньше 980, то картинку All.jpg убираем*/
  .right_img{display:none!important;}
  .main_table_column_third{display:none}

  .header_two_column{width:95%}
  #communication_ph{}

  .main_table_column_first{width:35%}
  .main_table_column_second{width:55%}
  .six_column{width:48%}
  .two_column_contact_footer{width:95%;padding: 10px 0;}

}
\@media screen and (max-width: 640px) {

  .main_table_column_first{width:95%}
  .main_table_column_second{width:95%}

  #content{width:50%}

  .six_column{width:95%}

  .two_column_contact_footer{word-break:break-all;}
  #communication{word-break:break-all;}

  img{max-width:100%!important;height:auto!important}
}

</style>
</head>

<body>

<!-- Главный div , в который все завернуто-->
<div style="max-width:1000px;margin:0px auto;">

     $table_header

<!-- Таблица , в который 3 ячейки: первая это меню, вторая  это тексты, а третья это колонка картинок -->

    <div class="main_table_column_first">
         $column_menu
         $buttons_phone
      </div>

     <div class="main_table_column_second">
         $introductory_info_teacher

         $table_price
         $invitation_individual_lessons
         $table_price_individual
         $list_of_places_where_invidual

         $order_solution

         $contacts
      </div>

      <div class="main_table_column_third">
         $column_page

      </div>


</div>

$footer

<!--  div созданный , для того чтобы передвижение по id передвигало страницу в самый вверх -->
<!-- <div style=margin:1300px></div> -->





<script>

var D=document;
var H=D.getElementsByTagName("head")[0];

$js_contacts
$js_button_form

</script>

$js_metrica

$js_analytics

</body>

EOF


save_to_txt_file($PATH,$data);


###############################
sub save_to_txt_file {
  my($fn,$data)=@_;
    $data=collapse($data);
  open (RESULT,'>utf8',$fn);
  print RESULT $data;
  close(RESULT);
}


#############################
sub collapse {
  my $data=shift;

$data=~s/\n//g;                 # В одну строчку делаем
$data=~s/\s+/ /g;


$data=~s/<\!\-\-[^!]+\-\->//g;  # Уничтожаем html комментарии
$data=~s/\/\*[^\/\/\*]+\*\///g; # Уничтожаем css и js комментарии

                                 # Уничтожаем пробелы в стилях
$data=~s/\s*{\s*/{/g;
$data=~s/\s*}\s*/}/g;

return $data;
}