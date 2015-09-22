package base_types_forms;
use strict;

# ДАННЫЕ О ТИПАХ(ПРЕДМЕТАХ) ФОРМЫ ДЛЯ РАЗМЕЩЕНИЯ ПРЕПОДАВАТЕЛЯ

# my %CONTEXT = ('min' => 1);
# start(\%CONTEXT,'footer');

#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  base_types_forms($refCONTEXT,$key);
  # my %hash_teach = %{$CONTEXT{$key}};
  # my $refarr = $hash_teach{1} -> {'branch_price'};
  # print "$refarr\n";
  # print "Ключ 1 $hash_teach{1}->{'branch_price'}\n";
  # print "$refarr->[0]->[2]\n";


}




# ----------------------------------------------------- ХЭШ С НЕКОТОРЫМИ ДАННЫМИ О ПРЕПОДАВАТЕЛЕ -------------------------------------------------------------
sub base_types_forms {
  my ($refCONTEXT,$key) = @_;

  my %base_types_forms = (
    'summary_mathematics_physics'  => ['Разместить резюме репетитора по математике (алгебре/геометрии) или физике:', 'математика (алгебра/геометрия) или физика'],
    'summary_russian_language'     => ['Разместить резюме репетитора по русскому языку (литературе):',               'русский язык (литература)'],
    'summary_english_language'     => ['Разместить резюме репетитора по английскому языку:',                         'английский язык'],
    'summary_any_subject'          => ['Разместить резюме репетитора по любому предмету:',                         ''],
                       );

  $refCONTEXT -> {$key} = \%base_types_forms;

  $refCONTEXT -> {$key.'_sort_order'} =
    [
     'summary_any_subject',
     'summary_mathematics_physics',
     'summary_russian_language',
     'summary_english_language',
    ];

}
1;