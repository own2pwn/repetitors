

(function  () {

  var maps = ['<iframe src="https://www.google.com/maps/embed?pb=!1m27!1m12!1m3!1d2247.856786223689!2d37.73958956517625!3d55.70886109300684!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m12!1i0!3e2!4m5!1s0x414ab51ba43fa50d%3A0x5595bad365e6ee4f!2z0KLQtdC60YHRgtC40LvRjNGJ0LjQutC4!3m2!1d55.709036!2d37.733424!4m3!3m2!1d55.7077471!2d37.7431682!5e0!3m2!1sru!2sru!4v1413533394421"\
               width="99%" height="350"  style="border:0">\
               </iframe>',
               '<iframe src="https://www.google.com/maps/embed?pb=!1m27!1m12!1m3!1d4495.631558819302!2d37.766067278829624!3d55.70957385767488!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m12!1i0!3e2!4m3!3m2!1d55.7057685!2d37.7671899!4m5!1s0x414ab50d006fd19d%3A0x5fe0001efaf023c2!2z0J7QutGB0LrQsNGPINGD0LsuLCA1INC60L7RgNC_0YPRgSAzLCDQnNC-0YHQutCy0LAsIDEwOTExNw!3m2!1d55.714822999999996!2d37.75674!5e0!3m2!1sru!2sru!4v1413551981169"\
               width="99%" height="350" style="border:0">\
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


// Минификация кода выше (рабочая проверено)
// !function(){for(var a=['<iframe src="https://www.google.com/maps/embed?pb=!1m27!1m12!1m3!1d2247.856786223689!2d37.73958956517625!3d55.70886109300684!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m12!1i0!3e2!4m5!1s0x414ab51ba43fa50d%3A0x5595bad365e6ee4f!2z0KLQtdC60YHRgtC40LvRjNGJ0LjQutC4!3m2!1d55.709036!2d37.733424!4m3!3m2!1d55.7077471!2d37.7431682!5e0!3m2!1sru!2sru!4v1413533394421"               width="99%" height="350"  style="border:0">               </iframe>','<iframe src="https://www.google.com/maps/embed?pb=!1m27!1m12!1m3!1d4495.631558819302!2d37.766067278829624!3d55.70957385767488!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m12!1i0!3e2!4m3!3m2!1d55.7057685!2d37.7671899!4m5!1s0x414ab50d006fd19d%3A0x5fe0001efaf023c2!2z0J7QutGB0LrQsNGPINGD0LsuLCA1INC60L7RgNC_0YPRgSAzLCDQnNC-0YHQutCy0LAsIDEwOTExNw!3m2!1d55.714822999999996!2d37.75674!5e0!3m2!1sru!2sru!4v1413551981169"               width="99%" height="350" style="border:0">               </iframe>'],b=1;2>=b;b++)!function(b){var c=getByID("show_map_"+b);c.onclick=function(){c.style.display="none",getByID("map_"+b).innerHTML=a[b-1]}}(b)}();