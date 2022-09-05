abstract class NewsStates{}

class NewsInitialState extends NewsStates{}

class NewsChangeBottomNavBarState extends NewsStates{}

class NewsLoadingState extends NewsStates{}

class NewsGetBusinessSuccessState extends NewsStates{}

class NewsGetBusinessErrorState extends NewsStates{

  final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsSuccessState extends NewsStates{}

class NewsGetSportsErrorState extends NewsStates{

  final String error;

  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceSuccessState extends NewsStates{}

class NewsGetScienceErrorState extends NewsStates{

  final String error;

  NewsGetScienceErrorState(this.error);
}

class ChangeThemeModeState extends NewsStates{}