

    /**
     * [getByID –– по переданному id возврщает объект DOMа]
     * @param  {[type –– string]} id [ id элемента]
     * @return {[type –– object]}    [ Объект DOMa]
     */
    function getByID (id) {
        return  document.getElementById(id);
    }

    /**
     *  Пример вызова drawBorders(0);
     * [drawBorders –– Функция рисует бордеры рандомного цвета вокруг элементов]
     * \@param  {[type–– digit]} trigger [Если trigger === 1, то рисуем бордеры]
     */
    function drawBorders(trigger) {
        if (trigger===1) {
            [].forEach.call(document.querySelectorAll("*"),function(a){a.style.outline="2px solid #"+(~~(Math.random()*(1<<24))).toString(16)})
        }
    }

    // Even delegation: передаем событие event
   function handlerEventDelegation (e) {
        var t = e && e.target || e.srcElement;
        // console.log(t);
        return t;
        // f_callback(t);
    }

    // ИЛИ со всплытием до элемента c id
    function handlerEventDelegationToId(e) {
        var t = e && e.target || e.srcElement;
        while (t && !t.id) {
            t = t.parentNode
        } // Поднимаемся пока нет id
        console.log(t);
    }

    // TOUCH устройство или нет
    function IsTouchDevice() {
         return ('ontouchstart' in window) || ('onmsgesturechange' in window);
     };

     // Получить номер нажатой клавиши
     function getNumberClavizhi(e) {
       // Кнопка вниз 40, вверх 38
       var key = e.keyCode || e.charCode;
       // console.log('событие event ', e);
       // console.log('номер клавиши ', key);
       return key;
     }