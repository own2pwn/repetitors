
/*jshint sub: true*/
/*jshint loopfunc: true */
/*jshint newcap: false */
/*jshint multistr: true */


// Образец вызова setCookie(name, value, daysToLive, path, domain);
// setCookie('us_name','John',4,'/','127.0.0.1');


// Сохраняет пару имя/значение в виде cookie, кодируя значение с помощью
// encodeURIComponent(), чтобы экранировать точки с запятой, запятые и пробелы.
// Если в параметре daysToLive передается число, атрибут max-age
// устанавливается так, что срок хранения cookie истекает через
// указанное число дней. Если передать значение 0, cookie будет удален

function setCookie(name, value, daysToLive, path, domain) {
  var cookie = name + "=" + encodeURIComponent(value);

  if (typeof daysToLive === "number"){
    cookie += "; max-age=" + (daysToLive * 60 * 60 * 24);
  } else {
    throw new Error(' Параметр daysToLive должен быть числом. ');
  }
  cookie += "; path=" + path;
  cookie += "; domain=" + domain;

  // Добавляем последную ;
  cookie += ";";
  document.cookie = cookie;

}

// console.log(d.cookie);

// console.log(getCookie());


// Функция getCookie(); возвращает хэш, где ключ хэша это name cookie, а значение это value cookie

function getCookie() {

  // Возвращаемый объект
  var cookies = {};
  // Получить все cookies в одной строке
  var all = document.cookie;
  if (all === '') {
    return cookies;
  }

  // Массив где каждая элемент это name=value
  var arrayPairCookies = all.split(/;\s*/);

  // Массив, где каждый элемент это массив, содержащий ключ и значение
  var arrayOneCookies = [];
  for (var i = 0; i < arrayPairCookies.length; i++) {
    arrayOneCookies.push(arrayPairCookies[i].split('='));
  }

  for (var j = 0; j < arrayOneCookies.length; j++) {
    var key = arrayOneCookies[j][0];
    var value = arrayOneCookies[j][1];
    cookies[key] = value;
  }

  return cookies;
}

// Минифицированные версии
function setCookie(o,e,n,t,a){var i=o+"="+encodeURIComponent(e);if("number"!=typeof n)throw new Error(" Параметр daysToLive должен быть числом. ");i+="; max-age="+60*n*60*24,i+="; path="+t,i+="; domain="+a,i+=";",document.cookie=i}
function getCookie(){var r={},t=document.cookie;if(""===t)return r;for(var e=t.split(/;\s*/),o=[],n=0;n<e.length;n++)o.push(e[n].split("="));for(var i=0;i<o.length;i++){var u=o[i][0],a=o[i][1];r[u]=a}return r}

