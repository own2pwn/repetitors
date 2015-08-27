/*jshint sub: true*/
/*jshint loopfunc: true */
/*jshint newcap: false */
/*jshint multistr: true */

"use strict";

// АСИНХРОННАЯ ЗАГУРУЗКА VK API


async_load_script();
function async_load_script() {
  var script = document.createElement("script");
  script.src = "//vk.com/js/api/openapi.js?117";
  document.body.appendChild(script);
  script.onload =function() {
    VK.init({apiId: 5046123, onlyWidgets: true});
    VK.Widgets.Comments("vk_comments", {limit: 10, width: "665", attach: "*"});
  }
}

// ВАРИАНТ КОГДА СУЩЕСТВУЕТ СОБЫТИЕ addEventListener
// if (window.addEventListener) {
//   window.addEventListener("load", async_load_script, false);
// } else if (window.attachEvent) {
//   window.attachEvent("onload", async_load_script);
// } else {
//   window.onload = async_load_script;
// }