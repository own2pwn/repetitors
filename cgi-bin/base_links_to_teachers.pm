package base_links_to_teachers;
#!/usr/bin/perl
use strict;

# ЗАГЛОВКИ ДЛЯ ССЫЛОК НА ПРЕПОДАВАТЕЛЯ

# my %CONTEXT = ('min' => 1);
# start(\%CONTEXT,'footer');

#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  base_links_to_teachers($refCONTEXT,$key);
  # my %hash_teach = %{$CONTEXT{$key}};
  # foreach my $e (keys %hash_teach) {
  #   print "text $hash_teach{$e}->{title}\n";
  # }

}




# ----------------------------------------------------- ХЭШ С ДАННЫМИ ДЛЯ ССЫЛКИ НА ПРЕПОДАВАТЕЛЯ -------------------------------------------------------------
sub base_links_to_teachers {
  my ($refCONTEXT,$key) = @_;

  my %base_links = ();
  $base_links{1} = { title      => 'Репетитор по математике в г. Реутов',
                     subject    => 'mathematics',
                     desription => 'Всегда найдет индивидуальный подход к каждому ученику,
                                    как школьнику, так и к студенту. Подготовка к ОГЭ (ГИА) и ЕГЭ
                                    по математике и физике основана не на дрессировке для решения заданий
                                    определенного типа, а на понимании теорем, формул и основных физических
                                    явлений. Демократична в общении с учениками и родителями.'
                   };
  $base_links{2} = { title      => 'Репетитор по русскому языку и литературе (Ясенево, Коньково, Теплый Стан, Беляево, Профсоюзная)',
                     subject    => 'russian_language',
                     desription => 'Профессионал высокого уровня,
                                    имеюший 25-летний опыт работы учителем русского языка в школе.
                                    Может подготовить к сдаче ГИА и ЕГЭ в рекордно короткие сроки.'
                   };
  $base_links{3} = { title      => 'Репетитор по английскому языку (Текстильщики, Кузьминки, Рязанский проспект, Выхино, Жулебино)',
                     subject    => 'english_language',
                     desription => 'Имеет опыт преподавания английского языка в лингвистическом лицее.
                                    На занятиях уделяет особое внимание грамматике и разговорной практике.
                                    Педантичен и профессионален.'
                   };

  $base_links{4} = { title      => 'Индивидуальный репетитор по алгебре и геометрии (Люберцы, Балашиха, Железнодорожный, Реутов, Новокосино)',
                     subject    => 'mathematics',
                     desription => 'Молодой, но энергичный и креативный преподаватель.
                                    Постоянно повышает свою педагогическую квалификацию.
                                    Всегда открыта для неформального общения с учениками и их родителями.'
                   };

  $base_links{5} = { title      => 'Репетитор по математике и геометрии (Реутов, Балашиха, Железнодорожный, Новокосино, Люберцы, Кожухово)',
                     subject    => 'mathematics',
                     desription => 'Преподаватель, получивший образование в одном из лучших ВУЗов страны и имеющий солидный
                                    опыт подготовки школьников к олимпиадам, выпускным и вступительным экзаменам.
                                    С учениками суров, но справедлив.'
                   };

  $refCONTEXT -> {$key} = \%base_links;
  $refCONTEXT -> {$key.'_sort_order'} = [1,2,3,4,5];

}
1;