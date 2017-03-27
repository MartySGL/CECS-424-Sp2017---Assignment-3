%%%-------------------------------------------------------------------
%%% @author Marty
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. mars 2017 15:22
%%%-------------------------------------------------------------------

-module(main).

-author("Marty").

-export([main/1]).
-export([func1/1]).
-export([func2/2]).
-export([func3/1]).

% Parse the file
func1(Filename) ->
  {ok,IoDevice} = file:open(Filename, [read]),
  string:tokens(io:get_line(IoDevice,""), " ,.()\"\\<=>-0123456789").

% operation on tuple list
func2(Word, List) ->
  case lists:keyfind(Word, 1, List) of
    false ->
      lists:append(List, [{Word, 1}]);
    Data ->
      lists:keyreplace(Word, 1, List, {Word, element(2, Data) + 1})
  end.

func3(WordLst) ->
  lists:foldl(fun(X, TList) -> func2(string:to_lower(X), TList) end, [], WordLst).

main(Filename) ->
  List = func1(Filename),
  TList = func3(List),
  TListSorted = lists:sort(fun({KeyA,ValA}, {KeyB,ValB}) -> {ValA,KeyA} >= {ValB,KeyB} end, TList),
  io:format("~p", [TListSorted]).

