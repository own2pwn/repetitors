/** @jsx React.DOM */


var SearchRes = React.createClass({
  render : function() {
    // console.log(' this.props ', this.props.oneTeacher);
    var teachers     = this.props.result;
    var searchString = this.props.searchStr;
    if (teachers.length !== 0) {
      return(
        <div>
          { teachers.map(function(t){
            return (
              <div key={t.id}>
               <p><img src={t.img} alt=""/></p>
                <p>
                  <a href={t.url} dangerouslySetInnerHTML={{__html: rep(searchString, t.title)}}></a>
                  {t.desc}
                </p>
              </div>
            );
           }) }
         </div>
      );
    }
    else {return(<p>Поиск не дал результатов</p>);}
  }
});

var SearchTeachers = React.createClass({

    getInitialState: function(){
        return { searchString: '' };
    },

    handleChange: function(e){
        this.setState({searchString:e.target.value});
    },

    render: function() {

        var teachers = this.props.items,
            searchString = this.state.searchString.trim().toLowerCase();
        if(searchString.length > 0){
            // Ищем. Фильтрируем резальтаты.
            teachers = teachers.filter(function(t){
                // return l.name.match( new RegExp(searchString,'ig') );
                return t.title.toLowerCase().match( searchString );
            });
        }
        return(
          <div>
            <input type="text" value={this.state.searchString} onChange={this.handleChange} placeholder="Type here" autofocus="on" />
            <SearchRes result={teachers} searchStr={searchString}/>
          </div>
        );
    }
});


function rep(searchString, teacher_title) {
  if (searchString !== '') {
    teacher_title = teacher_title.replace(new RegExp('('+searchString+')','ig'),'<b>$1</b>');
  }
  return teacher_title;
}

var teachers = [
  { title: 'Репетитор по математике (Люберцы, Балашиха, Железнодорожный, Волжская, Марьино)',                          id: 1, img: 'http://127.0.0.1/common_teacher/1_teacher/1_image_face.jpg', desc: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Suscipit quia excepturi accusantium consequuntur libero possimus perferendis, hic! Perspiciatis blanditiis non officia, omnis, soluta reiciendis quas similique id, fugiat aspernatur sunt.', url: 'http://documentcloud.github.io/backbone/'},
  { title: 'Репетитор по русскому языку и литературе (Ясенево, Коньково, Теплый Стан, Беляево, Профсоюзная)',          id: 2, img: 'http://127.0.0.1/common_teacher/2_teacher/2_image_face.jpg', desc: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Hic voluptatem labore et laborum. Et non eaque asperiores voluptatibus id, soluta laboriosam, dolorum rerum ut in porro totam, similique quaerat quibusdam.', url: 'https://angularjs.org/'},
  { title: 'Репетитор по английскому языку (Текстильщики, Кузьминки, Рязанский проспект, Выхино, Жулебино)',           id: 3, img: 'http://127.0.0.1/common_teacher/3_teacher/3_image_face.jpg', desc: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quam magni qui facilis quis ipsum ad amet aut illum asperiores iusto, obcaecati, voluptates, at quia. Maiores ab quis quia itaque, nesciunt?', url: 'http://jquery.com/'},
  { title: 'Индивидуальный репетитор по алгебре и геометрии (Люберцы, Балашиха, Железнодорожный, Реутов, Новокосино)', id: 4, img: 'http://127.0.0.1/common_teacher/4_teacher/4_image_face.jpg', desc: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptas temporibus eius quidem, consequuntur labore tenetur dignissimos reprehenderit possimus reiciendis alias aspernatur tempore in mollitia officiis nemo omnis obcaecati ut numquam.', url: 'http://www.prototypejs.org/'},
];

  React.render(
      <SearchTeachers items={ teachers } />,
      document.getElementById('example')
  );





