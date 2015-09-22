package form_order_call_teachers;
#!/usr/bin/perl
use strict;
use 5.010;
use Data::Dumper;

my %CONTEXT = ('min' => 1);

# use lib './';
# use base_types_forms;
# base_types_forms::start(\%CONTEXT,'base_types_forms');
# start(\%CONTEXT,'footer');

# ФОРМА ЗАКАЗА ЗВОНКА ДЛЯ РАЗМЕЩЕНИЯ ПРЕПОДАВАТЕЛЯ

#########################
sub start {
  my ($refCONTEXT,$key) = @_;

  form_order_call($refCONTEXT,$key);
  # print $CONTEXT{$key}{'html'};
  # print $CONTEXT{$key}{'css'};
  # print $CONTEXT{$key}{'js'};
}




# ----------------------------------------------------- ФОРМА ЗАКАЗА ЗВОНКА(ДЛЯ РАЗМЕЩЕНИЯ ПРЕПОДАВАТЕЛЯ) -------------------------------------------------------------
sub form_order_call {
  my ($refCONTEXT,$key) = @_;

  my $hash_types_forms = $refCONTEXT -> {'base_types_forms'} || {};
  my $sort_order       = $refCONTEXT -> {'base_types_forms_sort_order'} || [];
  # my $teacher_id = $refCONTEXT -> {'teacher'};
  # say Dumper($hash_types_forms);

  # border-top:2px solid #999;
  my $html_form_order_call =
  "<div id=forms style='width:90%;margin-top:20px;'>";

  foreach my $id (@$sort_order) {
    my $text = $hash_types_forms->{$id} -> [0];
    $html_form_order_call.= "
    <div class=frame>
        <span class=phrase_form> $text </span>
        <div id=$id>
        </div>
    </div>\n";
  }
  $html_form_order_call.= "</div>\n";
  # print "$html_form_order_call\n";
  # exit;


  my $css_form_order_call = '
  /* Оформление текста для заказа звонка */
  .phrase_form {font-family: "Comic Sans MS",cursive;font-size: 90%;font-style:italic;}

  /* Бордер(серая рамка), отступы(внутри и снаружи), ширина, для формы заказа звонка */
  .frame {
        border-radius:15px;
        border:2px solid #bbb;
        width:100%;
        margin:45px auto 45px 5%;
        padding:25px 2%;
      }
  ';

  # для формы, где можно ввести предмет при заказе звонка
  # добавляем класс, чистим value, добавляем placeholder,
  # визуализируем поле
  my $js_form_order_call =<<"EOF";
  _R('aj_get_form_place_teachers.pl',null,function(Xhr) { get_form(Xhr);},undefined,undefined);

  function get_form (Xhr) {
    addScr(Xhr.responseText,undefined,undefined);
    var subject_input = getByID('summary_any_subject_sub');
    subject_input.className   = 'form_style';
    subject_input.value       = '';
    subject_input.placeholder ='Введите предмет';
    subject_input.type        = 'inline';
  }


  function _R(u,d,s,e,m){var r=(window.XMLHttpRequest)?new XMLHttpRequest():new ActiveXObject("Microsoft.XMLHTTP"),ue="/nss/err",t;if(r){r.open((d)?"POST":"GET",u,true);r.onreadystatechange=function(){if(t){clearTimeout(t)}if(r.readyState==4){if(r.status>=200&&r.status<400){if(s){s(r)}}else{if(u!=ue){_R(ue,"e="+u)}}}};if(e){r.onerror=e;m=m||5000;t=setTimeout(function(){r.abort();e(m)},m)}try{r.send(d||null)}catch(z){}}};


  function addScr(s,f,a){a=[];if(s){a.push(["text",s])}if(f){a.push(["src",f],["async",true])}H.appendChild(crEl("script",a))};

  function addCss(s){if(s){H.appendChild(crEl("style",[],s))}}

  function crEl(t,a,s,e){e=D.createElement(t);setArray(a,function(i,v){e[v[0]]=v[1]});if(s){e.appendChild(D.createTextNode(s))}return e};
  function setArray(a,f){for(var i=0,l=a.length;i<l;i++){if(a[i]!=undefined){f(i,a[i])}}};
EOF

  my $js_form_order_call_min ='
  ';
  $js_form_order_call = ( $refCONTEXT -> {'min'} == 1 ) ? $js_form_order_call_min : $js_form_order_call;
  $refCONTEXT -> {$key} -> {'css'} = $css_form_order_call;
  $refCONTEXT -> {$key} -> {'html'} = $html_form_order_call;
  $refCONTEXT -> {$key} -> {'js'} = $js_form_order_call;
}
1;