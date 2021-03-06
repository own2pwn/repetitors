package base_teachers;
use strict;

# ДАННЫЕ О ПРЕПОДАВАТЕЛЯ

# my %CONTEXT = ('min' => 1);
# start(\%CONTEXT,'footer');

#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  base_teachers($refCONTEXT,$key);
  # my %hash_teach = %{$CONTEXT{$key}};
  # my $refarr = $hash_teach{1} -> {'branch_price'};
  # print "$refarr\n";
  # print "Ключ 1 $hash_teach{1}->{'branch_price'}\n";
  # print "$refarr->[0]->[2]\n";


}




# ----------------------------------------------------- ХЭШ С НЕКОТОРЫМИ ДАННЫМИ О ПРЕПОДАВАТЕЛЕ -------------------------------------------------------------
sub base_teachers {
  my ($refCONTEXT,$key) = @_;

  my %base_teachers = ();
  $base_teachers{1} = { 'name'        => 'Marianna',
                        'rusFullName' => 'Марианна Камаева',
                        'subject'     => 'mathematics',
                        'branch_price' => [ ['Временной интервал',                  '45 мин','60 мин'],
                                            ['Математика (алгебра и/или геометрия)','850 руб','1270 руб'],
                                            ['Физика',                              '850 руб','1270 руб'],
                                            ['Помощь студентам младших курсов
                                              по математическим дисциплинам',       '850 руб','1270 руб'],
                                          ],
                        'discount' => '<b style="color:red">*</b> При единовременной оплате 5 занятий по 60 или 90 минут предоставляется скидка 10%.',
                        'individual_price' => [ ['Временной интервал',                  '45 мин','60 мин','90 мин'],
                                                ['Математика (алгебра и/или геометрия)','950 руб','1500 руб','2000 руб'],
                                                ['Физика',                              '950 руб','1500 руб','2000 руб'],
                                                ['Помощь студентам младших курсов
                                                  по математическим дисциплинам',       '950 руб','1500 руб','2000 руб']
                        ],
                        'list_districts' => {'станции метро Калининской линии'                => ['Новокосино','Новогиреево','Перово','Шоссе Энтузиастов','Авиамоторная','Площадь Ильича'],
                                             'станции метро Арбатско покровской линии'        => ['Семеновская','Партизанская','Измайловская','Первомайская','Щелковская'],
                                             'станции метро Таганско-Краснопресненской линии' => ['Пролетарская','Волгоградский проспект','Текстильщики','Кузьминки','Рязанский проспект','Выхино','Лермонтовский проспект','Жулебино'],
                                             'города Подмосковья'                             => ['Реутов'],
                        },
                        'key_regions' => {'call_Lyubertsy'          => ['Репетитор по математике Люберцы:',          'регион Люберцы'],
                                          'call_Balashiha'          => ['Репетитор по математике Балашиха:',          'регион Балашиха'],
                                          'call_Zheleznodorozhnyiy' => ['Репетитор по математике Железнодорожный:', 'регион Железнодорожный'],
                                          'Reutov'                  => ['Репетитор по математике Реутов:',                  'регион Реутов'],
                                          'Novokosino'              => ['Репетитор по математике Новокосино:',              'регион Новокосино'],
                        },
                        'key_regions_sort_order' => ['call_Lyubertsy',
                                                     'call_Zheleznodorozhnyiy',
                                                     'Reutov',
                                                     'Novokosino',
                                                     'call_Balashiha',
                                                     ]
                        ,
                        'teacher_menu' => [['О преподавателе',  '#teacher'],
                                           ['Стоимость занятий','#cost'],
                                           ['Заказать решение
                                             контрольных
                                             работ по алгебре', '#order_solution'],
                                           ['Как нас найти',    '#contacts']
                        ],
                         };

  $base_teachers{2} = { 'name'        => 'Ludmila',
                        'rusFullName' => 'Людмила Макаровна',
                        'subject'     => 'russian_language',
                        'branch_price' => [ ['Временной интервал',                  '45 мин','60 мин'],
                                            ['Русский язык и литература',           '750 руб','1070 руб'],
                                            ['Помощь студентам младших курсов
                                              по русскому языку',                    '750 руб','1070 руб']
                                          ],
                        'individual_price' => [ ['Временной интервал',           '45 мин','60 мин','90 мин'],
                                                ['Русский язык и литература',     '––',    '––',   '1500 руб'],
                                                ['Помощь студентам младших курсов
                                                  по русскому языку',             '––',    '––',   '1500 руб']
                        ],
                        'list_districts' => {'станции метро Сокольнической линии'            =>  ['Тропарево','Юго-Западная','Проспект Вернадского','Университет','Спортивная'],
                                             'станции метро Серпуховско-Тимирязевской линии' =>  ['Бульвар Дмитрия Донского','Аннино','Улица академика Янгеля','Пражская','Южная'],
                                             'станции метро Бутовской линии'                 =>  ['Лесопарковая','Улица Старокачаловская','Бульвар адмирала Ушакова'],
                                             'города Подмосковья'                            =>  ['Мамыри','Газопровод','Коммунарка','Сосенки'],
                        },
                        'key_regions' => {'Yasenevo'      => ['Репетитор по русcкому языку Ясенево:',     'регион Ясенево'],
                                          'Konkovo'       => ['Репетитор по русcкому языку Коньково:',      'регион Коньково'],
                                          'Teply_Stan'    => ['Репетитор по русcкому языку Теплый Стан:',   'регион Теплый Стан'],
                                          'Belyaevo'      => ['Репетитор по русcкому языку Беляево:',     'регион Беляево'],
                                          'Profsoyuznaya' => ['Репетитор по русcкому языку Профсоюзная:','регион Профсоюзная'],
                        },
                        'key_regions_sort_order' => ['Konkovo',
                                                     'Yasenevo',
                                                     'Teply_Stan',
                                                     'Belyaevo',
                                                     'Profsoyuznaya',
                                                     ]
                        ,
                        'teacher_menu' => [['О преподавателе',  '#teacher'],
                                           ['Стоимость занятий','#cost'],
                                           ['Заказать сочинение или эссе
                                             по русскому
                                             языку (литературе)','#order_solution'],
                                           ['Как нас найти',    '#contacts']
                        ],
                         };

  $base_teachers{3} = { 'name' => 'Eduard',
                        'rusFullName' => 'Эдуард Ни',
                        'subject'     => 'english_language',
                        'branch_price' => [ ['Временной интервал',        '45 мин','60 мин'],
                                            ['Английский язык',           '850 руб','1000 руб'],
                                            ['Помощь студентам
                                              по английскому языку',      '850 руб','1000 руб']
                                          ],
                        'individual_price' => [ ['Временной интервал',     '45 мин','60 мин','90 мин'],
                                                ['Английский язык',        '950',    '1100',   '1500 руб'],
                                                ['Помощь студентам
                                                  по английскому языку',   '950',    '1100',   '1500 руб']
                        ],
                        'list_districts' => {'станции метро Люблинско-Дмитровской линии:' =>     ['Крестьянская застава', 'Дубровка', 'Кожуховская', 'Печатники', 'Волжская', 'Люблино'],
                                             'города Подмосковья'                            =>  ['Люберцы','Котельники'],
                        },
                        'key_regions' => {'Textile'            => ['Репетитор по английскому языку Текстильщики:',     'регион Текстильщики'],
                                          'Kuzminki'           => ['Репетитор по английскому языку Кузьминки:',      'регион Кузьминки'],
                                          'Ryazan_prospectus'  => ['Репетитор по английскому языку Рязанский проспект:',   'регион Рязанский проспект'],
                                          'Vykhino'            => ['Репетитор по английскому языку Выхино:',     'регион Выхино'],
                                          'Zhulebino'          => ['Репетитор по английскому языку Жулебино:','регион Жулебино'],
                        },
                        'key_regions_sort_order' => [
                                                     'Zhulebino',
                                                     'Vykhino',
                                                     'Ryazan_prospectus',
                                                     'Kuzminki',
                                                     'Textile',
                                                     ]
                        ,
                        'teacher_menu' => [['О преподавателе',  '#teacher'],
                                           ['Стоимость занятий','#cost'],
                                           ['Заказать решение
                                             тестов по
                                             английскому языку','#order_solution'],
                                           ['Как нас найти',    '#contacts']
                        ],
                         };

  $base_teachers{4} = { 'name'        => 'Nadezhda',
                        'rusFullName' => 'Палиева Надежда',
                        'subject'     => 'mathematics',
                        'branch_price' => [ ['Временной интервал',                  '45 мин', '60 мин','90 мин'],
                                            ['Математика (алгебра и/или геометрия)','800 руб','1000 руб','1500 руб'],
                                            ['Помощь студентам младших курсов
                                              по математическим дисциплинам',       '900 руб','1100 руб','1600 руб']
                                          ],
                        'discount' => '<b style="color:red">*</b> При единовременной оплате 5 занятий по 60 или 90 минут предоставляется скидка 10%.',
                        'individual_price' => [ ['Временной интервал',                  '45 мин','60 мин','90 мин'],
                                                ['Математика (алгебра и/или геометрия)','1000 руб','1300 руб','1900 руб'],
                                                ['Помощь студентам младших курсов
                                                  по математическим дисциплинам',       '1100 руб','1000 руб','2000 руб']
                        ],
                        'list_districts' => {'станции метро Калининской линии'                => ['Новокосино','Новогиреево','Перово','Шоссе Энтузиастов','Авиамоторная','Площадь Ильича', 'Таганская'],
                                             'станции метро Таганско-Краснопресненской линии' => ['Текстильщики','Кузьминки','Рязанский проспект','Выхино','Лермонтовский проспект','Жулебино'],
                                             'cтанции метро Сокольнической линии'             => ['Бульвар Рокоссовского','Черкизовская','Преображенская площадь','Сокольники'],
                                             'города Подмосковья'                             => ['Реутов','Балашиха','Люберцы','Железнодорожный','Кучино','Котельники'],
                        },
                        'key_regions' => {'Textile'     => ['Индивидуальный репетитор по алгебре и геометрии Текстильщики:',    'регион Текстильщики'],
                                          'Kuzminki'    => ['Индивидуальный репетитор по алгебре и геометрии Кузьминки:',   'регион Кузьминки'],
                                          'Novogireevo' => ['Индивидуальный репетитор по алгебре и геометрии Новогиреево:','регион Новогиреево'],
                                          'Perovo'      => ['Индивидуальный репетитор по алгебре и геометрии Перово:',     'регион Перово'],
                                          'Reutov'      => ['Индивидуальный репетитор по алгебре и геометрии Реутов:',     'регион Реутов'],
                        },
                        'key_regions_sort_order' => [
                                                     'Reutov',
                                                     'Novogireevo',
                                                     'Textile',
                                                     'Kuzminki',
                                                     'Perovo',
                                                     ]
                        ,
                        'teacher_menu' => [['О преподавателе',  '#teacher'],
                                           ['Стоимость занятий','#cost'],
                                           ['Заказать решение
                                             контрольных
                                             работ по алгебре и геометрии','#order_solution'],
                                           ['Как нас найти',    '#contacts']
                        ],
                         };

  $base_teachers{5} = { 'name'        => 'Yuri',
                        'rusFullName' => 'Жушманов Юрий',
                        'subject'     => 'mathematics',
                        'branch_price' => [ ['Временной интервал',                  '45 мин', '60 мин','90 мин'],
                                            ['Алгебра и/или геометрия',             '900 руб','1100 руб','1700 руб'],
                                            ['Помощь студентам
                                              по математическим дисциплинам',       '1000 руб','1100 руб','1800 руб']
                                          ],
                        'discount' => '<b style="color:red">*</b> При единовременной оплате 5 занятий по 60 или 90 минут предоставляется скидка 10%.',
                        'individual_price' => [ ['Временной интервал',                  '45 мин',  '60 мин',  '90 мин'],
                                                ['Алгебра и/или геометрия',             '1100 руб','1400 руб','2000 руб'],
                                                ['Помощь студентам
                                                  по математическим дисциплинам',       '1300 руб','1400 руб','2000 руб']
                        ],
                        'list_districts' => {'станции метро Калининской линии'                => ['Новогиреево','Новокосино','Перово','Шоссе Энтузиастов','Авиамоторная','Площадь Ильича', 'Таганская'],
                                             'станции метро Таганско-Краснопресненской линии' => ['Рязанский проспект','Выхино','Лермонтовский проспект','Жулебино','Текстильщики','Кузьминки',],
                                             'cтанции метро Арбатско-Покровской линии'        => ['Щелковская','Первомайская','Измайловская','Партизанская','Семеновская','Электрозаводская','Курская'],
                                             'города Подмосковья'                             => ['Реутов','Люберцы','Железнодорожный','Кучино','Котельники'],
                        },
                        'key_regions' => {'Kuzminki'    => ['Репетитор по математике и геометрии Кузьминки:',   'регион Кузьминки'],
                                          'Textile'     => ['Репетитор по математике и геометрии Текстильщики:',    'регион Текстильщики'],
                                          'Novogireevo' => ['Репетитор по математике и геометрии Новогиреево:','регион Новогиреево'],
                                          'Perovo'      => ['Репетитор по математике и геометрии Перово:',     'регион Перово'],
                                          'Kozhukhovo'  => ['Репетитор по математике и геометрии Кожухово:', 'регион Кожухово'],
                        },
                        'key_regions_sort_order' => [
                                                     'Kuzminki',
                                                     'Kozhukhovo',
                                                     'Novogireevo',
                                                     'Textile',
                                                     'Perovo',
                                                     ]
                        ,
                        'teacher_menu' => [['О преподавателе',  '#teacher'],
                                           ['Стоимость занятий','#cost'],
                                           ['Заказать решение
                                             контрольных
                                             работ по алгебре(геометрии)','#order_solution'],
                                           ['Как нас найти',    '#contacts']
                        ],
                         };


  $refCONTEXT -> {$key} = \%base_teachers;

}
1;