import 'package:flutter/material.dart';
import 'package:movie_search_app/data/movie_api_provider.dart';
import 'package:movie_search_app/presenter/presenter.dart';
import 'package:movie_search_app/repository/movie_repository.dart';
import 'package:movie_search_app/view/view.dart';

class MainPageImpl extends StatefulWidget {
  @override
  _MainPageImplState createState() => _MainPageImplState();
}

class _MainPageImplState extends State<MainPageImpl> implements IMainPage{
  
  IMainPresenter _presenter;
  TextEditingController _textSearch = new TextEditingController();
  List<Map> result = [];
  String _query = "car";

  void initState(){
    super.initState();
    MovieAPIProviderImpl api = MovieAPIProviderImpl();
    this._presenter = MainPresenterImpl(MovieRepositoryImpl(api));
    this._presenter.setView(this);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies")
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Padding(
                      padding:
                          EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                      child: TextField(
                        controller: this._textSearch,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ))),
              Expanded(
                  flex: 1,
                  child: Padding(
                      padding:
                          EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                      child: RaisedButton(
                        child: Text("pesquisar",
                        style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).buttonColor
                        ),
                        ),
                        onPressed: () {
                          debugPrint("on click search");
                          this.onClickSearch();
                        },
                      )
                  )
              )
            ],
          ),
          Expanded(child: 
             FutureBuilder(
               future: this._presenter.findMovieByName(this._query),
               
               builder: (context, snapshot){
                 debugPrint("> ${snapshot.data}");
                 if(snapshot.hasError){
                   return Center(child: Text("${snapshot.error}"));
                 }
                 if(snapshot.hasData){
                   return this.getMovieList(snapshot.data);
                 }
                 return Center(child:CircularProgressIndicator(
                   strokeWidth: 2,
                 ));
               },
            )
          )  
        ],
      ),
    );
  }

  Widget getMovieList(List data){
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index){
        return this.getMovieItemList(data[index], index);
      }
    );
  }

  Widget getMovieItemList(Map data, int index){
    return ListTile(
      leading: Icon(Icons.movie),
      title: Text(data["title"]),
      subtitle: Text(data["overview"]),
      onLongPress: (){
        this.onClickMovie(data["id"]);
      },
    );
  }

  @override
  void onClickMovie(int id) {
    // TODO: implement onClickMovie
  }

  @override
  void onClickSearch() {
    this._query = this._textSearch.text;
    setState(() {
      
    });
    
  }
}