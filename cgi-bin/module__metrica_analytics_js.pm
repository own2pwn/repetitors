package module__metrica_analytics_js;
#!/usr/bin/perl
use strict;

# Яндекс Метрика и Google Analytics, оформлены отедельными скриптами

#########################
sub start {
  my ($refCONTEXT,$key) = @_;

  metrica_analytics_js($refCONTEXT,$key);
  # print $CONTEXT{$key}{'js'};
}




# ----------------------------------------------------- Яндекс Метрика и Google Analytics и Рамблер ТОП-100 -------------------------------------------------------------
sub metrica_analytics_js {
  my ($refCONTEXT,$key) = @_;


  my $js_metrica_analytics =<<"EOF";
  <!-- Yandex.Metrika counter -->
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

  <script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-56326628-1', 'auto');
    ga('send', 'pageview');

  </script>

  <div id='Rambler-counter' style='opacity:0'>
  <!-- Внимание! В этом div'е не нельзя размещать пользовательский контент: он будет затерт! -->
  <noscript>
  <a href="http://top100.rambler.ru/navi/3123099/">
    <img src="http://counter.rambler.ru/top100.cnt?3123099" alt="Rambler's Top100"/>
  </a>
  </noscript>
  </div>

  <!-- Код скрипта должен быть размещен строго ниже контейнера для логотипа (div c id='Rambler-counter') -->
  <script type="text/javascript">
  var _top100q = _top100q || [];
  _top100q.push(['setAccount', '3123099']);
  _top100q.push(['trackPageviewByLogo', document.getElementById('Rambler-counter')]);

  (function(){
    var pa = document.createElement("script");
    pa.type = "text/javascript";
    pa.async = true;
    pa.src = ("https:" == document.location.protocol ? "https:" : "http:") + "//st.top100.ru/top100/top100.js";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(pa, s);
  })();
  </script>


EOF


  my $js_metrica_analytics_min ='
  ';
  $js_metrica_analytics = ( $refCONTEXT -> {'min'} == 1 ) ? $js_metrica_analytics_min : $js_metrica_analytics;
  $refCONTEXT -> {$key} -> {'js'} = $js_metrica_analytics;
}
1;