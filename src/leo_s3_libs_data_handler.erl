%%======================================================================
%%
%% Leo S3-Libs
%%
%% Copyright (c) 2012 Rakuten, Inc.
%%
%% This file is provided to you under the Apache License,
%% Version 2.0 (the "License"); you may not use this file
%% except in compliance with the License.  You may obtain
%% a copy of the License at
%%
%%   http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing,
%% software distributed under the License is distributed on an
%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%% KIND, either express or implied.  See the License for the
%% specific language governing permissions and limitations
%% under the License.
%%
%% ---------------------------------------------------------------------
%% Leo Libs - ETS/Mnesia Data Handler
%% @doc
%% @end
%%======================================================================
-module(leo_s3_libs_data_handler).

-author('Yosuke Hara').

-include_lib("eunit/include/eunit.hrl").

-export([all/1, lookup/2, insert/2, delete/2, size/1]).


%% Retrieve all records from the table.
%%
-spec(all({mnesia|ets, atom()}) ->
             tuple() | list() | {error, any()}).
all({mnesia, Table}) ->
    case catch mnesia:ets(fun ets:tab2list/1, [Table]) of
        {'EXIT', Cause} ->
            {error, Cause};
        [] ->
            not_found;
        List ->
            NewList = lists:map(fun(Item) ->
                                        Item
                                end, List),
            {ok, NewList}
    end;
all({ets, Table}) ->
    case catch ets:tab2list(Table) of
        {'EXIT', Cause} ->
            {error, Cause};
        [] ->
            not_found;
        List ->
            NewList = lists:map(fun({_, Item}) ->
                                        Item
                                end, List),
            {ok, NewList}
    end.


%% Retrieve a record by key from the table.
%%
-spec(lookup({mnesia|ets, atom()}, integer()) ->
             tuple() | list() | {error, any()}).
lookup({mnesia, Table}, Id) ->
    case catch mnesia:ets(fun ets:lookup/2, [Table, Id]) of
        [Value|_] ->
            {ok, Value};
        [] ->
            not_found;
        {'EXIT', Cause} ->
            {error, Cause}
    end;
lookup({ets, Table}, Id) ->
    case catch ets:lookup(Table, Id) of
        [{_,Value}|_] ->
            {ok, Value};
        [] ->
            not_found;
        {'EXIT', Cause} ->
            {error, Cause}
    end.


%% @doc Insert a record into the table.
%%
insert({mnesia, Table}, {_Id, Value}) ->
    Fun = fun() -> mnesia:write(Table, Value, write) end,
    leo_mnesia_utils:write(Fun),
    true;
insert({ets, Table}, {Id, Value}) ->
    ets:insert(Table, {Id, Value}).


%% @doc Remove a record from the table.
%%
delete({mnesia, Table}, Id) ->
    case catch lookup({mnesia, Table}, Id) of
        {ok, Value} ->
            Fun = fun() ->
                          mnesia:delete_object(Table, Value, write)
                   end,
            leo_mnesia_utils:delete(Fun);
        {'EXIT', Cause} ->
            {error, Cause};
        Error ->
            Error
    end;
delete({ets, Table}, Id) ->
    case catch ets:delete(Table, Id) of
        true ->
            ok;
        {'EXIT', Cause} ->
            {error, Cause}
    end.


%% @doc Retrieve total of records.
%%
size({mnesia, Table}) ->
    mnesia:ets(fun ets:info/2, [Table, size]);
size({ets, Table}) ->
    ets:info(Table, size).

