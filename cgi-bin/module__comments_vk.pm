package module__comments_vk;
use strict;

# КОМЕНТАРИИ API VK.COM

# my %CONTEXT = ('min' => 1, 'id' => 1);
# start(\%CONTEXT,'contacts_filials');

#########################
sub start {
  my ($refCONTEXT,$key) = @_;

  comments_vk($refCONTEXT,$key);
  # print $CONTEXT{$key}{html};
  # print $CONTEXT{$key}{css};
  # print $CONTEXT{$key}{js};
}




# ----------------------------------------------------- КОМЕНТАРИИ API vk.com-------------------------------------------------------------
sub comments_vk {
  my ($refCONTEXT,$key) = @_;

  my $html_comments ="
  <div id='#comments' style='text-align:left;margin:30px auto 10px auto;'>
    <span>Отзывы о преподавателе:</span>
  </div>
  <div id='vk_comments'></div>
  ";

  # Изначально ширину можно задавать только в пикселях, делаем чтобы она была в процентах
  my $css_comments ='
  #vk_comments,
  #vk_comments iframe {
      width: 100% !important;
  }
  ';

# Изначальный код API VK.COM

# <!-- Put this script tag to the <head> of your page -->
# <script type="text/javascript" src="//vk.com/js/api/openapi.js?117"></script>
# <script type="text/javascript">
#   VK.init({apiId: 5046123, onlyWidgets: true});
# </script>

# <!-- Put this div tag to the place, where the Comments block will be -->
# <script type="text/javascript">
# VK.Widgets.Comments("vk_comments", {limit: 10, width: "665", attach: "*"});
# </script>


# TODO: 1) Отдельно читать,ужимать и вставлять http://vk.com/js/api/openapi.js?117
#       Ибо данный скрипт очень большой  (не обязательно)
#       2) Не просто вызов кода, а вставка кода в обертке <script type="text/javascript"></script>
#       3) Вставить прелоадер
  my $js_comments =<<"EOF";
<script type="text/javascript">
  setTimeout(function(){async_load_script();},5000);
  function async_load_script() {
    var script = document.createElement("script");
    script.src = "//vk.com/js/api/openapi.js?117";
    document.body.appendChild(script);
    script.onload =function() {
      VK.init({apiId: 5046123, onlyWidgets: true});
      VK.Widgets.Comments("vk_comments", {limit: 10, width: "665", attach: "*"});
    }
  }
</script>
EOF

  my $js_comments_min =<<"EOF";
EOF

  $js_comments = ( $refCONTEXT -> {'min'} == 1 ) ? $js_comments_min : $js_comments;
  $refCONTEXT -> {$key} -> {'css'} = $css_comments;
  $refCONTEXT -> {$key} -> {'html'} = $html_comments;
  $refCONTEXT -> {$key} -> {'js'} = $js_comments;
}
1;