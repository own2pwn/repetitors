package base_seo_for_place_teach;
use strict;

# КЛЮЧЕВЫЕ СЛОВА (title, keywords,description) и h1
# для PLACE_TEACHERS.PL

# my %CONTEXT = ('min' => 1);
# start(\%CONTEXT,'footer');

#########################
sub start {
  my ($refCONTEXT,$key) = @_;
  base_seo($refCONTEXT,$key);
}




# ----------------------------------------------------- ХЭШ С НЕКОТОРЫМИ ДАННЫМИ О ПРЕПОДАВАТЕЛЕ -------------------------------------------------------------
sub base_seo{
  my ($refCONTEXT,$key) = @_;

  my %base_seo_for_place_teach = (
    h1          => {html => '',},
    title       => {html => meta_tag::title('Разместить резюме репетитора'),},
    keywords    => {html => meta_tag::description(''),},
    description => {html => meta_tag::keywords(''),},
  );

  $refCONTEXT -> {$key} = \%base_seo_for_place_teach;

}
1;