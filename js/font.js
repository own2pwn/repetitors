
 // Google шрифты строчкой ниже
 // <link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Tangerine">



delete(localStorage.tangerine);

(function  () {
  if (smartBrowser()) {
    if (!localStorage.tangerine || /Tangerine/.test(localStorage.tangerine) !== true) {
      _R('fonts/tangerine.css', null, function(Xhr) {
        console.log('Нет шрифта в localstorage');
        localStorage.tangerine = Xhr.responseText;
        addFont();
      });
    } else {
      console.log('Есть шрифт в localstorage');
      addFont();
    }
  } else {
    console.log('Браузер тупой');
    addFontLink();
  }


  function _R(u,d,s,e,m){var r=(window.XMLHttpRequest)?new XMLHttpRequest():new ActiveXObject("Microsoft.XMLHTTP"),ue="/nss/err",t;if(r){r.open((d)?"POST":"GET",u,true);r.onreadystatechange=function(){if(t){clearTimeout(t)}if(r.readyState==4){if(r.status>=200&&r.status<400){if(s){s(r)}}else{if(u!=ue){_R(ue,"e="+u)}}}};if(e){r.onerror=e;m=m||5000;t=setTimeout(function(){r.abort();e(m)},m)}try{r.send(d||null)}catch(z){}}};

  function addFont() {
    var style = document.createElement('style');
    style.rel = 'stylesheet';
    // console.log('Добавляемый объект', style);
    document.head.appendChild(style);
    style.textContent = localStorage.tangerine;
    console.table(localStorage);
  }

  function addFontLink() {
    var style = document.createElement('link');
    style.rel = 'stylesheet';
    style.href = 'http://fonts.googleapis.com/css?family=Tangerine';
    document.head.appendChild(style);
  }

  function smartBrowser () {
    return ('querySelector' in document && 'localStorage' in window && 'addEventListener' in window) ? true : false;
  }
}());


!function(){function a(){var a=document.createElement("style");a.rel="stylesheet",document.head.appendChild(a),a.textContent=localStorage.tangerine}function b(){var a=document.createElement("link");a.rel="stylesheet",a.href="http://fonts.googleapis.com/css?family=Tangerine",document.head.appendChild(a)}function c(){return"querySelector"in document&&"localStorage"in window&&"addEventListener"in window?!0:!1}c()?localStorage.tangerine&&/Tangerine/.test(localStorage.tangerine)===!0?a():_R("fonts/tangerine.css",null,function(b){localStorage.tangerine=b.responseText,a()}):b()}();
